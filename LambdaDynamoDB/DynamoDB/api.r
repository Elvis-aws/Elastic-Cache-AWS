

*************
DynamoDB APIs
*************
    **************
    Control plane
    **************
        - CreateTable
            - Creates a new table
            - Optionally, you can create one or more secondary indexes, and enable DynamoDB Streams for the table
        - DescribeTable
            - Returns information about a table, such as its primary key schema, throughput settings, and index 
              information
        - ListTables
            - Returns the names of all of your tables in a list
        - UpdateTable
            - Modifies the settings of a table or its indexes, creates or removes new indexes on a table, or 
              modifies DynamoDB Streams settings for a table
        - DeleteTable
            - Removes a table and all of its dependent objects from DynamoDB
    *************
    Creating data
    *************
        - PutItem
            - Writes a single item to a table
            - You must specify the primary key attributes, but you dont have to specify other attributes
        - BatchWriteItem
            - Writes up to 25 items to a table
            - This is more efficient than calling PutItem multiple times because your 
            application only needs a single network round trip to write the items
            - You can also use BatchWriteItem for deleting multiple items from one or more tables
            - Up to 16 MB of data written, up to 400 KB of data per item
            - Cant update items
    ************
    Reading data
    ************
        - GetItem
            - Retrieves a single item from a table
            - You must specify the primary key for the item that you want
            - You can retrieve the entire item, or just a subset of its attributes
        - BatchGetItem
            - Retrieves up to 100 items from one or more tables
            - This is more efficient than calling GetItem multiple times because your application only needs 
              a single network round trip to read the items
            - Returns items from one or more tables
            - Up to 100 items, up to 16 MB of data
            - Items are retrieved in parallel to minimize latency
        - Query
            - Retrieves all items that have a specific partition key
            - You must specify the partition key value
            - You can retrieve entire items, or just a subset of their attributes
            - Optionally, you can apply a condition to the sort key values so that you only retrieve a subset 
              of the data that has the same partition key
            - You can use this operation on a table, provided that the table has both a partition key and a 
              sort key
            - You can also use this operation on an index, provided that the index has both a partition key and 
              a sort key
            - Returns items based on key conditions
            ****************************
            Filter expressions for query
            ****************************
                - If you need to further refine the Query results, you can optionally provide a filter expression
                - A filter expression determines which items within the Query results should be returned to you
                - All of the other results are discarded
        ****
        Scan
        ****
            - Retrieves all items in the specified table or index
            - You can retrieve entire items, or just a subset of their attributes
            - Optionally, you can apply a filtering condition to return only the values that you are interested 
              in and discard the rest
            - For faster performance, use Parallel Scan
            - Use filter and projected expressions to refine results
        *********************
        projection expression
        *********************
            - To get only some, rather than all of the attributes, use a projection expression
            - A projection expression is a string that identifies the attributes that you want to retrieve a 
              single attribute, specify its name
            - For multiple attributes, the names must be comma-separated
        ****************************
        Filter expressions for query
        ****************************
                - same as above
    *************
    Updating data
    *************
        - Modifies one or more attributes in an item
        - You must specify the primary key for the item that you want to modify
        - You can add new attributes and modify or remove existing attributes
    *************
    Deleting data
    *************
        - Deletes a single item from a table
        - You must specify the primary key for the item that you want to delete
        - BatchWriteItem
            - Deletes up to 25 items from one or more tables
            - This is more efficient than calling DeleteItem multiple times 
    ****************
    DynamoDB Streams
    ****************
        - DynamoDB Streams operations let you enable or disable a stream on a table, and allow access to the 
          data modification records contained in a stream
            - ListStreams
                - Returns a list of all your streams, or just the stream for a specific table
            - DescribeStream
                - Returns information about a stream
            - GetShardIterator
                - Returns a shard iterator, which is a data structure that your application uses to retrieve 
                  the records from the stream
            - GetRecords
                - Retrieves one or more stream records, using a given shard iterator

