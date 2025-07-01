import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
@MultipartConfig
@WebServlet("/ImageServlet")

public class ImageServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("ImageServlet accessed");
    	int imageId = Integer.parseInt(request.getParameter("id")); 
    	//int imageId=1;
        System.out.println(imageId+ " ok");
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jane", "root", "jane");
	
             PreparedStatement statement = con.prepareStatement("SELECT image FROM images WHERE id = ?");

            statement.setInt(1, imageId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
            	System.out.println(" entering");
                Blob blob = resultSet.getBlob("image");
                byte[] imageBytes = blob.getBytes(1, (int) blob.length());

                response.setContentType("image"); // Set appropriate content type
                OutputStream outputStream = response.getOutputStream();
                outputStream.write(imageBytes);
                outputStream.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}