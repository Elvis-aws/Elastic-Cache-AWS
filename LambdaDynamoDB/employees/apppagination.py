import json
import os
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr
import boto3

"""
- Query results are divided into sets or pages up to 1MB
- You need to find out if there are remaining results after a query
- The query result contains the LastEvaluatedKey pointing to the last processed key
- We achieve our query result when we do not have the LastEvaluatedKey in the result
"""


def get_employees(event, context):
    try:
        person_id = event['queryStringParameters']['id']
        person_name = event['queryStringParameters']['first_name']
        request_data_id = person_id
        response = None
        if request_data_id is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)
            # Loop through all the items and load each
            result = employee_table.query(
                KeyConditionExpression=Key('first_name').eq(person_name),

            )
            while 'LastEvaluatedKey' in result:
                key = result['LastEvaluatedKey']
                last_evaluated_key = key
                result = employee_table.query(
                    KeyConditionExpression=Key('first_name').eq(person_name),
                    ExclusiveStartKey=last_evaluated_key
                )
            if result['Count'] == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"There is no Employee in the Data Base with id: {person_id} and name:{person_name}",
                    }),
                }
            else:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully retrieved Employee: {result}",
                    }),
                }
        else:
            return {
                "statusCode": 400,
                "body": json.dumps({
                    "message": f"Query string must have parameter{response}",
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


