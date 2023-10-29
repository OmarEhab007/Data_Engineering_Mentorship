/* 
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.
*/

-- # Write your MySQL query statement below
select distinct l1.Num as 'ConsecutiveNums'
from Logs l1
join Logs l2 on l1.Id=l2.Id-1
join Logs l3 on l1.Id=l3.Id-2
where l1.Num=l2.Num and l2.Num=l3.Num
