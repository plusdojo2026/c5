package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MamanoyousuDao;
import dto.Mamanoyousu;

@WebServlet("/MamanoyousuServlet")
public class MamanoyousuServlet extends HttpServlet {

    private MamanoyousuDao dao = new MamanoyousuDao();

    // 画面表示
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	//セッションからfamily_id、couple_idを取得
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");
        int coupleId = (Integer) session.getAttribute("couple_id");

        Mamanoyousu mama = dao.findLatest(familyId);

        request.setAttribute("mama", mama);

        if (mama != null) {
            request.setAttribute("advice", createAdvice(mama));
        }
      //カップルIDでの表示画面の判別11
        if (coupleId == 0) {
            request.getRequestDispatcher("/WEB-INF/jsp/mamanoyousu_mama.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/jsp/mamanoyousu_papa.jsp").forward(request, response);
        }
    }

    // 登録処理
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // パラメータ取得（文字列）
        String physicalStr = request.getParameter("physical_score");
        String mentalStr = request.getParameter("mental_score");
        String sleepStr = request.getParameter("sleep_hours");
        String stressStr = request.getParameter("stress");
        String memo = request.getParameter("memo");
        

        //値を保持
        request.setAttribute("physical_score", physicalStr);
        request.setAttribute("mental_score", mentalStr);
        request.setAttribute("sleep_hours", sleepStr);
        request.setAttribute("stress", stressStr);
        request.setAttribute("memo", memo);


        String error = null;

        // 未入力チェック
        if (physicalStr == null ||physicalStr.isEmpty()) {
            error = "体調具合を選択してください";
        } else if (mentalStr == null || mentalStr.isEmpty()) {
            error = "メンタル値を選択してください";
        } else if (sleepStr == null || sleepStr.isEmpty()) {
            error = "睡眠時間を入力してください";
        } else if (stressStr == null || stressStr.isEmpty()) {
            error = "ストレス値を選択してください";
        }
        
        //例外処理
        int physical = 0;
        int mental = 0;
        double sleep = 0;
        int stress = 0;
        

        if (error == null) {
            try {
                physical = Integer.parseInt(physicalStr);
                mental = Integer.parseInt(mentalStr);
                sleep = Double.parseDouble(sleepStr);
                stress = Integer.parseInt(stressStr);
            } catch (NumberFormatException e) {
                error = "数値の入力形式が正しくありません";
            }
        }

        
        //エラー時
        if (error != null) {
            request.setAttribute("message", error);
            request.getRequestDispatcher("/WEB-INF/jsp/mamanoyousu_mama.jsp").forward(request, response);
            return;
        }

        
        // セッション取得
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");
        int coupleId = (Integer) session.getAttribute("couple_id");
        



        //DTO作成
        Mamanoyousu m = new Mamanoyousu(
              familyId, coupleId, physical, mental, sleep, stress, memo
        );
        
        //記録の有無の判定
        boolean result = dao.insert(m);

        if (result) {
        	response.sendRedirect("/c5/MamanoyousuServlet?msg=success");
            return;
        } else {
            request.setAttribute("message", "登録に失敗しました");
        }

        doGet(request, response);
        }


    // アドバイス
    private String createAdvice(Mamanoyousu m) {

    	int stress=m.getStress();

        if (stress <= 2) {
            return "🌷 ママは比較的落ち着いて過ごせているようです。"
            		+ "今の良い状態を続けられるように、日頃の感謝や気遣いをこれからも大切にしていきましょう。小さな「ありがとう」が、ママの笑顔につながりますよ。";
        } else if (stress == 3) {
            return "🌼 ママは少し疲れがたまっているかもしれません。無理をしていないか気にかけながら"
            		+ "、「何か手伝えることある？」と一声かけてみましょう。ちょっとした気遣いが、ママの安心につながります。";
        } else {
            return "🌹 ママのストレス指数が高めです。　リラックスできる時間を一緒に作ってみましょう！　「ありがとう」と声をかけるだけでも、ママの心が軽くなりますよ。";
        }
    }
}
