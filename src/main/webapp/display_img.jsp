<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Display Image</title>
</head>
<body>
    <h2>Display an Image</h2>

    <%
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jane", "root", "jane");
	
	        String sql = "SELECT id, name, image, category FROM images WHERE category='mobile'";
	        PreparedStatement statement = con.prepareStatement(sql);
	
	        ResultSet resultSet = statement.executeQuery();
	        out.print("<table border='1'>");
	        out.println("<tr><th>Category</th><th>Image</th></tr>");
	        while (resultSet.next()) {
	        	String category = resultSet.getString("category");
	            String imageName = resultSet.getString("name");  // Retrieve image name
	            int id = resultSet.getInt("id");  // Retrieve image ID

	            out.println("<tr>");
	            out.print("<td>" + category + "</td>");
	            out.print("<td>" + imageName + "</td>");  // Display image name
	            out.println("<td><img src='displayImage.jsp?id=" + id + "' width='150' height='150'/></td>");
	            out.println("</tr>");
	        }
	        out.print("</table>");
            con.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>