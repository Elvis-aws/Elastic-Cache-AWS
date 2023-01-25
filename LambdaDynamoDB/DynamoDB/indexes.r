

*******
Indexes
*******
    ************************************
    DynamoDB Local Secondary Index (LSI)
    ************************************
        - Alternative sort key
        - Up to 5 per table
        - Must be defined at table creation
        - Can contain some or all attributes of the table
        - Local Secondary Indexes use the same hash key as the primary index but allow you to use a different 
          sort key
        - Limit you to only 10 GB of data per Hash/Partition Key
        - If you query for data using LSI, the usage will be calculated against capacity of the underlying table
    *************************************
    DynamoDB Global Secondary Index (GSI)
    *************************************
        - Alternative primary key
        - Can contain some or all attributes of the table
        - They can be modified after table creation
        - They need their own provisioned RCU and WCU
        - Even if the WCU of the main table are ok, throttling on the GSI will throttle the main table
        - They are eventually consistent 
            - If your writing an item to a table, it is asynchronously propagated to the rest of GSIs
            - It means that query results might sometimes not be consistent