/*You have been asked to find the job titles of the highest-paid employees.


Your output should include the highest-paid title or multiple titles with the same salary.

Tables: worker, title

worker
worker_id:
int
first_name:
varchar
last_name:
varchar
salary:
int
joining_date:
datetime
department:
varchar

title
worker_ref_id:
int
worker_title:
varchar
affected_from:
datetime
*/

select worker_title
from title
where worker_ref_id in (select worker_id
from worker
where salary = (select max(salary)
from worker))

-- another solution
select t.worker_title
from worker w join title t on w.worker_id = t.worker_ref_id 
where salary in (select max(salary)
                    from worker);