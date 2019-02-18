package recomm;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RecommUpdate
 */
public class RecommUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommUpdate() {
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
		// 데이터들을 담을 그릇인 DTO(혹은 Bean) 객체를 생성 후, 데이터들을 set해준다
		Recomm recomm = new Recomm();
				
		recomm.setRecommID(Integer.parseInt(request.getParameter("recommID")));
		recomm.setName(request.getParameter("recommName"));
		recomm.setUrl(request.getParameter("recommUrl"));
		recomm.setIntro(request.getParameter("recommIntro"));
		
		// posterDAO 객체 생성
		RecommDAO recommDAO = new RecommDAO();
			
		// insert 쿼리 수행
		int result = recommDAO.update(recomm.getRecommID(), recomm.getName(), recomm.getUrl(), recomm.getIntro());
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
