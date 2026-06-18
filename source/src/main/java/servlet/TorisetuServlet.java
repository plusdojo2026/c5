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
	
//--------Get--------
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

	// 文字コードを設定する
    request.setCharacterEncoding("UTF-8");
		
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

//--------Post--------
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    
	// 文字コードを設定する
	request.setCharacterEncoding("UTF-8");
	
	//セッションを取得する
	HttpSession session = request.getSession();
	String familyId = (String) session.getAttribute("family_id");
	int coupleId = (int) session.getAttribute("couple_id");
	    
	//ログインしていなければ、ログインページへ
	if (familyId == null) {
		response.sendRedirect("LoginServlet");
			return;
		}
	
	//リクエストパラメータを取得
	String happy1 = request.getParameter("happy1");
	String happy2 = request.getParameter("happy2");
	String happy3 = request.getParameter("happy3");
	String angry1 = request.getParameter("angry1");
	String angry2 = request.getParameter("angry2");
	String angry3 = request.getParameter("angry3");
	String fun1 = request.getParameter("fun1");
	String fun2 = request.getParameter("fun2");
	String fun3 = request.getParameter("fun3");
	String sad1 = request.getParameter("sad1");
	String sad2 = request.getParameter("sad2");
	String sad3 = request.getParameter("sad3");
	String charge1 = request.getParameter("charge1");
	String charge2 = request.getParameter("charge2");
	String charge3 = request.getParameter("charge3");
	String bad1 = request.getParameter("bad1");
	String bad2 = request.getParameter("bad2");
	String bad3 = request.getParameter("bad3");
	String badaction1 = request.getParameter("badaction1");
	String badaction2 = request.getParameter("badaction2");
	String badaction3 = request.getParameter("badaction3");
	
	//登録処理DTO
	Torisetu pro = new Torisetu();
	pro.setFamilyId(familyId);
	pro.setCoupleId(coupleId);
	pro.setHappy1(happy1);
	pro.setHappy2(happy2);
	pro.setHappy3(happy3);
	pro.setAngry1(angry1);
	pro.setAngry2(angry2);
	pro.setAngry3(angry3);
	pro.setFun1(fun1);
	pro.setFun2(fun2);
	pro.setFun3(fun3);
	pro.setSad1(sad1);
	pro.setSad2(sad2);
	pro.setSad3(sad3);
	pro.setCharge1(charge1);
	pro.setCharge2(charge2);
	pro.setCharge3(charge3);
	pro.setBad1(bad1);
	pro.setBad2(bad2);
	pro.setBad3(bad3);
	pro.setBadaction1(badaction1);
	pro.setBadaction2(badaction2);
	pro.setBadaction3(badaction3);
	
	//登録処理DAO
	TorisetuDao proDao = new TorisetuDao();
	proDao.insert(pro);
	
	
	//リダイレクト
	response.sendRedirect("TorisetuServlet");
}
}
