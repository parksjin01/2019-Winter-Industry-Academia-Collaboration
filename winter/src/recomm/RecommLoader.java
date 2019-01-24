package recomm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class RecommController
 */
@WebServlet("/recommLoader")
public class RecommLoader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommLoader() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		String param = (String) request.getParameter("recommID");
		
		int recommID = Integer.parseInt(param);
		
		RecommDAO recommDAO = new RecommDAO();
		Recomm recomm = recommDAO.getRecomm(recommID);
		JSONObject obj = new JSONObject();
		
		obj.put("recommID", recomm.getRecommID());
		obj.put("name", recomm.getName());
		obj.put("url", recomm.getUrl());
		obj.put("intro", recomm.getIntro());
		
		System.out.println("³»¿ë : "+recomm.getIntro());

		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
