SELECT NAME AS STADIUMNAME, TEAM1, TEAM2, DATE,TICKETSSOLD,(MAXCAPACITY - TICKETSSOLD) AS TICKETSLEFT,AVGPRICESOLD, TOTALREVENUE
FROM STADIUM,MATCH,(SELECT TICKET.MID,COUNT(TICKET.TID) AS TICKETSSOLD,AVG(PRICE) AS AVGPRICESOLD, SUM(PRICE) AS TOTALREVENUE
                    FROM TICKET,MATCH,SALES
                    WHERE MATCH.MID = TICKET.MID AND SALES.TID = TICKET.TID
                    GROUP BY TICKET.MID) AS TICKINFO
WHERE NAME = MATCH.STADIUM AND TICKINFO.MID = MATCH.MID
ORDER BY TICKETSSOLD DESC;