import java.sql.* ;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Objects;
import java.util.Scanner;

public class Soccer {

  public static Scanner scanner = new Scanner(System.in);
  public static String your_userid = "";
  public static String your_password = "";
  public static String url = "jdbc:db2://winter2023-comp421.cs.mcgill.ca:50000/cs421";
  public static Statement statement;
  public static String dateForDisplayCountryGames = "2024-12-01"; // only to show some null values. can be replaced to today date but null values everywhere since the dates are all after today.
  public static int MAX_PLAYERS = 11;
  public static int currentNumOfPlayers = 0;
  public static LocalDate sDateForDisplayMatches =  LocalDate.now();
  public static LocalDate eDateForDisplayMatches = sDateForDisplayMatches.plusDays(3);

  public static HashMap<Integer, Integer> numToPLayer = new HashMap<>();


  public static void startConnection() throws SQLException {
    try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
    catch (Exception cnfe){ System.out.println("Class not found"); }

    Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
    statement = con.createStatement ( ) ;

  }
  public static void displayCountryGames(String country) {
    try
    {
      String querySQL = "WITH COUNTRYMATCHES AS (\n"+
            "SELECT MID, TEAM1, TEAM2, DATE, ROUND\n"+
            "FROM MATCH\n"+
            "WHERE TEAM2 = '%s' or TEAM1 = '%s'\n"+
        "), MATCHTICKETS AS (\n"+
            "SELECT TICKET.MID, COUNT(*) AS TICKETSSOLD\n"+
            "FROM TICKET, COUNTRYMATCHES\n"+
            "WHERE COUNTRYMATCHES.MID = TICKET.MID\n"+
            "GROUP BY TICKET.MID\n"+
        "), MATCHGOALS AS (\n"+
            "SELECT MID, FORTEAM, COUNT(*) AS NUMBEROFGOALS\n"+
            "FROM GOALINFO\n"+
            "GROUP BY MID, FORTEAM\n"+
        "),  BASETABLE AS (\n"+
            "SELECT MATCHTICKETS.MID, TEAM1, TEAM2, DATE, ROUND, TICKETSSOLD\n"+
            "FROM COUNTRYMATCHES, MATCHTICKETS, GOALINFO\n"+
            "WHERE MATCHTICKETS.MID = COUNTRYMATCHES.MID\n"+
            "group by MATCHTICKETS.MID, TEAM1, TEAM2, DATE, ROUND, TICKETSSOLD\n"+
        "), GOALSFORTEAM1 AS (\n"+
            "SELECT TEAM1, TEAM2, DATE, ROUND, TICKETSSOLD, (CASE WHEN DATE < '%s' THEN COALESCE(NUMBEROFGOALS, 0) END)AS TEAM1GOALS\n"+
            "FROM BASETABLE\n"+
                     "LEFT OUTER JOIN MATCHGOALS ON BASETABLE.TEAM1 = MATCHGOALS.FORTEAM and BASETABLE.MID = MATCHGOALS.MID\n"+
        "), GOALSFORTEAM2 AS (\n"+
            "SELECT TEAM1, TEAM2, DATE, ROUND, TICKETSSOLD, (CASE WHEN DATE < '%s' THEN COALESCE(NUMBEROFGOALS, 0) END) AS TEAM2GOALS\n"+
            "FROM BASETABLE\n"+
                     "LEFT OUTER JOIN MATCHGOALS ON BASETABLE.TEAM2 = MATCHGOALS.FORTEAM and BASETABLE.MID = MATCHGOALS.MID\n"+
        ")\n"+
        "SELECT T1.TEAM1, T1.TEAM2, T1.DATE, T1.ROUND, T1.TEAM1GOALS, T2.TEAM2GOALS, T1.TICKETSSOLD\n"+
        "FROM GOALSFORTEAM1 T1, GOALSFORTEAM2 T2\n"+
        "WHERE T1.TEAM1 = T2.TEAM1 AND T1.TEAM2 = T2.TEAM2 AND T1.ROUND = T2.ROUND AND T1.DATE = T2.DATE AND T1.TICKETSSOLD = T2.TICKETSSOLD"
      ;

      String formattedQuery = String.format(querySQL, country, country, dateForDisplayCountryGames, dateForDisplayCountryGames);

      System.out.println("Team1\tTeam2\tDate\tGroup\tTeam 1 Goals\tTeam 2 Goals\tTickets Sold");

      java.sql.ResultSet rs = statement.executeQuery(formattedQuery);

      while ( rs.next ( ) )
      {
        String t1 = rs.getString (1);
        String t2 = rs.getString (2);
        Date date = rs.getDate (3);
        String g = rs.getString (4);
        String t1g = rs.getString(5);
        String t2g = rs.getString(6);
        int ts = rs.getInt(7);
        System.out.println ("" + t1 + "\t" + t2 + "\t" + date + "\t" + g + "\t" + t1g + "\t" + t2g + "\t" + ts);
      }
    }
    catch (SQLException e)
    {
      System.out.println(e);
    }
  }
  public static void displayTicketInfo() {
    try {
      String querySQL =
      "SELECT NAME AS STADIUMNAME, TEAM1, TEAM2, DATE,TICKETSSOLD,(MAXCAPACITY - TICKETSSOLD) AS TICKETSLEFT,AVGPRICESOLD, TOTALREVENUE\n"+
      "FROM STADIUM,MATCH,(SELECT TICKET.MID,COUNT(TICKET.TID) AS TICKETSSOLD,AVG(PRICE) AS AVGPRICESOLD, SUM(PRICE) AS TOTALREVENUE\n"+
                          "FROM TICKET,MATCH,SALES\n"+
                          "WHERE MATCH.MID = TICKET.MID AND SALES.TID = TICKET.TID\n"+
                          "GROUP BY TICKET.MID) AS TICKINFO\n"+
      "WHERE NAME = MATCH.STADIUM AND TICKINFO.MID = MATCH.MID\n"+
      "ORDER BY TICKETSSOLD DESC";

      System.out.println("Stadium Name\tTeam1\tTeam2\tDate\tTickets Sold\tTickets Left\tAverage Price Sold\tTotal Revenue");
      java.sql.ResultSet rs = statement.executeQuery(querySQL);

      while ( rs.next ( ) ) {
        String stadiumName = rs.getString(1);
        String team1 = rs.getString(2);
        String team2 = rs.getString(3);
        Date date = rs.getDate(4);
        int ticketsSold = rs.getInt(5);
        int ticketsLeft = rs.getInt(6);
        double avgPrice = rs.getDouble(7);
        double revenue = rs.getDouble(8);
        System.out.println ("" + stadiumName + "\t\t" + team1 + "\t" + team2 + "\t" + date + "\t" + ticketsSold + "\t" + ticketsLeft + "\t" + avgPrice + "\t" + revenue);
      }
    } catch (SQLException e) {
      System.out.println(e);
    }
  }

  public static void displayMatches(){
    try {
      String querySQL =
      "SELECT MID, TEAM1, TEAM2, DATE, ROUND\n"+
      "FROM MATCH\n"+
      "WHERE DATE >= '%s' AND DATE <= '%s' AND TEAM1 IS NOT NULL AND TEAM2 IS NOT NULL\n"+
      "ORDER BY DATE"
      ;
      String formattedQuery = String.format(querySQL,sDateForDisplayMatches, eDateForDisplayMatches);
      System.out.println("Matches:");
      System.out.println("MID\tTeam1\tTeam2\tDate\tRound");
      java.sql.ResultSet rs = statement.executeQuery(formattedQuery);

      while ( rs.next ( ) ) {
        int mid = rs.getInt(1);
        String team1 = rs.getString(2);
        String team2 = rs.getString(3);
        Date date = rs.getDate(4);
        String round = rs.getString(5);
        System.out.println ("" + mid + "\t" + team1 + "\t" + team2 + "\t" + date + "\t" + round);
      }
      System.out.println();
    } catch (SQLException e) {
      System.out.println(e);
    }
  }

  public static void displayPlayersForMatch(int mid, String country){
    try {
      String querySQL =
          "SELECT FNAME, LNAME, PERSON.PID, POS\n"+
          "FROM PERSON, INITIALPLAYERFORMATION\n"+
          "WHERE INITIALPLAYERFORMATION.TEAM = '%s' AND INITIALPLAYERFORMATION.MID = %d and PERSON.PID = INITIALPLAYERFORMATION.PID";
      String formattedQuery = String.format(querySQL, country, mid);
      System.out.println("The following players from " +country+ " are already entered for match "+ mid +":");
      System.out.println();
      java.sql.ResultSet rs = statement.executeQuery(formattedQuery);
      currentNumOfPlayers = 0;
      while ( rs.next ( ) ) {
        String fname = rs.getString(1);
        String lname = rs.getString(2);
        int pid = rs.getInt(3);
        String pos = rs.getString(4);
        System.out.println ("" + fname + "\t" + lname + "\t" + pid + "\t" + pos + "\tfrom minute 0 to minute NULL yellow: 0 red: 0");
        currentNumOfPlayers += 1;
      }
      System.out.println();
    } catch (SQLException e) {
      System.out.println(e);
    }
  }

  public static void displayPlayersNotInGame(int mid, String country){
    try {
      String querySQL =
              "SELECT FNAME, LNAME, PLAYER.PID, GENPOS\n"+
              "FROM PERSON, PLAYER, PLAYERTEAM\n"+
              "WHERE PERSON.PID = PLAYER.PID AND PLAYER.PID = PLAYERTEAM.PID AND PLAYERTEAM.TEAM = '%s'\n"+
              "AND PERSON.PID NOT IN (\n"+
              "      SELECT PERSON.PID\n"+
              "      FROM PERSON, INITIALPLAYERFORMATION\n"+
              "      WHERE INITIALPLAYERFORMATION.TEAM = '%s' AND INITIALPLAYERFORMATION.MID = %d and PERSON.PID = INITIALPLAYERFORMATION.PID\n"+
              "    )";

      String formattedQuery = String.format(querySQL,country, country, mid);
      System.out.println("Possible players from "+ country +" not yet selected: ");
      System.out.println();
      java.sql.ResultSet rs = statement.executeQuery(formattedQuery);
      int i = 1;
      while ( rs.next ( ) ) {
        String fname = rs.getString(1);
        String lname = rs.getString(2);
        int pid = rs.getInt(3);
        String pos = rs.getString(4);
        numToPLayer.put(i, pid);
        System.out.println (i + ". " + fname + "\t\t"+ lname + "\t\t"+ pid + "\t\t"+ pos + "\t\t");
        i++;
      }
      System.out.println();
    } catch (SQLException e) {
      System.out.println(e);
    }
  }

  public static void addPlayerToMatch(int i, int mid, String country, String pos) throws SQLException {
    if (MAX_PLAYERS == currentNumOfPlayers) {
	    System.out.println("Cannot add more players");
    } else {
    	String insertSQL =
    	"INSERT INTO InitialPlayerFormation (pid, team, pos, mid) VALUES ( %d , '%s', '%s', %d );";

    	String formattedQuery = String.format(insertSQL,numToPLayer.get(i), country, pos, mid);
    	statement.execute(formattedQuery);
  
    }
  }

  public static void displayMenu(){
    System.out.println();
    System.out.println(
        "Soccer Main Menu\n"+
        "    1. List information of matches of a country\n"+
        "    2. Insert initial player information for a match\n"+
        "    3. List information about teams, matches, ticket sales, and their average price sold and the total revenue\n"+
        "    4. Exit application\n"
    );
  }

  public static void main(String[] args) throws SQLException {

    startConnection();

    // loop until the user chooses to quit
    while (true) {
      displayMenu();
      System.out.print("Please Enter Your Option: ");
      int input = scanner.nextInt();
      System.out.println();

      if (input == 1) {
        System.out.print("Please a country: ");
        String country = scanner.next();
        displayCountryGames(country);
        String goBack = "";
        while (!Objects.equals(goBack, "p")) {
          System.out.println("Enter [a] to find matches of another country, [p] to go to the previous menu:");
          goBack = scanner.next();
          if (Objects.equals(goBack, "a")) {
            System.out.print("Please a country: ");
            country = scanner.next();
            displayCountryGames(country);
          }
        }
      }else if (input == 2) {
        String exit = "";
        while (!Objects.equals(exit, "p")) {
          displayMatches();
          System.out.println("Enter [p] to return to previous menu or enter a match id, and a country to continue: ");
          exit = scanner.next();
          if (!Objects.equals(exit, "p")) {
            int mid = Integer.parseInt(exit);
            String country = scanner.next();
            String goBack = "";
            while (!Objects.equals(goBack, "p")) {
              displayPlayersForMatch(mid, country);
              System.out.println();
              displayPlayersNotInGame(mid, country);
              System.out.println();
              System.out.println("Enter [p] to exit or enter a player and a position to add them to the match: ");
              goBack = scanner.next();
              if (!Objects.equals(goBack, "p")) {
                int player = Integer.parseInt(goBack);
                String pos = scanner.next();
                addPlayerToMatch(player,mid,country,pos);
              }
            }
          }
        }
      }else if (input == 3) {
        displayTicketInfo();
      } else if (input == 4) {
        System.out.println("Exiting program...");
        break;
      }
    }

    scanner.close();
  }
}
