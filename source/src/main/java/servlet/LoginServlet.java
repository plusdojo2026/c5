package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UsersDao;
import dto.Users;
import util.SecurityUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * 1. ログイン画面を表示する（GETリクエスト）
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	// ログインページにフォワードする
    			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
    			dispatcher.forward(request, response);
    }
    
    /**
     * 2. ログインボタンが押されたときの処理（POSTリクエスト）
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // リクエストパラメータを取得する
        request.setCharacterEncoding("UTF-8");
        String familyId = request.getParameter("family_id");
        String coupleIdStr = request.getParameter("couple_id");
        String password = request.getParameter("password");
        
        // 区分（ママ:0 / パパ:1）を数字に変換
        int coupleId = Integer.parseInt(coupleIdStr);
        
        // パスワードを暗号化
        String hashedPassword = SecurityUtil.hashPassword(password);

        //Users DTO の箱を作って、そこに3つのデータを綺麗にまとめる！
        Users user = new Users(familyId, coupleId, hashedPassword);
        
        // 3. データベース照合
        UsersDao udao = new UsersDao();
        
        if (udao.isLoginOK(user)) { // ログイン成功
            // セッションスコープにファミリーIDと区分を格納する
            HttpSession session = request.getSession();
            session.setAttribute("family_id", familyId);
            session.setAttribute("couple_id", coupleId);
            
            // ホームサーブレットにリダイレクトする
            response.sendRedirect("/c5/HomeServlet");
            
        } else { // ログイン失敗（画面を移動せずその場でエラーを出す）
            // ログイン画面にある「errorMsg」という変数に、エラーメッセージを直接格納する
            request.setAttribute("errorMsg", "ファミリーコード、ママ/パパ選択、またはパスワードに間違いがあります。");
            
            // 元の「login.jsp」にそのままフォワードする
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
            dispatcher.forward(request, response);
        }
    }
} 

