
*****
Redis
*****
    - Multi AZ with auto-failover 
    - Read replicas to scale reads 
    - Data durability using AOF persistence 
    - Backup and restore features 

    *********************
    Cluster Mode disabled 
    *********************
        - One primary node, 5 read replicas 
        - Asynchronous replication
        - Primary node is used for read/write 
        - The other nodes are read only 
        - One shard, all nodes 
    *********************
    Cluster Mode enabled 
    *********************
        - Many shards will be available 
        - Multi-AZ is on by default 
        - Up to 500 nodes per cluster 
        
    