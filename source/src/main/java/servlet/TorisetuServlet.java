package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TorisetuDao;
import dto.Torisetu;

@WebServlet("/TorisetuServlet")

public class TorisetuServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

	//セッションを取得する
	HttpSession session = request.getSession();
    String familyId = (String) session.getAttribute("family_id");
    int coupleId = (int) session.getAttribute("couple_id");
    
    //ログインしていなければ、ログインページへ
    if (familyId == null) {
		response.sendRedirect("LoginServlet");
		return;
	}
    
    //トリセツのデータを取得する
    TorisetuDao tridao = new TorisetuDao();
    Torisetu t = tridao.selectByFamilyIdAndCoupleId(familyId,coupleId);
    
    request.setAttribute("torisetu", t);
    
    //トリセツページにフォワードする
 		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/torisetu.jsp");
 		dispatcher.forward(request, response);
 	}

	
    
	


}
