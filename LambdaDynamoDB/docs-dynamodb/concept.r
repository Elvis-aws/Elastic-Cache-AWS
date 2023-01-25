

********
DynamoDB
********
    - Fully managed, highly available with replication across multiple AZ
    - NoSQL database
    - Scales to massive workload
    - Millions of request per second, 100 s of TB storage
    - Very low latency
    - Iam for security
    - Event driven with DynamoDB streams
    - Standard and Infrequent Access tables
    ***************
    DynamoDB basics
    ***************
        - Each table has a primary key
        - Infinite number of items
        - Each item has attributes
        - Item size is 400 KB max
        - Supported data types include
            - Scalar types : String, Number, Binary, Boolean, Null
            - Document types : List, Map
            - Set Types : String set, Number set , Binary set
    ******************************
    Copying table across accounts
    ******************************
        - Use Data Pipeline
        - Backup and restore
        - Write ur own code
    ********************
    partition key + sort
    ********************
        - So you can design your table with a composite key ( combination of partition and sort key)
        - In a table that has a partition key and a sort key, its possible for multiple items to have 
          the same partition key value
        - However, those items must have different sort key values
        - All items with the same partition key value are stored together, in sorted order by sort key 
          value
        - combination of partition key + sort key will result in a unique order
        - Here partition key will be userID and orderId will be unique
        - Hence you can query all orders for a particular user by userId using query operation and for 
          sorting with date you can use filter expressions in your query operation