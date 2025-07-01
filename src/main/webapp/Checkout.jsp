<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %> 
<%@ page import="java.text.SimpleDateFormat, java.text.ParseException, java.util.Date" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
//    Boolean userDetailsFilled = (Boolean) session.getAttribute("userDetailsFilled");
//    if (userDetailsFilled == null || !userDetailsFilled) {
//        response.sendRedirect("AddUser.jsp");
//        return;
//    }
%>

<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
int userid=(int) session.getAttribute("userid");

	Connection con;
	Statement stmt;
	PreparedStatement pst;
	ResultSet rs;
	
	String cs="jdbc:mysql://localhost:3306/jane";
	String driver="com.mysql.cj.jdbc.Driver";
	String uid="root";
	String pwd="jane";
	
	Class.forName(driver);
	con=DriverManager.getConnection(cs,uid,pwd);
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from users where id="+userid);	
	if(rs.next()){
%>


<form name= "userform" method='post' action='UserDetails.jsp' >
<table>
	<tr><center><h3>Fill User Details</h3></center></tr>
	<tr>
		<td>Name</td>
		<td><input type='text' name='txtname'value=<%=rs.getString("username")%> readonly ></td>
	</tr>
	
	<tr>
		<td>Address</td>
		<td><input type='text' name='txtaddr'value=<%=rs.getString("address")%> ></td>
	</tr>
	<tr>
		<td>Email</td>
		<td><input type='text' name='txtemail'value=<%=rs.getString("email")%> ></td>
	</tr>
	<tr>
		<td>Phone</td>
		<td><input type='text' name='txtphno'value=<%=rs.getInt("phone")%> ></td>
	</tr>
	
	<tr> <td colspan=2>
		<center><input type='submit' value='Update and Continue'></center>
		</td>
	</tr>
</table>
</form>
<%} %>

</body>
</html>