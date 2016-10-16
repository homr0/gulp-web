# Creates the database that will be used for mothy's work.
# Creates the database if it doesn't exist.
CREATE DATABASE IF NOT EXISTS mothy;

# Selects the database.
USE mothy;

# Drops the tables to make sure that the database is clean.
DROP TABLE Artist;
DROP TABLE Video;
DROP TABLE Canon;
DROP TABLE Part;
DROP TABLE Series;
DROP TABLE Track;
DROP TABLE Album;
DROP TABLE Appear;
DROP TABLE Persona;
DROP TABLE Vocaloid;
DROP TABLE Song;
DROP TABLE Users;

# Creates the tables for holding data.
# Creates the User table, which holds all user data.
CREATE TABLE Users(
    uname CHAR(20) UNIQUE NOT NULL,
    passwd CHAR(20) NOT NULL,
    ulevel INT NOT NULL,
    PRIMARY KEY(uname)
);

# Creates the Song table, which holds all data for songs.
CREATE TABLE Song(
    title CHAR(30) UNIQUE NOT NULL,
    alt CHAR(30) UNIQUE,
    romaji CHAR(40) UNIQUE NOT NULL,
    sdate DATE NOT NULL,
    sid INT UNIQUE NOT NULL,
    PRIMARY KEY(sid)
);

# Creates the Vocaloid table, which holds all the names and colors for Vocaloids.
CREATE TABLE Vocaloid(
    vname CHAR(30) UNIQUE NOT NULL,
    color CHAR(7) UNIQUE NOT NULL,
    PRIMARY KEY(vname)
);

# Creates the Persona table, which holds names of characters and which Vocaloid portrays them.
CREATE TABLE Persona(
    cname CHAR(30) UNIQUE NOT NULL,
    vname CHAR(30) NOT NULL,
    cid INT UNIQUE NOT NULL,
    FOREIGN KEY(vname) REFERENCES Vocaloid(vname),
    PRIMARY KEY(cid)
);

# Creates the Appear table, which holds which character was in which song.
CREATE TABLE Appear(
    cid INT NOT NULL,
    sid INT NOT NULL,
    appears CHAR(10),
    FOREIGN KEY(cid) REFERENCES Persona(cid),
    FOREIGN KEY(sid) REFERENCES Song(sid),
    PRIMARY KEY(sid, cid)
);

# Creates the Album table, which holds album data.
CREATE TABLE Album(
    atitle CHAR(30) UNIQUE NOT NULL,
    rdate DATE NOT NULL,
    aid INT UNIQUE NOT NULL,
    PRIMARY KEY(aid)
);

# Creates the Track table, which holds what track the song was in an album.
CREATE TABLE Track(
    aid INT NOT NULL,
    sid INT,
    tnum INT NOT NULL,
    salias CHAR(30) NOT NULL,
    FOREIGN KEY(aid) REFERENCES Album(aid),
    FOREIGN KEY(sid) REFERENCES Song(sid),
    PRIMARY KEY(aid, tnum)
);

# Creates the Series table, which holds all series.
CREATE TABLE Series(
    sname CHAR(30) UNIQUE NOT NULL,
    nid INT UNIQUE NOT NULL,
    PRIMARY KEY(nid)
);

# Creates the Part table, which holds where the song is in a series.
CREATE TABLE Part(
    nid INT NOT NULL,
    sid INT NOT NULL,
    pnum INT NOT NULL,
    FOREIGN KEY (nid) REFERENCES Series(nid),
    FOREIGN KEY (sid) REFERENCES Song(sid),
    PRIMARY KEY(nid, sid)
);

# Creates the Canon table, which is a subset of songs that are part of Evillious Chronicles.
CREATE TABLE Canon(
    sid INT UNIQUE NOT NULL,
    ec INT,
    FOREIGN KEY(sid) REFERENCES Song(sid)
);

# Creates the Video table, which holds information about songs that have music videos.
CREATE TABLE Video(
    sid INT NOT NULL,
    upload DATE NOT NULL,
    vlink CHAR(30) UNIQUE NOT NULL,
    vid INT UNIQUE NOT NULL,
    FOREIGN KEY(sid) REFERENCES Song(sid),
    PRIMARY KEY(vid)
);

# Creates the Artist table, which holds data about who worked on a music video.
CREATE TABLE Artist(
    vid INT NOT NULL,
    aname INT NOT NULL,
    FOREIGN KEY(vid) REFERENCES Video(vid)
);

# Loads the data from .CSV files
LOAD DATA LOCAL INFILE 'data/User.csv' INTO TABLE Users
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Song.csv' INTO TABLE Song
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Vocaloid.csv' INTO TABLE Vocaloid
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Persona.csv' INTO TABLE Persona
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Role.csv' INTO TABLE Appear
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Album.csv' INTO TABLE Album
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Track.csv' INTO TABLE Track
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Series.csv' INTO TABLE Series
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Part.csv' INTO TABLE Part
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Canon.csv' INTO TABLE Canon
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Video.csv' INTO TABLE Video
    FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'data/Artist.csv' INTO TABLE Artist
    FIELDS TERMINATED BY ',';
