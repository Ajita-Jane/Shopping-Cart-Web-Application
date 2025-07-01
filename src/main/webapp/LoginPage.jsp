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
if(request.getMethod().equals("GET")){	
%>

<h2>Login</h2>
    <form name= "Loginform" method='post' action='LoginPage.jsp' >
        <table>
		<tr>
			<td>Username</td>
			<td><input type='text' name='txtuname' ></td>
		</tr>
		
		<tr>
			<td>Password</td>
			<td><input type='text' name='txtpwd' ></td>
		</tr>
		
		<tr> <td colspan=2>
			<input type='submit' value='Login'>
			</td>
		</tr>
		</table>
    </form>


<%}

else{
	String uname=request.getParameter("txtuname");
	String upwd=request.getParameter("txtpwd");
	
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
	String sql="select * from users where username=? and password=?";
	pst=con.prepareStatement(sql);
	pst.setString(1,uname);
	pst.setString(2,upwd);
	rs = pst.executeQuery();
	if (rs.next()) {
        String role = rs.getString("role");
        session.setAttribute("userid",rs.getInt("id"));
        session.setAttribute("username", uname);
        session.setAttribute("role", role);

        if ("admin".equals(role)) {
            response.sendRedirect("adminDashboard.jsp");
        } else if ("user".equals(role)) {
            response.sendRedirect("ImageJsp.jsp");
        } else {
            response.sendRedirect("LoginPage.jsp?error=Invalid role");
        }
    } else {
        response.sendRedirect("LoginPage.jsp?error=Invalid credentials");
    }
	

}
%>

</body>
</html>