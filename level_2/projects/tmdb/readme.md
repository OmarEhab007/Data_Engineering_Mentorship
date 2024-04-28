# TMDB
## Project Overview:
Under certain conditions, Having a pre-aggregated tables can save us a lot of time. The cost of writing the aggregations results in the aggreagation tables every time we update the main table is well worth it if the read frequency is much higher than the write frequency and the size of data is very large.


Imagine we have here one of those cases. Our dataset consists of almost 5000 movies in a csv file. We have a column with the genres of each movie in the form of an array of json object. We need to create a pre-aggregated table for the genres using PySpark. We also want to know the most popular film in each original language


## Resources:
TMDB dataset on git project folder

## Requirements:
1. Load the csv file from the local FS to HDFS.
2. Create a local file called popular_film_per_lan.csv with each original language and the most popular film in each.
3. Create a new file on HDFS called Genres_Agggregations.csv with the id, name and number of movies for each genre.

## Key Deliverables:
-	Python code creating the files and populating them.
-	Genres_Aggregations.csv file
- popular_film_per_lan.csv file
