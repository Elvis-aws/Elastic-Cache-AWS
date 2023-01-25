
******
Aurora
******
    - All Aurora instances have a share volume that is auto expanding from 10G to 128TB
    - only the master can write to storage
    - There is a writer endpoint connected from the client to the master
    - Incase of failover, the client connects to the new master using this writer endpoint
    - The Reader Enpoint connects automatically to all the read replicas
    - It is a fully managed relational database engine thats compatible with MySQL and PostgreSQL
    - Max 15 read replicas for Aurora while MYSQL only has 5 
    - 20% more cost 
    
    ***********
    Availablity
    ***********
        - 6 Copies of ur data accross 3 AZ 
            - 4 of 6 copies needed for writes 
            - 3 copies out of 6 needed for reads 
            - Self healing with peer-to-peer replication 
            - Storage is striped accross 100s of volumes 
            - Failover happens in less than 30 seconds 
            - Any of the read replicas can become the master 
    *******
    Cluster 
    *******
        - Writer endpoint always pointing to master (DNS Name)
        - Many read relicars and auto-scaling can be enabled 
        - Reader endpoint connects to all the read replicas thus load balancing happens at the connection level 