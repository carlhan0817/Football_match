with A as ( select MID
            from GOALINFO G
            where G.PLAYER = (
                select p.PID
                from PLAYER p
                intersect
                select p.pid
                from PERSON p
                where p.FNAME = 'Christine' and p.LNAME = 'Sinclair'
            )
)
SELECT S.NAME,S.LOCATION,M.DATE
from MATCH M
         join STADIUM S on M.STADIUM = S.NAME
         join A on A.MID =  M.MID;