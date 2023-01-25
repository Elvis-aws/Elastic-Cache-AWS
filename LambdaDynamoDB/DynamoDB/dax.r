

***
DAX
***
    - In memory acceleration with DynamoDB Accelerator (DAX)
        - DAX is a DynamoDB compatible caching service
        - Solves the Hot Key problem
        - We can provision nodes up to 10 and supports Multi-AZ
        - 5 mins TTL for cache by default
        - DAX addresses three core scenarios
            - As an in memory cache
                - DAX reduces the response times of eventually consistent read workloads
            - DAX reduces operational and application complexity 
                - By providing a managed service that is API compatible with DynamoDB
                - Therefore, it requires only minimal functional changes to use with an existing application
            - For read heavy or burst workloads
                DAX provides increased throughput
        - DAX supports server side encryption with encryption at rest
        - DAX also supports encryption in transit