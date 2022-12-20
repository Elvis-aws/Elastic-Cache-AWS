import json
import os
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key
import boto3


def delete_employee(event, context):
    try:
        person_id = event['queryStringParameters']['Id']
        person_name = event['queryStringParameters']['Name']
        request_data_id = person_id
        if request_data_id is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            # Loop through all the items and load each
            employee = employee_table.query(
                KeyConditionExpression=Key('Name').eq(person_name) & Key('Id').eq(int(person_id))
            )
            if employee['Count'] == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"There is no Employee in the Data Base with id: {person_id} and name:{person_name}",
                    }),
                }
            else:
                response = employee_table.delete_item(
                    Key={
                        'Name': person_name,
                        'Id': int(person_id)
                    }
                )
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully deleted Employee: {response}",
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
