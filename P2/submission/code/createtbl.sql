-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
CREATE TABLE Person(
                       pid INT NOT NULL,
                       fname VARCHAR(50) NOT NULL,
                       lname VARCHAR(50) NOT NULL,
                       DOB DATE NOT NULL,
                       PRIMARY KEY (pid)
);

CREATE TABLE Audience(
                         pid INT NOT NULL,
                         email VARCHAR(50) NOT NULL,
                         PRIMARY KEY (pid),
                         FOREIGN KEY (pid) REFERENCES Person(pid)
);

CREATE TABLE Referee (
                         pid INT NOT NULL,
                         country VARCHAR(50) NOT NULL,
                         YOE INT NOT NULL,
                         PRIMARY KEY (pid),
                         FOREIGN KEY (pid) REFERENCES Person(pid)
);

CREATE TABLE Player (
                        pid INT NOT NULL,
                        shirtNum INT NOT NULL,
                        genPos VARCHAR(50) NOT NULL,
                        PRIMARY KEY (pid),
                        FOREIGN KEY (pid) REFERENCES Person(pid)
);

CREATE TABLE Coach (
                       pid INT NOT NULL,
                       role VARCHAR(50) NOT NULL,
                       PRIMARY KEY (pid),
                       FOREIGN KEY (pid) REFERENCES Person(pid)
);

CREATE TABLE Stadium (
                         name VARCHAR(50) NOT NULL,
                         location VARCHAR(50) NOT NULL,
                         maxCapacity INT NOT NULL,
                         PRIMARY KEY (name)
);

CREATE TABLE Team (
                      country VARCHAR(50) NOT NULL,
                      officialName VARCHAR(50) NOT NULL,
                      URL VARCHAR(100) NOT NULL,
                      "group" VARCHAR(50) NOT NULL,
                      groupPoints INT NOT NULL,
                      PRIMARY KEY (country)
);

CREATE TABLE Match (
                       mid INT NOT NULL,
                       LOM VARCHAR(50) NOT NULL,
                       startTime TIME NOT NULL,
                       date DATE NOT NULL,
                       stadium VARCHAR(50) NOT NULL,
                       team1 VARCHAR(50) NOT NULL,
                       team2 VARCHAR(50) NOT NULL,
                       PRIMARY KEY (mid),
                       FOREIGN KEY (stadium) REFERENCES Stadium(name),
                       FOREIGN KEY (team1) REFERENCES Team(country),
                       FOREIGN KEY (team2) REFERENCES Team(country)
);

CREATE TABLE PlayerGameInfo (
                                mid INT NOT NULL,
                                pid INT NOT NULL,
                                y1 INT NOT NULL,
                                y2 INT NOT NULL,
                                r INT NOT NULL,
                                pos VARCHAR(50) NOT NULL,
                                PRIMARY KEY (pid, mid),
                                FOREIGN KEY (pid) REFERENCES Player(pid),
                                FOREIGN KEY (mid) REFERENCES Match(mid)
);

CREATE TABLE Substitution (
                              pid1 INT NOT NULL,
                              pid2 INT NOT NULL,
                              mid INT NOT NULL,
                              time TIME NOT NULL,
                              PRIMARY KEY (pid1, pid2, mid),
                              FOREIGN KEY (pid1) REFERENCES Player(pid),
                              FOREIGN KEY (pid2) REFERENCES Player(pid),
                              FOREIGN KEY (mid) REFERENCES Match(mid)
);

CREATE TABLE RefereeGameInfo (
                                 pid INT NOT NULL,
                                 mid INT NOT NULL,
                                 role VARCHAR(50) NOT NULL,
                                 PRIMARY KEY (pid, mid),
                                 FOREIGN KEY (pid) REFERENCES Referee(pid),
                                 FOREIGN KEY (mid) REFERENCES Match(mid)
);



CREATE TABLE GoalInfo (
                          mid INT NOT NULL,
                          time TIME NOT NULL,
                          forTeam VARCHAR(50) NOT NULL,
                          player INT NOT NULL,
                          penalty BOOLEAN NOT NULL,
                          PRIMARY KEY (mid, time),
                          FOREIGN KEY (mid) REFERENCES Match(mid),
                          FOREIGN KEY (forTeam) REFERENCES Team(country),
                          FOREIGN KEY (player) REFERENCES Player(pid)
);

CREATE TABLE Ticket (
                        tid INT NOT NULL,
                        price DECIMAL(10,2) NOT NULL,
                        section VARCHAR(50) NOT NULL,
                        range VARCHAR(50) NOT NULL,
                        seat VARCHAR(50) NOT NULL,
                        mid INT NOT NULL,
                        stadium VARCHAR(50) NOT NULL,
                        PRIMARY KEY (tid),
                        FOREIGN KEY (mid) REFERENCES Match(mid),
                        FOREIGN KEY (stadium) REFERENCES Stadium(name)
);

CREATE TABLE Sales (
                       pid INT NOT NULL,
                       tid INT NOT NULL,
                       FOREIGN KEY (pid) REFERENCES Person(pid),
                       FOREIGN KEY (tid) REFERENCES Ticket(tid),
		       PRIMARY KEY (tid)
);

CREATE TABLE PlayerTeam (
                            pid INT NOT NULL,
                            team VARCHAR(50) NOT NULL,
                            PRIMARY KEY (pid),
                            FOREIGN KEY (pid) REFERENCES Player(pid),
                            FOREIGN KEY (team) REFERENCES Team(country)
);

CREATE TABLE CoachTeam (
                           pid INT NOT NULL,
                           team VARCHAR(50) NOT NULL,
                           PRIMARY KEY (pid),
                           FOREIGN KEY (pid) REFERENCES Coach(pid),
                           FOREIGN KEY (team) REFERENCES Team(country)
);


