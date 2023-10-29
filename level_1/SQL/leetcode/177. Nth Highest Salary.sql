/*Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.
*/

-- # Write your MySQL query statement below 
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET  N = N - 1;
  RETURN (
      SELECT distinct(Salary) FROM Employee
      ORDER BY Salary DESC
      LIMIT N,1 
      
  );
END