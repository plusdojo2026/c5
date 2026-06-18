package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OmoidealbumDao;
import dto.Omoidealbum;

@WebServlet("/OmoidealbumServlet")

public class OmoideAlbumServlet  extends HttpServlet{
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
    //おもいでアルバムのデータを取得する
    OmoidealbumDao albumdao = new OmoidealbumDao();
    List<Omoidealbum> list = albumdao.FindByFamilyIdAndCoupleId(familyId,coupleId);
    
    request.setAttribute("albumList", list);
    
    //思い出アルバムページにフォワードする
 		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/omoidealbum.jsp");
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
 	String photoPath = request.getParameter("photoPath");
 	String comment = request.getParameter("comment");
		//恐らく不要　　Timestamp createdAt = Timestamp.valueOf(request.getParameter("createdAt"));
 
 	//エラー(写真もコメントも未入力)
 	String error =null;
 	if(photoPath == null && comment == null) {
 		error = "写真かコメントを入力してください";
 	}
 	
 	if(error != null) {
 		request.setAttribute("message", error);
 	}
 	
 	//登録処理Dto
 	Omoidealbum album = new Omoidealbum();
 	album.setFamilyId(familyId);
 	album.setCoupleId(coupleId);
 	album.setPhotoPath(photoPath);
 	album.setComment(comment);
 	
 	//登録処理Dao
 	OmoidealbumDao albumDao = new OmoidealbumDao();
 	albumDao.insert(album);
 	
 	//リダイレクト
 	response.sendRedirect("OmoideAlbumServlet");
 	
}
}
