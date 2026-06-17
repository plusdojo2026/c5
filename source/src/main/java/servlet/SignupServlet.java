package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UsersDao;
import dto.Users;
import util.SecurityUtil;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * 1. 新規登録画面を表示する（GETリクエスト）
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 新規登録ページへフォワード
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * 2. 新規登録ボタンが押されたときの処理（POSTリクエスト）
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // リクエストパラメータを取得する
        request.setCharacterEncoding("UTF-8");
        String familyId = request.getParameter("family_id");
        String coupleIdStr = request.getParameter("couple_id");
        String password = request.getParameter("password");

        // 3. 入力値の簡易バリデーション（未入力チェック）
        if (familyId == null || familyId.isEmpty() || 
            coupleIdStr == null || coupleIdStr.isEmpty() || 
            password == null || password.isEmpty()) {
            
            request.setAttribute("errorMsg", "すべての項目を入力してください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // 区分（ママ:0 / パパ:1）を数字に変換
        int coupleId = Integer.parseInt(coupleIdStr);
        
        // パスワードを暗号化（LoginServletと共通のロジック）
        String hashedPassword = SecurityUtil.hashPassword(password);

        // Users DTO の箱にデータをまとめる
        Users user = new Users(familyId, coupleId, hashedPassword);
        
        // 4. データベースへの登録実行
        UsersDao udao = new UsersDao();
        
        if (udao.register(user)) { // 登録成功
            // ログイン画面へリダイレクト
            response.sendRedirect("/c5/LoginServlet?msg=success"); 
            return; // 処理を修了

            
        } else { // 登録失敗（すでに同じIDが存在する場合など）
            request.setAttribute("errorMsg", "登録に失敗しました。同じファミリーコードが既に使われている可能性があります。");
            
            // 元の「signup.jsp」にフォワードする
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp");
            dispatcher.forward(request, response);
        }
    }
}

