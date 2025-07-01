import java.io.IOException;
import java.sql.*;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
@MultipartConfig(maxFileSize = 16177215)
@WebServlet("/DoLoad")
public class DoLoad extends HttpServlet {
	private static final long serialVersionUID = 1L;       
   
    public DoLoad() {
        super();        
    }
    String driver="com.mysql.cj.jdbc.Driver";
	String cs="jdbc:mysql://localhost:3306/jane?sessionVariables=sql_mode='NO_ENGINE_SUBSTITUTION'&jdbcCompliantTruncation=false";
	String uid= "root";
	String pwd= "jane";
	
	Statement stmt;
	PreparedStatement pst;
	ResultSet rs;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out =response.getWriter();		
		Part filePart = request.getPart("txtimage");
        String fileName = filePart.getSubmittedFileName();
        String category= request.getParameter("txtcat");
        InputStream inputStream = null;
        out.print(category);
        if (filePart != null) {
            inputStream=filePart.getInputStream();
        }
        Connection con= null;
        String message=null;

        try {
        	Class.forName(driver);
			con=DriverManager.getConnection(cs,uid,pwd);
			String sql= "INSERT INTO images (name, image, category) values (?, ?, ?)";
            pst= con.prepareStatement(sql);
            pst.setString(1, fileName);
            

            if (inputStream!=null) {
                pst.setBlob(2,inputStream);
            }
            pst.setString(3, category);
            
            int row= pst.executeUpdate();
            if (row>0) {
                message ="File uploaded and saved into database.";
            }
        } 
        catch (Exception e) {
            message = "ERROR: " + e.getMessage();
            e.printStackTrace();
        }
        response.setContentType("text/html");
        response.getWriter().println("<h3>" + message + "</h3>");
	}

}