

*******************
DynamoDb Throttling
*******************
    - If we exceed provisioned WCU or RCU, we get ProvisionedThroughputExceededException
    - Hot partitions may be the issue
    - Very lage item size more than capacity provided
*********
Solutions
*********
    - Exponential backoff
    - Distributed key
    - If RCU issue, we can use DynamoDB Accelerator (DAX)