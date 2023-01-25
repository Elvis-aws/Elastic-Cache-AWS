

********
Sharding
********
        - This does not entail vertical scaling were by Ram, Storage or CPU have to be increased to improve
          performance
        - It is not partitioning where by a table is spilt into different partitions based on the key but all
          the new partitions remain in the same server
        - It entails horizontal scaling where by the table is divided into different shards and placed in
          different servers or instances
        - Shards are divided or separated by a range of partition keys lets say from 1-10 for shard 1 and 11-20
          for shard 2
        - You must use a unique key or else you will have a hot key issue and your table will be throttled due
          to many requests taking place in a single shard
        - Primary key is hashed (apply strings or numbers to the primary key)