

************
DynamoDB CLI
************
    --projection-expression
        Specify attributes to retrieve
        We want just a subset
    --filter-expression
        filter items before they are returned
    **********
    pagination
    **********
        --page-size:
            Retrive the full list of items but making many api calls, each call will return items based on 
            page to avoid time out due to large data retrieval default: 1000 items
        --max-item
            Maximum number of items to show in the CLI (returns NextToken)
        --starting-token:
            specifies the last token to retrieve the next set of items






            AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: Image resizing service

Parameters:
  SourceBucketName:
    Type: String
  DestinationBucketName:
    Type: String

Resources:
  ## S3 bucket
  SourceBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Ref SourceBucketName    
  DestinationBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Ref DestinationBucketName   

  ## Lambda function
  ResizerFunction:
    Type: AWS::Serverless::Function 
    Properties:
      CodeUri: src/
      Handler: app.handler
      Runtime: nodejs12.x
      MemorySize: 2048
      Layers:
        - !Sub 'arn:aws:lambda:${AWS::Region}:175033217214:layer:graphicsmagick:2'
      Policies:
        - S3ReadPolicy:
            BucketName: !Ref SourceBucketName
        - S3CrudPolicy:
            BucketName: !Ref DestinationBucketName
      Environment:
        Variables:
          DESTINATION_BUCKETNAME: !Ref DestinationBucketName              
      Events:
        FileUpload:
          Type: S3
          Properties:
            Bucket: !Ref SourceBucket
            Events: s3:ObjectCreated:*
            Filter: 
              S3Key:
                Rules:
                  - Name: suffix
                    Value: '.jpg'     
Outputs:
  SourceBucketName:
    Value: !Ref SourceBucketName
    Description: S3 Bucket for object storage
  DestinationBucketName:
    Value: !Ref DestinationBucketName
    Description: S3 destination Bucket for object storage
  FunctionArn:
    Value: !Ref ResizerFunction
    Description: ResizerFunction function  Arn
