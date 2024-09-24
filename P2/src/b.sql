with playerMatchCount as (select pid, count(*) as mc
                          from PLAYERGAMEINFO
                          group by pid),
    team1Count as (select TEAM1, count(*) t1c
                 from MATCH
                 group by TEAM1),
    team2Count as (select TEAM2, count(*) t2c
                    from MATCH
                    group by TEAM2),
    teamMatchCount as (select TEAM1, t2c + t1c as mc
                       from team1Count
                           inner join team2Count on TEAM2 = TEAM1
                       union
                       select TEAM1, t1c
                       from team1Count
                           left join team2Count on TEAM2 = TEAM1
                       where TEAM2 is null
                       union
                       select TEAM2, t2c
                       from team2Count
                           left join team1Count on TEAM2 = TEAM1
                       where TEAM1 is null
                       )
select p.FNAME, p.LNAME, pt.TEAM, pl.SHIRTNUM
from PLAYERTEAM pt
inner join PERSON P on pt.PID = P.PID
inner join PLAYER pl on pl.PID = p.PID
inner join playerMatchCount pmc on pmc.PID = pl.PID
inner join teamMatchCount tmc on tmc.TEAM1 = pt.TEAM
where tmc.mc = pmc.mc;

