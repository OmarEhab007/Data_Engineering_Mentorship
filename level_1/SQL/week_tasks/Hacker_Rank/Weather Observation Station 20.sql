/*
A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
*/

Select round(S.LAT_N,4) 
from station AS S 
where (select count(Lat_N) from station where Lat_N < S.LAT_N ) = (select count(Lat_N) from station where Lat_N > S.LAT_N);

-- Exlpaination:
-- 1. Select round(S.LAT_N,4) : round the result to 4 decimal places
-- 2. from station AS S : from the table station, alias it as S
-- 3. where (select count(Lat_N) from station where Lat_N < S.LAT_N ) = (select count(Lat_N) from station where Lat_N > S.LAT_N);
-- 3.1. where (select count(Lat_N) from station where Lat_N < S.LAT_N ) : count the number of Lat_N that is smaller than the current Lat_N
-- 3.2. where (select count(Lat_N) from station where Lat_N > S.LAT_N); : count the number of Lat_N that is larger than the current Lat_N
-- 3.3. where (select count(Lat_N) from station where Lat_N < S.LAT_N ) = (select count(Lat_N) from station where Lat_N > S.LAT_N); : if the number of Lat_N that is smaller than the current Lat_N is equal to the number of Lat_N that is larger than the current Lat_N, then it is the median
