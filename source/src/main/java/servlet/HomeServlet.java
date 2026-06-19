package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HomeDao;
import dao.MamanoyousuDao;
import dto.Home;
import dto.Mamanoyousu;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("family_id") == null) {
			response.sendRedirect("/c5/LoginServlet");
			return;
		}
		
		// ログイン中ユーザーの区分取得
		int coupleId = (Integer) session.getAttribute("couple_id");

		// ポップアップ取得
		HomeDao dao = new HomeDao();

		Home popup = dao.getRandomPopup(coupleId);

		// JSPへ渡す
		request.setAttribute("popup", popup);
		
		
		// ママのようす取得
		MamanoyousuDao mamaDao = new MamanoyousuDao();

		Mamanoyousu mama =
		        mamaDao.findLatest((String)session.getAttribute("family_id"));

		request.setAttribute("mama", mama);

		
		 // ホーム画面へ遷移
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
        dispatcher.forward(request, response);
		}
	}
