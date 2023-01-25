# LambdaDynamoDB

This project contains source code and supporting files for a serverless application that you can deploy with the SAM 
CLI. It includes the following files and folders.

The application uses several AWS resources, including Lambda functions and an API Gateway API. These resources are 
defined in the `template.yaml` file in this project. You can update the template to add AWS resources through the same 
deployment process that updates your application code.


# Git
echo "# Lambda-Dynamo-Api-Gateway" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:Elvis-aws/Lambda-Dynamo-Api-Gateway.git
git push -u origin main

git remote add origin git@github.com:Elvis-aws/Lambda-Dynamo-Api-Gateway.git
git branch -M main
git push -u origin main

# Dependencies
pip3 freeze > requirements.txt

# Docker dynamoDB local debug
source env/bin/bin/activate
pip3 freeze > requirements.txt
cd LambdaDynamoDB
docker-compose up -d
sam build --use-container
sam local start-api


# Deploy dynamoDB 
source env/bin/bin/activate
pip3 freeze > requirements.txt
cd LambdaDynamoDB
docker-compose up -d
sam build
sam deploy --guided


# Virtual env
pip3 install virtualenv
virtualenv env
source env/bin/activate

# Sam CLI
sam build
sam delete
sam deploy
sam init
sam local generate-event
sam local invoke
sam local start-api
sam local start-lambda
sam logs
sam package
sam pipeline bootstrap
sam pipeline init
sam publish
sam sync
sam traces
sam validate
sam build --use-container

# Payload

{
    "first_name":"Lucas",
    "id":0,
    "Department":"QA",
    "Gender":"Female",
    "Position":"Senior",
    "Status":"Married",
    "Age":44,
    "Address":
    {
        "PostCode":"CV1 2JK",
        "Street":"Humbar",
        "HouseNumber": 20
    }

}


