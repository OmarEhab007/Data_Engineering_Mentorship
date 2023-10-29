/*
Table: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| score       | decimal |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
 

Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.
*/

-- # Write your MySQL query statement below
select s1.Score, 
       (select count(distinct Score) 
                from Scores s2 WHERE s2.Score >= s1.Score)as 'Rank'
from Scores s1
order by s1.Score desc

--  For each score in the table Scores, we count how many scores are larger than or equal to itself.

select s.Score, l.Rank 
from Scores s
left join (
    select Score, row_number() over (order by Score desc) as 'Rank' 
    from Scores 
    group by Score
) l on l.Score=s.Score
order by s.Score desc
