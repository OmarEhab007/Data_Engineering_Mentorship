/*
Find how many times each artist appeared on the Spotify ranking list
Output the artist name along with the corresponding number of occurrences.
Order records by the number of occurrences in descending order.

Table: spotify_worldwide_daily_song_ranking
*/

SELECT artist, COUNT(*) AS num_occurrences
FROM spotify_worldwide_daily_song_ranking
GROUP BY artist
ORDER BY num_occurrences DESC
