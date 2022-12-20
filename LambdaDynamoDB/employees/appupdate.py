# import json
# import os
# from botocore.exceptions import ClientError
# from boto3.dynamodb.conditions import Key
#
#
# def update_employee(event, context):
#     try:
#         person_id = event['queryStringParameters']['Id']
#         # person_id = event['Id']
#         # person_name = event['Name']
#         person_name = event['queryStringParameters']['Name']
#         request_data_id = person_id
#         if request.method == 'POST':
#             table_name = table_context[0]['name']
#             employee_table = dynamodb.Table(table_name)
#
#             for all_employees in request_data:
#                 employee_name = all_employees['name']
#                 employee_id = all_employees['id']
#                 employee_age = all_employees['age']
#                 employee_address = all_employees['address']
#                 employee_gender = all_employees['gender']
#                 employee_list = employee_table.query(
#                     KeyConditionExpression=Key('id').eq(employee_id)),
#                     ExpressionAttributeNames={
#                         'Name': person_name
#                     }
#                 items = employee_list['Items']
#                 if len(items) == 0:
#                     application.logger.info('Employee does not exist exist')
#                     return f'Employee with ID: {employee_id} does not exist'
#                 response = employee_table.update_item(
#                     Key={
#                         'id': employee_id,
#                         'name': employee_name
#                     },
#                     UpdateExpression="set age=:a,address=:d,gender=:g",
#                     ExpressionAttributeValues={
#                         ':a': employee_age,
#                         ':d': employee_address,
#                         ':g': employee_gender
#
#                     },
#
#                     ReturnValues="UPDATED_NEW"
#
#                 )
#                 application.logger.info('Successfully updated employee')
#             return f'Successfully updated Employee: {employee_name}'
#     except ClientError as ex:
#         application.logger.critical(ex.response)
#         return ex.response
