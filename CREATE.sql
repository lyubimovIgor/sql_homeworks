CREATE TABLE IF NOT EXISTS genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS singers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS genres_singers (
    genre_id INTEGER REFERENCES genres(id),
    singer_id INTEGER REFERENCES singers(id),
    CONSTRAINT gs PRIMARY KEY (genre_id, singer_id)
);

CREATE TABLE IF NOT EXISTS mixes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    release_year INTEGER CHECK (release_year >= 1900 AND release_year <= 2100) NOT NULL
);


CREATE TABLE IF NOT EXISTS singers_albums (
    singer_id INTEGER REFERENCES singers(id),
    album_id INTEGER REFERENCES albums(id),
    CONSTRAINT sa PRIMARY KEY (singer_id, album_id)
);

CREATE TABLE IF NOT EXISTS album_tracks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(90) NOT NULL,
    duration INTEGER CHECK (duration >= 0) NOT NULL,
    album_id INTEGER REFERENCES albums(id)
);

CREATE TABLE IF NOT EXISTS mixes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    release_year INTEGER CHECK (release_year >= 1900 AND release_year <= 2100) NOT NULL
);

CREATE TABLE IF NOT EXISTS mix_tracks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(90) NOT NULL,
    duration INTEGER CHECK (duration >= 0) NOT NULL,
    mix_id INTEGER REFERENCES mixes(id)
);



