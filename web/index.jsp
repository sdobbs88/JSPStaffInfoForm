<%-- 
/**
* Class: CSCI5520U Rapid Java Development
* Instructor: Y. Daniel Liang
* Description: JSP Web form that allows a user to enter, update and view 
* data from a database. Also has a clear form function
* Due: 02/13/2017
* @author Shaun C. Dobbs
* @version 1.0

* I pledge by honor that I have completed the programming assignment independently. 
* I have not copied the code from a student or any source. 
* I have not given my code to any student. 

Sign here: Shaun C. Dobbs
*/
    Document   : Exercise38_19
    Created on : Feb 7, 2017, 12:16:59 AM
    Author     : Shaun
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!--DATABASE CONNECTION-->
<%
    PreparedStatement pstmt;
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/javabook", "scott", "tiger");
    //Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/sdobbs1?autoReconnect=true", "sdobbs1", "Scmpd11809");
    pstmt = conn.prepareStatement("insert into staffinfo "
            + "(ID, lastName, firstName, mi, address, city, state, telephone) "
            + "values (?, ?, ?, ?, ?, ?, ?, ?)");
%>
<!--JAVA CODE TO PERFORM INSERT, UPDATE, VIEW AND CLEAR ACTIONS-->
<%
    String ID = "";
    //String ID = request.getParameter("ID");
    String lastName = "";
    String firstName = "";
    String mi = "";
    String address = "";
    String city = "";
    String state = "";
    String telephone = "";

    int IDcol;
    String idStr = "";
    String lastNameStr = "";
    String firstNameStr = "";
    String mIStr = "";
    String addressStr = "";
    String cityStr = "";
    String stateStr = "";
    String telStr = "";

    if (request.getParameter("insert") != null) {
        ID = request.getParameter("ID");
        lastName = request.getParameter("lastName");
        firstName = request.getParameter("firstName");
        mi = request.getParameter("mi");
        address = request.getParameter("address");
        city = request.getParameter("city");
        state = request.getParameter("state");
        telephone = request.getParameter("telephone");

        pstmt.setString(1, ID);
        pstmt.setString(2, lastName);
        pstmt.setString(3, firstName);
        pstmt.setString(4, mi);
        pstmt.setString(5, address);
        pstmt.setString(6, city);
        pstmt.setString(7, state);
        pstmt.setString(8, telephone);
        pstmt.executeUpdate();

        out.println(firstName + " " + lastName + " is now registered in the database");

    } else if (request.getParameter("view") != null) {
        ID = request.getParameter("ID");
        String query = "select * from staffinfo where id=" + ID + ";";
        ResultSet rs = pstmt.executeQuery(query);

        if (!rs.next()) {
            out.print("Error: ID not in database");
        }
        rs = pstmt.executeQuery(query);
        while (rs.next()) {
            IDcol = rs.getInt("ID");
            idStr = Integer.toString(IDcol);
            lastNameStr = rs.getString("lastName");
            firstNameStr = rs.getString("firstName");
            mIStr = rs.getString("mI");
            addressStr = rs.getString("address");
            cityStr = rs.getString("city");
            stateStr = rs.getString("state");
            telStr = rs.getString("telephone");

        }
        ID = idStr;
        lastName = lastNameStr;
        firstName = firstNameStr;
        mi = mIStr;
        address = addressStr;
        city = cityStr;
        state = stateStr;
        telephone = telStr;

    } else if (request.getParameter("update") != null) {
        ID = request.getParameter("ID");
        String query = "select * from staffinfo where id=" + ID + ";";
        ResultSet rs = pstmt.executeQuery(query);

        if (!rs.next()) {
            out.print("Error: ID not in database");
        } else {

            ID = request.getParameter("ID");
            lastName = request.getParameter("lastName");
            firstName = request.getParameter("firstName");
            mi = request.getParameter("mi");
            address = request.getParameter("address");
            city = request.getParameter("city");
            state = request.getParameter("state");
            telephone = request.getParameter("telephone");

            pstmt = conn.prepareStatement("delete from staffinfo where id = " + ID + ";");
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement("insert into staffinfo "
                    + "(ID, lastName, firstName, mi, address, city, state, telephone) "
                    + "values (?, ?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, ID);
            pstmt.setString(2, lastName);
            pstmt.setString(3, firstName);
            pstmt.setString(4, mi);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, telephone);
            pstmt.executeUpdate();

            out.println(firstName + " " + lastName + " has been updated in the database.");
        }
    } else if (request.getParameter("clear") != null) {
        response.sendRedirect("index.jsp");
        //response.sendRedirect("http://sdobbs1.s156.eatj.com");
    }

%>

<!--HTML FOR WEB PAGE-->
<html>
    <head>
        <title>Exercise 38_19</title>
    </head>
    <body>
        <table>
            <tr>
                <td>
                    <fieldset>
                        <legend>Staff Information</legend>
                        <form method = "post" action = "index.jsp">
                            <p>ID <input type = "text" value="<%out.print(ID);%>" name = "ID" size = "10" required>&nbsp;
                            </p>

                            <p>Last Name: <input type = "text" value="<%out.print(lastName);%>" name = "lastName" size = "20" >&nbsp;
                                First Name: <input type = "text"value="<%out.print(firstName);%>" name = "firstName" size = "20" >&nbsp;
                                MI: <input type = "text" value="<%out.print(mi);%>" name = "mi" size = "2">&nbsp;
                            </p>          

                            <p>Address: <input type = "text" value="<%out.print(address);%>" name = "address" size = "20" >
                            </p>

                            <p>City: <input type = "text" value="<%out.print(city);%>" name = "city" size = "20" >&nbsp;               
                                State: <input type = "text" value="<%out.print(state);%>" name = "state" size = "2" >
                            </p>

                            <p>Telephone <input type = "text" value="<%out.print(telephone);%>" name = "telephone" size = "15">&nbsp;
                            </p>
                            <p ALIGN="CENTER">
                                <input type = "submit" name = "insert" value = "Insert">
                                <input type = "submit" name = "view" value = "View">
                                <input type = "submit" name = "update" value = "Update">
                                <input type = "submit" value = "Clear">
                            </p>
                        </form>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
