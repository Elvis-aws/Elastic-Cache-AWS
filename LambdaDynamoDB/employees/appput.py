import json
import os
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key
import boto3


def put_employee(event, context):  # Create Employee
    try:
        body = json.loads(event['body'])  # Extract payload from event
        response = None
        if body is not None:
            table_name = os.getenv('TABLE_NAME')
            dyn_resource = boto3.resource('dynamodb')
            employee_table = dyn_resource.Table(table_name)

            payload = body
            employee_name = payload['first_name']
            employee_id = payload['id']
            employee_list = employee_table.query(
                KeyConditionExpression=Key('first_name').eq(employee_name)
                                       & Key('id').eq(employee_id))  # Query table and get employee with id

            items = employee_list['Items']  # Get Items as in docs-dynamodb Table

            if len(items) != 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Employee with id: {employee_id} and name: {employee_name} already exist",
                    }),
                }
            else:
                employee_table.put_item(Item=payload)
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully created Employees: {employee_name}",
                    }),
                }

        else:
            return {
                "statusCode": 200,
                "body": json.dumps({
                    "message": f"Payload can not be empty {response}",
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

# with product_table.batch_writer() as batch:
#     for record in tqdm.tqdm(data_file]):
#         batch.put_item(Item = record)
