/*
Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

Tables: db_employee, db_dept

db_employee
id:
int
first_name:
varchar
last_name:
varchar
salary:
int
department_id:
int

db_dept
id:
int
department:
varchar
*/




select abs((select max(salary)
from db_employee
join db_dept on db_employee.department_id = db_dept.id
where db_dept.department = 'engineering'
)-(select max(salary)
from db_employee
join db_dept on db_employee.department_id = db_dept.id
where db_dept.department = 'marketing')) as "salary_difference"