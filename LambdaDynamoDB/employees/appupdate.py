import json
import os
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key
import boto3


def update_employee(event, context):  # Update Employee
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
            employee_age = payload['Age']
            employee_gender = payload['Gender']
            employee_position = payload['Position']
            employee_status = payload['Status']
            employee_postcode = payload['Address']['PostCode']
            employee_street = payload['Address']['Street']
            employee_house_number = payload['Address']['HouseNumber']
            employee_list = employee_table.query(
                KeyConditionExpression=Key('first_name').eq(employee_name)
                                       & Key('id').eq(employee_id))  # Query table and get employee with id

            items = employee_list['Items']  # Get Items as in docs-dynamodb Table

            if len(items) == 0:
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Employee with id: {employee_id} and name: {employee_name} does not exist exist",
                    }),
                }
            else:
                response = employee_table.update_item(
                    Key={
                        'id': employee_id,
                        'first_name': employee_name
                    },
                    UpdateExpression="SET Age = :a, Gender = :g, Ptn = :p, Sts = :s, Address.PostCode = :o, Address.Street = :e, Address.HouseNumber = :h",
                    ExpressionAttributeValues={
                        ':a': employee_age,
                        ':g': employee_gender,
                        ':p': employee_position,
                        ':s': employee_status,
                        ':o': employee_postcode,
                        ':e': employee_street,
                        ':h': employee_house_number,
                    },

                    ReturnValues="UPDATED_NEW"

                )
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": f"Successfully updated Employee: {response}",
                    }),
                }

        else:
            return {
                "statusCode": 200,
                "body": json.dumps({
                    "message": f"Payload can not be empty{response}",
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
