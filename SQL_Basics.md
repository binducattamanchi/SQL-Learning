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
