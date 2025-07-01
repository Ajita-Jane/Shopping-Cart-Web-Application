<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Records Table</title>
    <style>   
        .table-container {
            width: 80%;
            margin: auto;
        }
        .table-header, .table-row {
            display: flex;
            justify-content: center;
            border-bottom: 1px solid black;
        }
        .table-header div, .table-row div {
            flex: 1;
            padding: 8px;
            text-align: center;
        }
        .table-header div {
            font-weight: bold;
            background-color: #f2f2f2;
        }
        .table-row {
            justify-content: space-evenly;
        }
        img {
            max-width: 250px;
            max-height: 200px;
        }
        td{
        	padding: 25px;
        }
    </style>
</head>
<body>
<%
	String username = (String) session.getAttribute("username");
	String role = (String) session.getAttribute("role");
	int userid=(int) session.getAttribute("userid");
	out.println(role+": "+username);
	//session.setAttribute("userDetails", false); // User details not filled yet
    if (request.getMethod().equals("GET")) {
%>
    <form name="catselect" method="post" action="ImageJsp.jsp">
        <table>
            <tr>
                <td>Choose the Product Category</td>
                <td>        
                    <select name="cat">
                        <option value="Mobile">Mobile</option>
                        <option value="Laptop">Laptop</option>
                    </select>
                </td>
                <td><input type="submit" value="search"></td>
            </tr>
        </table>
    </form>
    
<%
    } else {
%>
    <h2>Gadgets</h2>
    <div class="table-container">
        <div class="table-header">
            
            <div>Products</div>
            
        </div>
<%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jane", "root", "jane");
            String cat = request.getParameter("cat");
            String sql = "SELECT * FROM images WHERE category='" + cat + "'";
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            int col = 0;
            while (resultSet.next()) {
                if (col % 3 == 0) {
%>
        <div class="table-row">
<%
                }
%>
            <div>
                <a href="Product_Details.jsp?id=<%= resultSet.getInt("id") %>">
                    <img src="ImageServlet?id=<%= resultSet.getInt("id") %>" alt="Blob Image" /><br>
                </a>
                <%= resultSet.getString("description") %>
            </div>
<%
                col++;
                if (col % 3 == 0) {
%>
        </div>
<%
                }
            }

            if (col % 3 != 0) {
%>
        </div>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
%>
    </div>
<%
    }
%>

<form action="DisplayCart.jsp" method="get">
	    <input type="submit" value="Show Cart" />
</form>
</body>
</html>
