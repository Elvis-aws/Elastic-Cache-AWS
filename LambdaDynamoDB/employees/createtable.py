import boto3
from contexts import Context
from botocore.exceptions import ClientError
import json


def create_local_table(event, context):
    """
    Creates a docs-dynamodb table.

    param dyn_resource: Either a Boto3 or DAX resource.
    :return: The newly created table.
    """
    # endpoint_url='http://localhost:8000'
    bool_create_table = True
    dyn_resource = None
    try:
        table_name = 'EmployeesTable'
        Context.table_name = table_name
        dax_table_context = []
        all_tables = []
        if dyn_resource is None:
            dyn_resource = boto3.resource('dynamodb', endpoint_url='http://localhost:8000')
            Context.dynamodb_local = dyn_resource
            for table in dyn_resource.tables.all():
                all_tables.append(table.name)
            if table_name in all_tables:
                print(f"Table {table_name} already exist")
                dax_table_context.append({"first_name": table.name})
                dax_table_context.append({"id": table.table_id})
                dax_table_context.append({"status": table.table_status})
                Context.dynamodb_table = table.name
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": "Table already exist",
                    }),
                }

        table_name = table_name
        params = {
            'TableName': table_name,
            'KeySchema': [
                {'AttributeName': 'first_name', 'KeyType': 'HASH'},  # partition_key
                {'AttributeName': 'id', 'KeyType': 'RANGE'}  # sort_key
            ],
            'AttributeDefinitions': [
                {'AttributeName': 'id', 'AttributeType': 'N'},
                {'AttributeName': 'first_name', 'AttributeType': 'S'}
            ],
            'ProvisionedThroughput': {
                'ReadCapacityUnits': 2,
                'WriteCapacityUnits': 2
            }
        }
        table = dyn_resource.create_table(**params)
        print(f"Creating {table_name}...")
        table.wait_until_exists()
        dax_table_context.append({"first_name": table.name})
        dax_table_context.append({"id": table.table_id})
        dax_table_context.append({"status": table.table_status})
        Context.dynamodb_table = table_name
        print(f"Table {table_name} creating complete")
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "Table creation complete",
            }),
        }
    except ClientError as ex:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": f"{ex}",
            }),
        }
