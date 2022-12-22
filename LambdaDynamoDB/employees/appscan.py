import json
import os
from botocore.exceptions import ClientError
import boto3


def get_all_employees(event, context):
    try:
        page_size = 3
        employees = None
        if event is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            # Loop through all the items and load each
            employees = employee_table.scan(
                Select="ALL_ATTRIBUTES",
                Limit=page_size
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


def get_employees_address(event, context):
    address = 'Address'
    employees_list = []
    employees = None
    try:
        page_size = 2
        if event is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            # Loop through all the items and load each
            while employees is None or 'LastEvaluatedKey' in employees:
                if employees is not None and 'LastEvaluatedKey' in employees:
                    employees = employee_table.scan(
                        ProjectionExpression=address,
                        Limit=page_size
                    )
                    employees_list.append(employees)
                else:
                    employees = employee_table.scan(ProjectionExpression=address)

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
