package servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SukusukukirokuDao;
import dto.Sukusukukiroku;

@WebServlet("/SukusukukirokuServlet")
public class SukusukukirokuServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	/**
	 * GETリクエスト：画面表示
	 *  タイムライン一覧を取得してJSPに渡す
	 */
	
	//画面表示(GET)
		protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

			// 文字コードの設定
	        request.setCharacterEncoding("UTF-8");
	        
	        // セッションからfamily_idを取得
	        HttpSession session = request.getSession();
	        String familyId = (String) session.getAttribute("family_id");
	        
	        // ログインしていない場合はログイン画面に戻す
	        if (familyId == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }
	        

	            // Daoからタイムラインデータを取得
	            SukusukukirokuDao dao = new SukusukukirokuDao();
	           
	            //一覧取得
	            List<Sukusukukiroku> list = dao.findByFamilyId(familyId);

	           //JSPにデータを渡す 
	            request.setAttribute("recordList", list);

               // 日付（表示用）
	            request.setAttribute("now", LocalDateTime.now().toString());
	            
	           //JSPに遷移
	            request.getRequestDispatcher("WEB-INF/jsp/sukusukukiroku.jsp")
	               .forward(request, response);
			}	
		
				//登録処理
				protected void doPost(HttpServletRequest request, HttpServletResponse response)
						throws ServletException, IOException{
					
					request.setCharacterEncoding("UTF-8");
					
String action = request.getParameter("action");
					
					//---------削除する--------
					if ("delete".equals(action)) {
						int sukusukuId = Integer.parseInt(request.getParameter("sukusukuId"));
						
						SukusukukirokuDao dao = new SukusukukirokuDao();
						dao.deleteSukusuku(sukusukuId);
						
						response.sendRedirect("SukusukukirokuServlet");
						return;
					}
					
					String t = request.getParameter("temperature");
					String w = request.getParameter("weight");
					String note = request.getParameter("note");//任意
					String message = "";
					
					//登録の例外処理
					try {
						double temp = Double.parseDouble(t);
						double weight = Double.parseDouble(w);
						
						if (temp < 35|| temp >42) {
							message = "体温は35~42の範囲で入力してください";
						} else if(weight <0|| weight >99) {
							message ="体重は0~99㎏の間で入力してください";
						} else {
							HttpSession session= request.getSession();
							String familyId= (String) session.getAttribute("family_id");
							Sukusukukiroku record= new Sukusukukiroku();

							record.setfamily_Id(familyId);
							record.setTemperature(temp);
							record.setWeight(weight);
							record.setNote(note);

							SukusukukirokuDao dao = new SukusukukirokuDao();
							boolean success=dao.insert(record);
							if (success) {
								message = "登録完了しました！";
								
								response.sendRedirect("/c5/TorisetuServlet?msg=success");
							    return;
							    
							}else {
								message="登録に失敗しました";
							}
							
						}
					}catch(Exception e) {
						message = "入力エラー";
					}
					request.setAttribute("message", message);
					doGet(request,response);//再表示
				}
}