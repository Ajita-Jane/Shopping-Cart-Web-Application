<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
//    Boolean userDetailsFilled = (Boolean) session.getAttribute("userDetailsFilled");
  //  if (userDetailsFilled == null || !userDetailsFilled) {
    //    response.sendRedirect("AddUser.jsp");
      //  return;
    //}
%>


<%int imageId = Integer.parseInt(request.getParameter("id"));
String space=": ";
%>
<table>
<thead>
            <tr>
                <th style = "width: 90pix; "></th>
                <th style = "width: 90pix; ">Colour</th>
                <th style = "width: 90pix; ">Price</th>
                
            </tr>
        </thead>
       <%try 
       {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jane", "root", "jane");
			String cat=request.getParameter("cat");
	        String sql = "SELECT * FROM images WHERE id='"+imageId+"'";
	        PreparedStatement statement = con.prepareStatement(sql);
	        ResultSet resultSet = statement.executeQuery();
	        while(resultSet.next())
	        {
	   %>	   
	   		<h2><%=resultSet.getString("category") %><%=space%><%=resultSet.getString("description")%> </h2>    	      	
            <tr>
                <td style = "width: 90pix; ">                    	  
                	<img src="ImageServlet?id=<%=resultSet.getInt("id")%>" alt="Blob Image" width=250pix height = 200pix /><br>
                </td> 
                <td>   
                	<%=resultSet.getString("colour")%>
                
                </td>
                <td>
                	<%=resultSet.getInt("price")%>  
                </td>
                	        	
            </tr>
            <tr>    
	            <td> 
	              	<%=resultSet.getString("info")%> 	        
	            </td>
            </tr>
            
            <tr>
	            <form name="f1" action="CartAdd.jsp" method="post">   
			    <td><input type="text" name="txtquantity" placeholder="Enter quantity" required></td>
			    <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>">
			    <input type="hidden" name="price" value="<%= resultSet.getInt("price") %>">
			    <td><input type="submit" value="Add to Cart"></td>
				</form> 
			</tr>
  		
       <%	}
	    }       
        catch(Exception e)
        {
        	e.printStackTrace();	
        }
       %> 
</table>
</body>
</html>