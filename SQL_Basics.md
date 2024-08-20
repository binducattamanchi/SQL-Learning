
# Database Objects
* Databases and Users
* Tables
* Columns
* Data Types
* [Constraints](#Constraints)
* [Keys](#Keys)
* [Joins](#Joins)
* [Indexes](#Indexing)
* Referential Integrity
* Views
* [Triggers](#Triggers)
* [Macros](#Macros)
* Stored Procedure
* User Defined Functions
* Profile
* Roles
* User Defined Types
* Star vs Snowflake


# Generic

* Database : A database is a container with an allotment of space in which users can create and maintain database objects, including tables, views, triggers, indexes, stored procedures, user-defined functions, and macros.
* User : A user is similar to a database, except that a user has a password and can log on to the system, whereas a database cannot.
* Views : A view in SQL is a virtual table based on the result-set of an SQL statement. A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.


# Tables 
Tables in Relational model are defined as collection of data. They are represented as rows and columns.
* **Permanent Table** − This is the default table and it contains data inserted by the user and stores the data permanently.
* **Volatile Table** − The data inserted into a volatile table is retained only during the user session. The table and data is dropped at the end of the session. These tables are mainly used to hold the intermediate data during data transformation.
* **Global Temporary Table** − The definition of Global Temporary table are persistent but the data in the table is deleted at the end of user session.
* **Derived Table** − Derived table holds the intermediate results in a query. Their lifetime is within the query in which they are created, used and dropped.
 
# Data Types
![image](https://user-images.githubusercontent.com/32897934/123794846-f646e200-d900-11eb-977f-838bc0e65a55.png)


# Constraints
Constraints are used to specify the rules concerning data in the table. It can be applied for single or multiple fields in an SQL table during creation of table or after creationg using the ALTER TABLE command. The constraints are:

* NOT NULL - Restricts NULL value from being inserted into a column.
* CHECK - Verifies that all values in a field satisfy a condition.
* DEFAULT - Automatically assigns a default value if no value has been specified for the field.
* UNIQUE - Ensures unique values to be inserted into the field.
* INDEX - Indexes a field providing faster retrieval of records.
* PRIMARY KEY - Uniquely identifies each record in a table.
* FOREIGN KEY - Ensures referential integrity for a record in another table.

![image](https://user-images.githubusercontent.com/32897934/123752578-8cb1de00-d8d6-11eb-9934-287b98003651.png)

# Keys
* Primary Key - A Primary key is a column or a group of columns that uniquely identifies each row in a table. It contain UNIQUE values in column, and does not allows  NULL values.
* Foreign Key - Foreign creates a relationship between two or more tables, a primary key of one table is referred as a foreign key in another table.
* Unique Key - Unique key is similar to primary key and does not allow duplicate values in the column. It allows one null value in the column.
* Candidate Key - Candidate Key can be defined as a set of one or more columns that can identify a record uniquely in a table and which can be selected as a primary key of the table.
* Alternate Key - Alternate key can be defined as a key that can be work as a primary key if required but right now it is not Primary key.
* Composite Key - Composite Key is a combination of more than one columns of a table. It can be a Candidate key and Primary key.
* Super Key - A super key is a group of single or multiple keys which identifies rows in a table.

![image](https://user-images.githubusercontent.com/32897934/123751273-2ed0c680-d8d5-11eb-9da8-5001c39bb4cc.png)

![image](https://user-images.githubusercontent.com/32897934/123751361-490aa480-d8d5-11eb-850a-bbc74d9330af.png)


# Joins

![image](https://user-images.githubusercontent.com/32897934/123753164-2c6f6c00-d8d7-11eb-836b-bab5da65f69f.png)

![image](https://user-images.githubusercontent.com/32897934/123752887-e5817680-d8d6-11eb-9279-54abcdf432db.png)

* **Self Join** - It is used to fetch different type of data from the same table. In this type of join, the table will be joined to itself.
```
SELECT e.ename As employee_name, m.ename AS manager_name 
FROM emp e 
JOIN emp m
ON(e.mgr = m.empno);
```

![image](https://user-images.githubusercontent.com/32897934/123753428-73f5f800-d8d7-11eb-8a1e-6a304f7923ff.png)

* **Cross Join** - It is a type of join which link each row of the first table with all the rows of the second table. It is also called cross product or cartesian product of both the table. It will do cross join automatically when join condition is missing or when join condition is not correct. Example:

```
SELECT ename, dname FROM emp CROSS JOIN dept;
SELECT ename, dname, grade 
FROM emp 
CROSS JOIN dept 
CROSS JOIN salgrade;
```

# Indexing

![image](https://user-images.githubusercontent.com/32897934/123754233-4bbac900-d8d8-11eb-8a64-444461abd6d2.png)
* Primary Index - Unique or non-unique / Partitioned or non-partitioned
* Secondary Index - Unique or non-unique 
* Join Index (JI) : Join indexes are not indexes in the usual sense of the word. They are file structures designed to permit queries (join queries in the case of multitable join indexes) to be resolved by accessing the index instead of having to access and join their underlying base tables.

You can use join indexes to:

- Define a prejoin table on frequently joined columns (with optional aggregation) without denormalizing the database.
- Create a full or partial replication of a base table with a primary index on a foreign key column table to facilitate joins of very large tables by hashing their rows to the same AMP as the large table.
- Define a summary table without denormalizing the database.
```
CREATE JOIN INDEX cust_ord2
   AS SELECT cust.customerid,cust.loc,ord.ordid,item,qty,odate
   FROM cust, ord, orditm
   WHERE cust.customerid = ord.customerid
   AND ord.ordid = orditm.ordid;
```

* Hash Index

# Macros
Macro is a set of SQL statements which are stored and executed by calling the Macro name. The definition of Macros is stored in Data Dictionary. Users only need EXEC privilege to execute the Macro. Users don't need separate privileges on the database objects used inside the Macro. Macro statements are executed as a single transaction. If one of the SQL statements in Macro fails, then all the statements are rolled back. Macros can accept parameters. Macros can contain DDL statements, but that should be the last statement in Macro.
```
CREATE MACRO Get_Emp_Salary(EmployeeNo INTEGER) AS ( 
   SELECT 
   EmployeeNo, 
   NetPay 
   FROM  
   Salary 
   WHERE EmployeeNo = :EmployeeNo; 
);
EXECUTE Get_Emp_Salary(100);
```

# Triggers
Triggers are active database objects associated with a subject table. A trigger essentially consists of a stored SQL statement or a block of SQL statements.
Triggers execute when an INSERT, UPDATE, DELETE, or MERGE modifies a specified column or columns in the subject table.
```
CREATE  TRIGGER <Trigger-name><TRIGGER  ACTION> {BEFORE | AFTER | INSTEAD OF}
  [ ORDER  <sequence-number> ]<TRIGGERING  ACTION > {INSERT | UPDATE | DELETE | INSERT/SELECT}
  [ OF  (<column-name>, ... ) ] ON <subject-table>
  REFERENCING  OLD AS <before-imaged-row>
  NEW AS  <after-image-row>
  FOR EACH  ROW
  [ WHEN (optional condition) ]
  (  <TRIGGERED ACTION> { INSERT | INSERT/SELECT} ; )
  ;
```

# Stored Procedures
A stored procedure contains a set of SQL statements and procedural statements. They may contain only procedural statements. The definition of stored procedure is stored in database and the parameters are stored in data dictionary tables.

```
CREATE PROCEDURE NewProc (IN name CHAR(12),
                             IN number INTEGER,
                             IN dept INTEGER,
                             OUT dname CHAR(10))
   BEGIN
      INSERT INTO Employee (EmpName, EmpNo, DeptNo )
         VALUES (name, number, dept);
      SELECT DeptName 
         INTO dname FROM Department
            WHERE DeptNo = dept;
   END;
   
 CALL NewProc ('Jonathan', 1066, 34, dname);
```

# External Stored Procedure

# User Defined Functions
SQL provides a set of useful functions, but they might not satisfy all of the particular requirements you have to process your data.
Teradata Database supports two types of user-defined functions (UDFs) that allow you to extend SQL by writing your own functions:

- SQL UDFs
- External UDFs

# Star vs Snowflake 
![image](https://github.com/user-attachments/assets/a2c6bc32-4e67-4233-8e06-50c1187f4a9f)


  
