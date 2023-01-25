

********
Capacity
********
        - You have the option to setup auto-scaling of throughput to meet demand
        - Throughput can be exceeded temporarily using bust credit
        - You get a ProvisionedThroughputExceededException once bust capacity is consumed
        - Its advised to use exponential backoff retry strategy
        - Amazon DynamoDB has two read/write capacity modes for processing reads and writes on your tables
            *********
            On-demand
            *********
                - When you choose on-demand mode, DynamoDB instantly accommodates your workloads as they ramp up or
                  down to any previously reached traffic level
                - If a workload’s traffic level hits a new peak, DynamoDB adapts rapidly to accommodate the workload
            ***********
            Provisioned
            ***********
                - If you choose provisioned mode, you specify the number of reads and writes per second that you
                  require for your application
                - You can use auto scaling to adjust your table’s provisioned capacity automatically in response to
                  traffic changes
                *************************
                Read Capacity Units (RCU)
                *************************
                    - Total number of read capacity units required depends on the item size, and the consistent read
                      model (eventually or strongly)
                        - Eventual Consistency (50:50 requested data is retrieved by application). Dynamodb might check
                          only one read replica and the data might not have synchronized to this read replica. Only one
                          read is performed
                        - Strong Consistency (99.99 requested data is retrieved by application). Dynamodb checks all
                          read replicas and the most recently modified item is returned. At least two reads are
                          performed on the replicas
                    - one RCU represents
                        1 strongly consistent read per second for an item up to 4 KB in size i.e. 2 x cost of eventually
                        consistent reads
                        How to calculate RCUs for strongly consistent
                            Round data up to nearest 4
                            Divide data bt 4
                            Times by number of reads
                        2 eventually consistent reads per second, for an item up to 4 KB in size
                        How to calculate RCUs for eventually consistent
                            Round data up to nearest 4
                            Divide data bt 4
                            Times by number of reads
                            Divide final number by two
                            Round up to the nearest whole number
                *******************
                Write capacity unit
                *******************
                    - This represents one write per second for items up to 1 KB in size
                    - If you need to write an item that is larger than 1 KB, DynamoDB will need to consume additional
                      write capacity units
                    - The total number of write capacity units required depends on the item size.