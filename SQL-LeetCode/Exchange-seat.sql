########################################################################################
########## QUESTION  ##########
########################################################################################


/*
Table: Seat
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.Each row of this table indicates the name and the ID of a student.id is a continuous increment. 
Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
Return the result table ordered by id in ascending order.
The result format is in the following example.

Example 1: Input: Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Surya   |
| 2  | Abhay   |
| 3  | Ram |
| 4  | Cattamanchi   |
| 5  | Bindu  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Surya   |
| 2  | Abhay   |
| 3  | Ram   |
| 4  | Cattamanchi |
| 5  | Bindu  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.*/

########################################################################################
########## ANSWER  ##########
########################################################################################
select id,
case when id%2 = 0 then (lag(student) over (order by id))
else ifnull(lead(student) over (order by id),student)
END as "student"
from Seat;
