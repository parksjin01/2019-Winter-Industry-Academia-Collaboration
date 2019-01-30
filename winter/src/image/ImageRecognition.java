package image;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class ImageRecognition
 */
@WebServlet("/imageRecognition")
public class ImageRecognition extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageRecognition() {
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

		request.setCharacterEncoding("UTF-8");
		
		String path = (String)request.getParameter("path");
		ServletContext context = getServletContext();
		String imagePath = context.getRealPath(path);	// �̹��� ���� ������
		
		/*
		 * TODO:jython�� ���� python ���ϰ� ����
		 * 
		 */

		String line = null;
		String result = null;
		try{
			String pythonScriptPath = "";
			String[] splitedPath = imagePath.split("/");
			for (String tmp : splitedPath) {
				if (tmp.equalsIgnoreCase(".metadata"))
					break;
				pythonScriptPath += tmp + "/";
			}
			
			System.out.println(pythonScriptPath);

			String[] command = {"python", 
					pythonScriptPath + "Image_Recognition/image_recognition_load.py", 
					imagePath, 
					"kangaroo dolphin butterfly elephant flamingo", 
					"image/kangaroo-dolphin-butterfly-elephant-flamingo.hdf5"};
			String[] env = {"PATH=/opt/local/bin:/opt/local/sbin:/Users/Knight/Library/Android/sdk/tools:/Users/Knight/Library/Android/sdk/platform-tools:/usr/sbin:/usr/bin:/sbin:/bin:/Users/Knight/test:/Users/Knight/ns3.28:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/CrossPack-AVR/bin:/Applications/Wireshark.app/Contents/MacOS",
					"PYTHONPATH=/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/CrossPack-AVR/bin:/Applications/Wireshark.app/Contents/MacOS"};
		    Process p = Runtime.getRuntime().exec(command, env);
		    BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
		    BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		   
		    while((line = br.readLine()) != null){
		    	if (line.contains("Prediction"))
		    		result = line;
		        System.out.println(line);
		    }
		    
		    while((line = stdError.readLine()) != null){
		        System.out.println(line);
		    }
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		// ������ ���� (json ���·�)
		JSONObject obj = new JSONObject();
		obj.put("path", result);
		
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

}
