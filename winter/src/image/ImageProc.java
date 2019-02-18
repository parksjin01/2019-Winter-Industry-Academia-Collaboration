package image;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ImageProc
 */
public class ImageProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageProc() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		MultipartRequest multi = null;
		File file = null;
		
		int fileMaxSize = 10*1024*1024;	// max file size : 10MB
		boolean sizeError = false;
		
		String formName = "";
		String fileName = "";
		
		// saving path of files
		// getRealPath() : 
		String savePath = request.getRealPath("/upload").replaceAll("\\\\", "/");
		
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
			
		} catch (Exception e) {
			if (e.getMessage().indexOf("exceeds limit") > -1) {
				sizeError = true;
			}
			e.printStackTrace();
		}
		if (sizeError) {
			response.setContentType("text/html; charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("<script>alert(''); location.href=''; </script>");
			return;
		}
		
		Enumeration forms  = multi.getFileNames();
		
		while (forms.hasMoreElements()) {
			
			formName = (String)forms.nextElement();
			
			fileName = multi.getFilesystemName(formName);
			
			if (fileName != null) {
				file = multi.getFile(formName);
				
			}
			
		}
		
		JSONObject obj = new JSONObject();
		
		obj.put("name", multi.getOriginalFileName("file"));
		obj.put("path", "./upload/"+file.getName());
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
		
	}

}
