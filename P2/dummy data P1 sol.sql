-- inserting dummy data into the Team table
INSERT INTO Team (country, association, URL, group) VALUES
                                                        ('Brazil', 'CBF', 'https://www.cbf.com.br/', 'B'),
                                                        ('Germany', 'DFB', 'https://www.dfb.de/', 'F'),
                                                        ('Spain', 'RFEF', 'https://www.rfef.es/', 'E'),
                                                        ('Argentina', 'AFA', 'https://www.afa.com.ar/', 'A'),
                                                        ('France', 'FFF', 'https://www.fff.fr/', 'F'),
                                                        ('Italy', 'FIGC', 'https://www.figc.it/', 'A'),
                                                        ('Netherlands', 'KNVB', 'https://www.knvb.nl/', 'C'),
                                                        ('Portugal', 'FPF', 'https://www.fpf.pt/', 'F'),
                                                        ('Uruguay', 'AUF', 'https://www.auf.org.uy/', 'C'),
                                                        ('Belgium', 'RBFA', 'https://www.rbfa.be/', 'B'),
                                                        ('England', 'FA', 'https://www.thefa.com/', 'D'),
                                                        ('Switzerland', 'SFV', 'https://www.football.ch/', 'A'),
                                                        ('Colombia', 'FCF', 'https://www.fcf.com.co/', 'B'),
                                                        ('Mexico', 'FMF', 'https://miseleccion.mx/', 'A'),
                                                        ('Chile', 'ANFP', 'https://www.anfp.cl/', 'C'),
                                                        ('Japan', 'JFA', 'https://www.jfa.jp/', 'D'),
                                                        ('Sweden', 'SvFF', 'https://www.svenskfotboll.se/', 'E'),
                                                        ('Denmark', 'DBU', 'https://www.dbu.dk/', 'B'),
                                                        ('Poland', 'PZPN', 'https://www.pzpn.pl/', 'E'),
                                                        ('Norway', 'NFF', 'https://www.fotball.no/', 'G'),
                                                        ('Peru', 'FPF', 'https://www.fpf.org.pe/', 'C'),
                                                        ('Russia', 'RFS', 'https://www.rfs.ru/', 'H'),
                                                        ('Senegal', 'FSF', 'https://www.fsfoot.sn/', 'H'),
                                                        ('Croatia', 'HNS', 'https://hns-cff.hr/', 'D'),
                                                        ('Iceland', 'KSÍ', 'https://www.ksi.is/', 'D');

-- inserting dummy data into the Player table
INSERT INTO Player (pid, name, DOB, shirt_no, position, country) VALUES
                                                                     (1, 'Lionel Messi', '1987-06-24', 10, 'Forward', 'Argentina'),
                                                                     (2, 'Cristiano Ronaldo', '1985-02-05', 7, 'Forward', 'Portugal'),
                                                                     (3, 'Neymar Jr', '1992-02-05', 10, 'Forward', 'Brazil'),
                                                                     (4, 'Robert Lewandowski', '1988-08-21', 9, 'Forward', 'Poland'),
                                                                     (5, 'Kevin De Bruyne', '1991-06-28', 7, 'Midfielder', 'Belgium'),
                                                                     (6, 'Kylian Mbappé', '1998-12-20', 7, 'Forward', 'France'),
                                                                     (7, 'Sadio Mané', '1992-04-10', 10, 'Forward', 'Senegal'),
                                                                     (8, 'Sergio Agüero', '1988-06-02', 10, 'Forward', 'Argentina'),
                                                                     (9, 'Luis Suárez', '1987-01-24', 9, 'Forward', 'Uruguay'),
                                                                     (10, 'Harry Kane', '1993-07-28', 9, 'Forward', 'England'),
                                                                     (11, 'Mohamed Salah', '1992-06-15', 11, 'Forward', 'Egypt'),
                                                                     (12, 'Raheem Sterling', '1994-12-08', 7, 'Forward', 'England'),
                                                                     (13, 'Virgil van Dijk', '1991-07-08', 4, 'Defender', 'Netherlands'),
                                                                     (14, 'Manuel Neuer', '1986-03-27', 1, 'Goalkeeper', 'Germany'),
                                                                     (15, 'Joshua Kimmich', '1995-02-08', 6, 'Defender', 'Germany'),
                                                                     (16, 'Eden Hazard', '1991-01-07', 7, 'Forward', 'Belgium'),
                                                                     (17, 'Luka Modric', '1985-09-09', 10, 'Midfielder', 'Croatia'),
                                                                     (18, 'Sergio Ramos', '1986-03-30', 4, 'Defender', 'Spain'),
                                                                     (19, 'Paul Pogba', '1993-03-15', 6, 'Midfielder', 'France'),
                                                                     (20, 'Gareth Bale', '1989-07-16', 11, 'Forward', 'Wales'),
                                                                     (21, 'Leroy Sané', '1996-01-11', 19, 'Forward', 'Germany'),
                                                                     (22, 'Heung-min Son', '1992-07-08', 7, 'Forward', 'South Korea'),
                                                                     (23, 'Marc-André ter Stegen', '1992-04-30', 1, 'Goalkeeper', 'Germany'),
                                                                     (24, 'Jan Vertonghen', '1987-04-24', 5, 'Defender', 'Belgium'),
                                                                     (25, 'Thiago Alcântara', '1991-04-11', 6, 'Midfielder', 'Spain');

