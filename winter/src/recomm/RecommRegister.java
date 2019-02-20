package recomm;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RecommAction
 */
public class RecommRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommRegister() {
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
		// create Bean object and setting them
		Recomm recomm = new Recomm();
		
		recomm.setName(request.getParameter("name"));
		recomm.setUrl(request.getParameter("url"));
		recomm.setIntro(request.getParameter("intro"));
		
		// create posterDAO object
		RecommDAO recommDAO = new RecommDAO();
		
		// do insert query
		int result = recommDAO.register(recomm.getName(), recomm.getUrl(), recomm.getIntro());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('fail')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter  script = response.getWriter();
			script.println("<script>");
			script.println("location.href = './index.jsp'");
			script.println("</script>");
		}
	}

}
