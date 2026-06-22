package servlet;//aa

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.OmoidealbumDao;
import dto.Omoidealbum;

@MultipartConfig //ファイルのアップロードに必要
@WebServlet("/OmoidealbumServlet")

public class OmoidealbumServlet  extends HttpServlet{
private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

	//セッションを取得する!
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
 	
 	
 	String action = request.getParameter("action");
 	
 	//---------削除する--------
 	if("delete".equals(action)){
 		int albumId = Integer.parseInt(request.getParameter("album_id"));
 		
 		Omoidealbum album = new Omoidealbum();
 		album.setAlbumId(albumId);
 		album.setFamilyId(familyId);
 		album.setCoupleId(coupleId);
 		
 		OmoidealbumDao dao = new OmoidealbumDao();
 		dao.delete(album);
 		
 		//リダイレクトして、削除を確実に反映する
 		response.sendRedirect("OmoidealbumServlet");
 		return;
 	}
 	
 	//--------投稿する--------
 	if("insert".equals(action)){
 	//リクエストパラメータを取得
 	Part part = request.getPart("album_photo");
 	String fileName = part.getSubmittedFileName();
 	String comment = request.getParameter("comment");
		//恐らく不要  Timestamp createdAt = Timestamp.valueOf(request.getParameter("createdAt"));
 
 	//エラー(写真かコメントが未入力)
 	if(fileName == null || comment == null) {
 		request.setAttribute("message","写真とコメントを入力してください");
 		doGet(request,response);
 		return;
 	}
 	
 	//写真を保存する
 	String uploadDir = getServletContext().getRealPath("img/album");
 	File dir = new File(uploadDir);
 	//フォルダを作る
 	if(!dir.exists()) {
 		dir.mkdirs();
 	}
 	
 	//
 	
 	//ファイルの保存名
 	String saveName = familyId + fileName;
 	String savePath = uploadDir + File.separator + saveName;
 	
 	String photoPath = "img/album/"+saveName;
 	
 	part.write(savePath);
 	
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
 	response.sendRedirect("OmoidealbumServlet");
 	
 	}
 	}
}