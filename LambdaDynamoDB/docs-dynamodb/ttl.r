

***
TTL
***
    - Automatically delete items after expiration
    - Does not consume WCU
    - The TTL must be a number
    - Expired items will be deleted within 48 hours
    - On-deleted expired items will still appear in the reads/queries/scan operations
    - Deleted items will still be found in streams 
    - Expired items are deleted from both GLI and LSI
