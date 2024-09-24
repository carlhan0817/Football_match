CREATE TABLE Player (
                        pid INT NOT NULL,
                        shirtNum INT NOT NULL,
                        genPos VARCHAR(50) NOT NULL CONSTRAINT NotAValidPosition CHECK ( genPos in ('Forward', 'Striker', 'Winger', 'Attacking Midfielder', 'Central Midfielder', 'Defensive Midfielder', 'Full-back', 'Centre-back', 'Sweeper', 'Goalkeeper') ),
                        PRIMARY KEY (pid),
                        FOREIGN KEY (pid) REFERENCES Person(pid)
);