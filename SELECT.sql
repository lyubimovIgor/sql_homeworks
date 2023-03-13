SELECT name, release_year FROM albums
    WHERE release_year = 2018;

SELECT name, duration FROM album_tracks
    WHERE duration = (SELECT MAX(duration) FROM album_tracks);

SELECT name FROM album_tracks
    WHERE duration >= 210;

SELECT name FROM mixes
    WHERE release_year BETWEEN 2018 AND 2020;

SELECT name FROM singers
    WHERE name NOT LIKE '% %';

SELECT name FROM album_tracks
    WHERE name LIKE '%мой%' OR name LIKE '%my%';