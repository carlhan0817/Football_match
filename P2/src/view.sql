CREATE VIEW playerinfo AS
SELECT p.fname, p.lname, pl.shirtNum, p.DOB, t.country, t.officialName as association, t."group"
FROM Person p
         JOIN Player pl ON p.pid = pl.pid
         JOIN PlayerTeam pt ON pl.pid = pt.pid
         JOIN Team t ON pt.team = t.country;

insert into playerinfo values ('Daniel', 'Lee', 23, '2000-01-01', 'Spain', 'Royal Spanish Football Federation', 'E');

select * from playerinfo;
drop view PLAYERINFO;