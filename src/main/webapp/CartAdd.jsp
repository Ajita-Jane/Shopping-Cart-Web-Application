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

    String txtquantity = request.getParameter("txtquantity");
    String txtid = request.getParameter("id");
	String txtrate = request.getParameter("price");
	int qty = Integer.parseInt(txtquantity);
	int prodid = Integer.parseInt(txtid);
	int rate = Integer.parseInt(txtrate);
    
    
    Connection con;
	Statement stmt;
	PreparedStatement pst;
	PreparedStatement pstdel;
	PreparedStatement pstdis;
	PreparedStatement psthead;
	ResultSet rs;
	
	String cs="jdbc:mysql://localhost:3306/jane";
	String driver="com.mysql.cj.jdbc.Driver";
	String uid="root";
	String pwd="jane";
	Class.forName(driver);
	con=DriverManager.getConnection(cs,uid,pwd);
	
	String delquery="delete from cart where prodid= ? and userid=?";
	pstdel=con.prepareStatement(delquery);
	pstdel.setInt(1,prodid);
	pstdel.setInt(2,userid);
	pstdel.execute();
	
	String sql="insert into cart (prodid, qty, rate , amount, userid) values (?,?,?,?,?)";
	pst=con.prepareStatement(sql);
	pst.setInt(1,prodid);
	pst.setInt(2,qty);
	pst.setInt(3,rate);
	pst.setInt(4,qty*rate);
	pst.setInt(5,userid);
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
%>


</body>
</html>