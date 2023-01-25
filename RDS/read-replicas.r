

***********
Replication
***********
    - Amazon RDS uses replication functionality to create a special type of DB instance called a read replica from
      a source DB instance
    - The source DB instance becomes the primary DB instance
    - Updates made to the primary DB instance are asynchronously copied to the read replica
    - You can reduce the load on your primary DB instance by routing read queries from your applications to the read
      replica
    - When you create a read replica, you first specify an existing DB instance as the source
    - Then Amazon RDS takes a snapshot of the source instance and creates a read-only instance from the snapshot
    - The primary difference between synchronous replication and asynchronous replication is the way in which data
      is written to the replica
    - Most synchronous replication products write data to primary storage and the replica simultaneously. As such,
      the primary copy and the replica should always remain synchronized. In contrast, asynchronous replication
      products copy the data to the replica after the data is already written to the primary storage

************************
Promoting a read replica
************************
    - You can promote a read replica into a standalone DB instance
    - When you promote a read replica, the DB instance is rebooted before it becomes available
    - The application must update the connection string to leverage read replicas
        - Max 5 read replicas for RDS
        - Max 15 read replicas for Aurora
