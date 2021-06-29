There are several types of data protection are available with the Teradata Database.
Some processes for protection are automatic and some of them are optional.
Main types are listed below.
* RAID
* Cliques
* Hot Standby Nodes
* Fallback
* Journaling
* Locks

# Raid
Redundant Array of Inexpensive Disks (RAID) is a storage technology that provides data protection at the disk drive level.
There are 6 RAID configuration levels.

RAID 0 - Data striping
RAID 1 - Disk mirroring
RAID 2 - Parallel array, hamming code
RAID 3 - Parallel array with parity
RAID 4 - Data parity protection, dedicated parity drive
RAID 5 - Data parity protection, interleaved parity

![image](https://user-images.githubusercontent.com/32897934/123843173-3ae97200-d92f-11eb-9ca8-31c8c9b41ac2.png)

# Clique
A clique (pronounced, "kleek") is a group of nodes that share access to the same disk arrays. Each multi-node system has at least one clique. 
The cabling determines which nodes are in which cliques -- the nodes of a clique are connected to the disk array controllers of the same disk arrays.

![image](https://user-images.githubusercontent.com/32897934/123843632-c236e580-d92f-11eb-9350-d8e0ab199712.png)

# Hot Standby Nodes
A Hot Standby Node (HSN) is a node that is a member of a clique that is not configured (initially) to execute any Teradata vprocs. 
If a node in the clique fails, the AMPs from the failed node move to the hot standby node. The performance degradation is 0%.
![image](https://user-images.githubusercontent.com/32897934/123843931-0b873500-d930-11eb-92a7-2115b8a633ff.png)
![image](https://user-images.githubusercontent.com/32897934/123843946-0fb35280-d930-11eb-95b2-6c9a50ec2f2f.png)

# Fallback
Fallback is a Teradata Database feature that protects data in the case of an AMP vproc failure.
Fallback protection can be done at the table or database level.
It is especially useful in applications that require high availability.

Fallback protects your data by storing a second copy of each row of a table on a different AMP in the same cluster.
If an AMP fails, the system accesses the Fallback rows to meet requests.
Fallback provides AMP fault tolerance at the table level.
With Fallback tables, if one AMP fails, all data is still available. Users may continue to use Fallback tables without any loss of access to data.
![image](https://user-images.githubusercontent.com/32897934/123844301-789aca80-d930-11eb-9db2-939374a22941.png)


# Journals
Journals are kept on the system to provide data availability in the event of a component or process failure in the system:

- Recovery Journals
- Permanent Journals

# Locks
Locking prevents multiple users who are trying to access or change the same data simultaneously from violating data integrity. This concurrency control is implemented by locking the target data.

Locks are automatically acquired during the processing of a request and released when the request is terminated.

**Levels of Locking**
Locks may be applied at three levels:
* Database Locks: Apply to all tables and views in the database.
* Table Locks: Apply to all rows in the table or view.
* Row Hash Locks: Apply to a group of one or more rows in a table.

**Types of Locking**
* Exclusive
* Read
* Write
* Access

![image](https://user-images.githubusercontent.com/32897934/123845160-7be28600-d931-11eb-997a-0848ef551c57.png)

Screenshot 2021-06-29 at 11.23.38 PM<img width="502" alt="Screenshot 2021-06-29 at 11 23 38 PM" src="https://user-images.githubusercontent.com/32897934/123845137-7422e180-d931-11eb-9b61-b5bac6961c8e.png">
