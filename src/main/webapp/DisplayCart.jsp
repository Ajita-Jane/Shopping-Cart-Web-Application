<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%   
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
int userid=(int) session.getAttribute("userid");
out.println(role+": "+username);

    Connection con;
	Statement stmt;
	PreparedStatement pst;
	PreparedStatement pstdel;
	PreparedStatement pstdis;
	ResultSet rs;
	
	String cs="jdbc:mysql://localhost:3306/jane";
	String driver="com.mysql.cj.jdbc.Driver";
	String uid="root";
	String pwd="jane";
	Class.forName(driver);
	con=DriverManager.getConnection(cs,uid,pwd);	
	
	String display = "select * from cart where userid="+userid;
	pstdis = con.prepareStatement(display);
	rs = pstdis.executeQuery();
	%>
<h2>Shopping Cart</h2>
	<table border="1">
	    <tr>
	        <th>User ID</th>
	        <th>Product ID</th>
	        <th>Quantity</th>
	        <th>Rate</th>
	        <th>Amount</th>
	        
	<%while (rs.next()) 
	{ 
		%>
		    <tr>
		        <td><%= rs.getInt("Userid") %></td>
		        <td><%= rs.getInt("prodid") %></td>
		        <td><%= rs.getInt("qty") %></td>
		        <td><%= rs.getInt("rate") %></td>
		        <td><%= rs.getInt("amount") %></td>
		        <td><a href="EditProd.jsp?id=<%=rs.getInt("prodid") %>">Edit</a></td>
				<td><a href="DeleteProd.jsp?id=<%=rs.getInt("prodid") %>">Delete</a></td>
		    </tr>
<%
	}
%>
	</table>
	<form action="ImageJsp.jsp" method="get">
	    <input type="submit" value="Home" />
	</form>
	
	<form action="Checkout.jsp" method="post">
	    <input type="submit" value="Checkout" />
	</form>

</body>
</html>