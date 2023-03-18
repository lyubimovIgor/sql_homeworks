-- 1. Количество исполнителей в каждом жанре.

SELECT genres.name AS genre_name, COUNT(DISTINCT singers.id) AS num_of_singers
FROM genres
LEFT JOIN singers ON genres.id = singers.genre_id
GROUP BY genre_name;

-- 2. Количество треков, вошедших в альбомы 2019-2020 годов.

SELECT COUNT(*) AS num_of_tracks
FROM album_tracks
WHERE album_tracks.album_id IN (
    SELECT albums.id
    FROM albums
    WHERE albums.release_year BETWEEN 2019 AND 2020
);


-- 3. Средняя продолжительность треков по каждому альбому.

SELECT albums.name AS album_name, AVG(album_tracks.duration) AS avg_duration
FROM albums
LEFT JOIN album_tracks ON albums.id = album_tracks.album_id
GROUP BY album_name;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT singers.name AS singer_name
FROM singers
LEFT JOIN albums ON singers.id = albums.singer_id
WHERE albums.release_year != 2020 OR albums.release_year IS NULL;

-- 5. Названия сборников, в которых присутствует исполнитель 'Post Malone'.

SELECT collections.name AS collection_name
FROM collections
LEFT JOIN collection_tracks ON collections.id = collection_tracks.collection_id
LEFT JOIN album_tracks ON collection_tracks.album_track_id = album_tracks.id
LEFT JOIN albums ON album_tracks.album_id = albums.id
LEFT JOIN singers ON albums.singer_id = singers.id
WHERE singers.name = 'Post Malone';

-- 6. Название альбомов, в которых присутствуют исполнители более 1 жанра.

SELECT DISTINCT albums.name AS album_name
FROM albums
LEFT JOIN singers ON albums.singer_id = singers.id
LEFT JOIN (
    SELECT DISTINCT singer_id, COUNT(DISTINCT genre_id) AS num_of_genres
    FROM singer_genres
    GROUP BY singer_id
) AS singer_genre_counts ON singers.id = singer_genre_counts.singer_id
WHERE singer_genre_counts.num_of_genres > 1;

-- 7. Наименование треков, которые не входят в сборники.

SELECT album_tracks.name AS track_name
FROM album_tracks
WHERE album_tracks.id NOT IN (
    SELECT DISTINCT collection_tracks.album_track_id
    FROM collection_tracks
);

-- 8. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек.

SELECT DISTINCT singers.name AS singer_name
FROM singers
LEFT JOIN albums ON singers.id = albums.singer_id
LEFT JOIN album_tracks ON albums.id = album_tracks.album_id
WHERE album_tracks.duration = (
    SELECT MIN(duration)
    FROM album_tracks
);

-- 9. Название альбомов, содержащих наименьшее количество треков.

SELECT albums.name AS album_name
FROM albums
JOIN (
    SELECT album_id, COUNT(*) AS num_of_tracks
    FROM album_tracks
    GROUP BY album_id
) AS track_counts ON albums.id = track_counts.album_id
WHERE track_counts.num_of_tracks = (
    SELECT MIN(num_of_tracks)
    FROM (
        SELECT COUNT(*) AS num_of_tracks
        FROM album_tracks
        GROUP BY album_id
    ) AS album_track_counts
);
