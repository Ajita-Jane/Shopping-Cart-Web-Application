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
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
int userid=(int) session.getAttribute("userid");

if(request.getMethod().equals("GET")){
	
	int id=Integer.parseInt(request.getParameter("id"));
	Connection con;
	Statement stmt;
	PreparedStatement pst, pstdis;
	ResultSet rs;
	
	String cs="jdbc:mysql://localhost:3306/jane";
	String driver="com.mysql.cj.jdbc.Driver";
	String uid="root";
	String pwd="jane";
	
	Class.forName(driver);
	con=DriverManager.getConnection(cs,uid,pwd);
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from cart where prodid="+request.getParameter("id")+" and userid="+userid);	
	if(rs.next()){
%>

<form name= "deleteform" method='post' action='DeleteProd.jsp' >
<table>
	<tr>
		<td>Id</td>
		<td><input type='text' name='txtid'value=<%=rs.getInt("prodid")%> readonly ></td>
	</tr>
	<tr>
		<td>Quantity</td>
		<td><input type='text' name='txtqty'value=<%=rs.getString("qty")%> readonly></td>
	</tr>
	<tr>
		<td>Rate</td>
		<td><input type='text' name='txtrate'value=<%=rs.getString("rate")%> readonly></td>
	</tr>
	<tr>
		<td>Amount</td>
		<td><input type='text' name='txtamount'value=<%=rs.getInt("amount")%> readonly></td>
	</tr>
	
	<tr> <td colspan=2>
		<input type='submit' value='delete'>
		</td>
	</tr>
</table>
</form>
<%}}

else{
	int pid=Integer.parseInt(request.getParameter("txtid"));	
	
	Connection con;
	Statement stmt;
	PreparedStatement pst,psthead,pstdis;
	ResultSet rs;
	
	String cs="jdbc:mysql://localhost:3306/jane";
	String driver="com.mysql.cj.jdbc.Driver";
	String uid="root";
	String pwd="jane";
	Class.forName(driver);
	con=DriverManager.getConnection(cs,uid,pwd);
	String sql="delete from cart where prodid="+pid+" and userid="+userid;
	pst=con.prepareStatement(sql);	
	pst.execute();
	
	String display = "select count(*),sum(amount) from cart where userid="+userid;
	pstdis = con.prepareStatement(display);
	rs = pstdis.executeQuery();
	if (rs.next()) 
	{	
		Date curdate = new Date();
		java.sql.Date sqlDate = new java.sql.Date(curdate.getTime());
		
		String q="update headercart set date=?, totalitems=? , billamount=? where userid=?";
		psthead=con.prepareStatement(q);
		psthead.setDate(1, sqlDate);
		psthead.setInt(2,rs.getInt("count(*)"));
		psthead.setInt(3,rs.getInt("sum(amount)"));
		psthead.setInt(4,userid);
		psthead.execute();
	}
	
	response.sendRedirect("ImageJsp.jsp");

}
%>

</body>
</html>