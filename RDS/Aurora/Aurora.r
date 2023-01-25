

******
Aurora
******
    - All Aurora instances have a shared volume that is auto expanding from 10 G to 128 TB
    - only the master can write to storage
    - There is a writer endpoint connected from the client to the master
    - Incase of fail-over, the client connects to the new master using this writer endpoint
    - The Reader Endpoint connects automatically to all the read replicas
    - It is a fully managed relational database engine that is compatible with MySQL and PostgresSQL
    - Max 15 read replicas for Aurora while MYSQL only has 5 
    - 20% more cost 
    
    ************
    Availability
    ************
        - 6 Copies of ur data across 3 AZ
            - 4 of 6 copies needed for writes 
            - 3 copies out of 6 needed for reads 
            - Self healing with peer-to-peer replication 
            - Storage is striped across 100 s of volumes
            - Fail-over happens in less than 30 seconds
            - Any of the read replicas can become the master 
    *******
    Cluster 
    *******
        - Writer endpoint always pointing to master (DNS Name)
        - Many read relicas and auto-scaling can be enabled
        - Reader endpoint connects to all the read replicas thus load balancing happens at the connection level 