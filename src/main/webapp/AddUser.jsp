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
if(request.getMethod().equals("GET")){

%>
<form name="f1" action="AddUser.jsp" method="post">  
<table> 
	<tr><td><input type="text" name="txtname" placeholder="Enter User Name" required></td></tr>
	<tr><td><input type="text" name="txtuserid" placeholder="Enter User ID" required></td></tr>
	<tr><td><input type="text" name="txtaddr" placeholder="Enter Address" required></td></tr>
	<tr><td><input type="text" name="txtemail" placeholder="Enter Email" required></td></tr>
	<tr><td><input type="text" name="txtphno" placeholder="Enter Phone Number" required></td></tr>
    <tr><td><input type="submit" value="Add User"></td></tr>
</table>
</form> 
<%}
else{
	
	String username = request.getParameter("txtname");
	String userid = request.getParameter("txtuserid");
	String addr = request.getParameter("txtaddr");
	String email = request.getParameter("txtemail");
	String phno = request.getParameter("txtphno");

	Date curdate = new Date();
	java.sql.Date sqlDate = new java.sql.Date(curdate.getTime());
	out.println("userid " + username);
	out.println("date: " + sqlDate);
	
	Connection con;
	Statement stmt;
	PreparedStatement pst;
	PreparedStatement pstdel;
	ResultSet rs;
	
	String cs="jdbc:mysql://localhost:3306/jane";
	String driver="com.mysql.cj.jdbc.Driver";
	String uid="root";
	String pwd="jane";
	Class.forName(driver);
	con=DriverManager.getConnection(cs,uid,pwd);
	
	String sql="insert into usercart (username, date, userid, email, address, phone) values (?,?,?,?,?,?)";
	pst=con.prepareStatement(sql);
	pst.setString(1,username);
	pst.setDate(2, sqlDate);
	pst.setString(3,userid);
	pst.setString(4,email);
	pst.setString(5,addr);
	pst.setString(6,phno);
	
	pst.execute();
	
    session.setAttribute("userDetails", true); 
	out.println("adding");
    response.sendRedirect("ImageJsp.jsp");
}    
%>


</body>
</html>