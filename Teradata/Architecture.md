
![image](https://user-images.githubusercontent.com/32897934/123841697-800ca480-d92d-11eb-933a-f4fe6ece2e27.png)

* Parsing Engine − Parsing Engine is responsible for receiving queries from the client and preparing an efficient execution plan. The responsibilities of parsing engine are −

- Receive the SQL query from the client
- Parse the SQL query check for syntax errors
- Check if the user has required privilege against the objects used in the SQL query
- Check if the objects used in the SQL actually exists
- Prepare the execution plan to execute the SQL query and pass it to BYNET
- Receives the results from the AMPs and send to the client

* AMP - AMPs, called as Virtual Processors (vprocs) are the one that actually stores and retrieves the data. AMPs receive the data and execution plan from Parsing Engine, performs any data type conversion, aggregation, filter, sorting and stores the data in the disks associated with them. Records from the tables are evenly distributed among the AMPs in the system. Each AMP is associated with a set of disks on which data is stored. Only that AMP can read/write data from the disks.

* BYNET - Message Passing Layer called as BYNET, is the networking layer in Teradata system. It allows the communication between PE and AMP and also between the nodes. It receives the execution plan from Parsing Engine and sends to AMP. Similarly, it receives the results from the AMPs and sends to Parsing Engine.

* VDISKs -  Disks are disk drives associated with an AMP that store the data rows.
