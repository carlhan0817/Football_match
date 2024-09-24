CREATE TABLE Team (
                      country VARCHAR(255) PRIMARY KEY,
                      association VARCHAR(255),
                      URL VARCHAR(255),
                      group CHAR(1)
);

CREATE TABLE Player (
                        pid INT PRIMARY KEY,
                        name VARCHAR(255),
                        DOB DATE,
                        shirt_no INT,
                        position VARCHAR(255),
                        country VARCHAR(255),
                        FOREIGN KEY (country) REFERENCES Team(country)
);

CREATE TABLE Coach (
                       cid INT PRIMARY KEY,
                       name VARCHAR(255),
                       DOB DATE,
                       crole VARCHAR(255),
                       country VARCHAR(255),
                       FOREIGN KEY (country) REFERENCES Team(country)
);

CREATE TABLE Referee (
                         rid INT PRIMARY KEY,
                         name VARCHAR(255),
                         country VARCHAR(255),
                         expyears INT
);

CREATE TABLE Match (
                       mid INT PRIMARY KEY,
                       team1 VARCHAR(255),
                       team2 VARCHAR(255),
                       length INT,
                       mdate DATE,
                       mtime TIME,
                       round INT,
                       gt1 INT,
                       gt2 INT,
                       pt1 INT,
                       pt2 INT,
                       sname VARCHAR(255),
                       FOREIGN KEY (team1) REFERENCES Team(country),
                       FOREIGN KEY (team2) REFERENCES Team(country),
                       FOREIGN KEY (sname) REFERENCES Stadium(sname)
);

CREATE TABLE PlayerinMatch (
                               pid INT,
                               mid INT,
                               from_time TIME,
                               to_time TIME,
                               dposition VARCHAR(255),
                               yellow INT,
                               red INT,
                               PRIMARY KEY (pid, mid),
                               FOREIGN KEY (pid) REFERENCES Player(pid),
                               FOREIGN KEY (mid) REFERENCES Match(mid)
);

CREATE TABLE RefereeMatch (
                              rid INT,
                              mid INT,
                              rrole VARCHAR(255),
                              PRIMARY KEY (rid, mid),
                              FOREIGN KEY (rid) REFERENCES Referee(rid),
                              FOREIGN KEY (mid) REFERENCES Match(mid)
);

CREATE TABLE Goals (
                       mid INT,
                       gno INT,
                       minute TIME,
                       p_kick BOOLEAN,
                       pid INT,
                       PRIMARY KEY (mid, gno),
                       FOREIGN KEY (mid) REFERENCES Match(mid),
                       FOREIGN KEY (pid) REFERENCES Player(pid)
);

CREATE TABLE Stadium (
                         sname VARCHAR(255) PRIMARY KEY,
                         capacity INT,
                         location VARCHAR(255)
);

CREATE TABLE Category (
                          mid INT,
                          level INT,
                          price DECIMAL(8,2),
                          PRIMARY KEY (mid, level),
                          FOREIGN KEY (mid) REFERENCES Match(mid)
);

CREATE TABLE Seat (
                      seatid INT PRIMARY KEY,
                      sname VARCHAR(255),
                      FOREIGN KEY (sname) REFERENCES Stadium(sname)
);

CREATE TABLE SeatCat (
                         seat_id INT,
                         sname VARCHAR(255),
                         mid INT,
                         level INT,
                         PRIMARY KEY (seat_id),
                         FOREIGN KEY (seat_id, sname) REFERENCES Seat(seatid, sname),
                         FOREIGN KEY (mid, level) REFERENCES Category(mid, level)
);

CREATE TABLE Customer (
                          login VARCHAR(255) PRIMARY KEY,
                          address VARCHAR(255),
                          pw VARCHAR(255)
);

CREATE TABLE Purchase (
                          putid INT PRIMARY KEY,
                          pdate DATE,
                          TotalPrice DECIMAL(8,2),
                          login VARCHAR(255),
                          FOREIGN KEY (login) REFERENCES Customer(login)
);

CREATE TABLE PurCat (
                        purid INT,
                        mid INT,
                        level INT,
                        number INT,
                        PRIMARY KEY (purid, mid, level),
                        FOREIGN KEY (purid) REFERENCES Purchase(putid),
                        FOREIGN KEY (mid, level) REFERENCES Category(mid, level)
);

CREATE TABLE SeatSelection (
                               sname VARCHAR(255),
                               seat_id INT,
                               purid INT,
                               PRIMARY KEY (sname, seat_id, purid),
                               FOREIGN KEY (sname, seat_id) REFERENCES Seat(sname, seatid),
                               FOREIGN KEY (purid) REFERENCES Purchase(putid)
);

