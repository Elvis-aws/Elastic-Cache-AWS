

***************
DynamoDB Stream
***************
    - DynamoDB Stream can be described as a stream of observed changes in data, technically called a Change Data 
      Capture (CDC)
    - Once enabled, whenever you perform a write operation to the DynamoDB table, like put, update or delete, a 
      corresponding event containing information like which record was changed and what was changed will be saved 
      to the Stream in near-real time
    - Streams consists of Shards  (https://www.youtube.com/watch?v=iHNovZUZM3A)
    - Each Shard is a group of Records, where each record corresponds to a single data modification in the table 
      related to that stream
    - Shards are automatically created and deleted by AWS
    - Shards also have a possibility of dividing into multiple shards, and this also happens without our action
    **********************************
    Characteristics of DynamoDB Stream
    **********************************
        - Stream records can be sent to:
            - Kinesis Data Stream (sent)
            - AWS Lambda (read)
            - Kinesis Client Library (read)
        - Events are stored up to 24 hours
        - Ordered, sequence of events in the stream reflects the actual sequence of operations in the table
        - Near-real time, events are available in the stream within less than a second from the moment of the 
          write operation
        - Deduplicated, each modification corresponds to exactly one record within the stream
        - No operations, like PutItem or UpdateItem that do not change the record are ignored
***********************
DynamoDB Lambda Trigger
***********************
    - DynamoDB Streams work particularly well with AWS Lambda due to its event-driven nature
    - They scale to the amount of data pushed through the stream and streams are only invoked if theres data 
      that needs to be processed

********************************
Filtering DynamoDB Stream events
********************************
    - One of the recently announced features of Lambda function is the ability to filter events, including these 
      coming from a DynamoDB Stream
    - Filtering is especially useful if you want to process only a subset of the events in the stream, e.g. only 
      events that are deleting records or updating a specific entity

"""
aws lambda create-event-source-mapping \
--function-name dynamodb-async-stream-processor \
--batch-size 100 \
--starting-position LATEST \
--event-source-arn arn:aws:dynamodb:us-west-2:111122223333:table/MyTable/stream/2021-05-11T12:00:00.000 \
--filter-criteria '{"Filters": [{"Pattern": "{\"age\": [{\"numeric\": [\"<\", 25]}]}"}]}'

"""

