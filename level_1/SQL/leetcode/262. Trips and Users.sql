/*
Table: Trips

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| client_id   | int      |
| driver_id   | int      |
| city_id     | int      |
| status      | enum     |
| request_at  | date     |     
+-------------+----------+
id is the primary key (column with unique values) for this table.
The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').
 

Table: Users

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| users_id    | int      |
| banned      | enum     |
| role        | enum     |
+-------------+----------+
users_id is the primary key (column with unique values) for this table.
The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
banned is an ENUM (category) type of ('Yes', 'No').
 

The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.

Return the result table in any order.
*/

select t.request_at as Day, round(sum(case when t.status like 'cancelled%' then 1 else 0 end)/count(*),2) as 'Cancellation Rate'
from Trips t
join Users u1 on t.client_id = u1.users_id and u1.banned = 'No'
join Users u2 on t.driver_id = u2.users_id and u2.banned = 'No'
where t.request_at between '2013-10-01' and '2013-10-03'
group by t.request_at
order by t.request_at
;

----------------

SELECT
  request_at AS 'DAY',
    ROUND(COUNT(IF(status IN('cancelled_by_driver','cancelled_by_client') , status , NULL)) / COUNT(status) , 2) AS 'Cancellation Rate'
FROM
  Trips T
WHERE
  client_id  NOT IN ( SELECT users_id FROM Users WHERE banned = 'YES')
AND
  driver_id NOT IN ( SELECT users_id FROM Users WHERE banned = 'YES')
AND 
  ( request_at > '2013-09-30' AND request_at < '2013-10-04' )
GROUP BY
  request_at;