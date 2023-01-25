

********
Security
********
    - Encryption using AWS-KMS must be defined at lunch time
    - If the master is not encrypted, read-replicas will not be encrypted
    - To encrypt an un-encrypted DB, create a snapshot of the instance, encrypt and restore the DB
    - No SSH available except for custom RDS
    - Enable CloudWatch logs for log generation
    ************
    RDS Security
    ************
            Databases are run on instances within a VPC, so your network is the first layer of defense. If you are 
        connecting to AWS from an on-premise data center, make sure you are using Direct Connect or a VPN. 
        Utilizing Security Groups and Network Access Lists is also a must, no matter where you are connecting from. 
        During the creation of the database, you will assign a master user who will have full administration rights, 
        but only use them to define other database users and grant them access. You also can choose whether your 
        database will be publicly accessible or not.
    **********
    Encryption
    **********
            RDS allows you to protect your data by using encryption, both in transit and at rest. For encryption in 
        transit, SSL is supported by all six database engines. RDS will create a certificate and install it on an 
        instance when it is provisioned. Encryption at rest is handled by AWS Key Management Service (KMS) and is 
        enabled during the provisioning of the database. Encryption is also important when it comes to compliance, 
        so make sure you enable it when setting up your database.