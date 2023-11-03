/*

name	continent	area	population	gdp	capital	tld	flag	wikiref

Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

*/

---------------------

SELECT
    w1.name AS countries,
    w1.continent
FROM
    world AS w1
WHERE
    w1.population > 3 * (
        SELECT MAX(w2.population)
        FROM world AS w2
        WHERE w2.continent = w1.continent
          AND w2.name <> w1.name
    );


------- stack overflow solution
--For this particular query, you need the largest and second largest values on each continent. I would approach this with window functions:

select w.continent,
       max(case when seqnum = 1 then w.name end) as name
from (select w.*, 
             row_number() over (partition by continent order by population desc) as seqnum
      from world w
     ) w
where seqnum in (1, 2)
group by continent
having max(case when seqnum = 1 then population end) > 3*max(case when seqnum = 2 then population end)

--Ok, I admit that this is probably a bit advanced, given the source of the question.

--So, here is a way you can do it using joins, instead of correlated subqueries:

--I think the following does your logic:

select w.name, w.continent
from world w join
     (SELECT w.continent, maxpopulation,
             max(case when population <> maxpopulation then population end) as secondmax
      FROM world w join
           (select continent, max(population) as maxpopulation
            from world
            group by continent
           ) c
           on w.continent = c.continent
      group by w.continent, maxpopulation
     ) wc
     on w.continent = wc.continent and w.population = maxpopulation
where population >= 3*secondmax