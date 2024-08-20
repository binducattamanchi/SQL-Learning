
-- Creating a table with a clustered index
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,  -- Clustered index by default
    Name NVARCHAR(100),
    Department NVARCHAR(50)
);

-- Creating a non-clustered index on the 'Name' column
CREATE NONCLUSTERED INDEX idx_Employees_Name
ON Employees (Name);


-- Insert sample data
INSERT INTO Employees (EmployeeID, Name, Department)
VALUES 
(1, 'Alice', 'HR'),
(2, 'Bob', 'IT'),
(3, 'Charlie', 'Finance'),
(4, 'Dave', 'IT'),
(5, 'Eve', 'HR');

-- Query using the clustered index
SELECT * FROM Employees WHERE EmployeeID = 3;

-- Query using the non-clustered index
SELECT * FROM Employees WHERE Name = 'Dave';


Clustered Index Query:

The query SELECT * FROM Employees WHERE EmployeeID = 3; benefits from the clustered index on EmployeeID. The database quickly locates the data because it’s stored in order.
Non-Clustered Index Query:

The query SELECT * FROM Employees WHERE Name = 'Dave'; uses the non-clustered index on the Name column. The index helps to quickly find the row(s) where Name = 'Dave' and then retrieves the corresponding data from the table using the pointer.
