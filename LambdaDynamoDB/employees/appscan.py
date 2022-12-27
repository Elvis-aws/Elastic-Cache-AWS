import json
import os
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr
import boto3


def get_all_employees(event, context):
    try:
        employees = None
        if event is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            # Loop through all the items and load each
            employees = employee_table.scan(
                Select="ALL_ATTRIBUTES"
            )
            if employees['Count'] == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"There are no Employees in the Data Base",
                    }),
                }
            else:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully retrieved Employees: {employees}",
                    }),
                }
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({
                    "message": f"Query string must have parameter {employees}",
                }),
            }

    except ClientError as ex:
        print(ex.response)
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": f"{ex}",
            }),
        }


"""
- Projected expression helps to filter a Scan operation based on the attribute declared
"""


def get_employees_address(event, context):
    address = 'Address'
    try:
        if event is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            employees = employee_table.scan(
                ProjectionExpression=address,
            )

            if employees['Count'] == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"There are no Employees in the Data Base",
                    }),
                }
            else:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully retrieved Employees Addresses: {employees}",
                    }),
                }
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({
                    "message": "Query string must have parameter",
                }),
            }

    except ClientError as ex:
        print(ex.response)
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": f"{ex}",
            }),
        }


"""
- Filter expression helps to filter a Scan operation based on the attribute condition
- Page size will reduce the number of pages being displayed but sam number of api calls will be made
- Page side reduces time outs
"""


def get_employees_department(event, context):
    department = 'Department'
    employees_list = []
    try:
        if event is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            employees = employee_table.scan(
            )

            if employees['Count'] == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"There are no Employees in the Data Base",
                    }),
                }
            else:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully retrieved Employees Addresses: {employees_list}",
                    }),
                }
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({
                    "message": "Query string must have parameter",
                }),
            }

    except ClientError as ex:
        print(ex.response)
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": f"{ex}",
            }),
        }


"""
- limit specifies how many items you wish to receive at a time
- If we still have more items to return, we get a next-token in the results returned
- We then assign the next-token to the starting-token of the next query
"""


def get_employees_department_by_item_size(event, context):
    department = 'Department'
    try:
        if event is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            result = employee_table.scan(
                FilterExpression=Attr(department).begins_with('Q'),
                Limit=1
            )
            while 'nextToken' in result:
                token = result['nextToken']
                next_token = token
                result = employee_table.scan(
                    FilterExpression=Attr(department).begins_with('Q'),
                    StartingToken=next_token
                )

            if result['Count'] == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"There are no Employees in the Data Base",
                    }),
                }
            else:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully retrieved Employees Addresses: {result}",
                    }),
                }
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({
                    "message": "Query string must have parameter",
                }),
            }

    except ClientError as ex:
        print(ex.response)
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": f"{ex}",
            }),
        }
