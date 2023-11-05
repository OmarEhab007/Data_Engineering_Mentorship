/*
Query the average population for all cities in CITY, rounded down to the nearest integer.

Input Format

The CITY table is described as follows: CITY.jpg
*/
SELECT FLOOR(AVG(POPULATION)) FROM CITY;