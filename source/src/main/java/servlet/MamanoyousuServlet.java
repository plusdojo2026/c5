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
      //カップルIDでの表示画面の判別
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

        String error = null;

        // 未入力チェック
        if (physicalStr == null) {
            error = "体調具合を選択してください";
        } else if (mentalStr == null) {
            error = "メンタル値を選択してください";
        } else if (sleepStr == null || sleepStr.isEmpty()) {
            error = "睡眠時間を入力してください";
        } else if (stressStr == null) {
            error = "ストレス値を選択してください";
        }

        if (error != null) {
            request.setAttribute("message", error);
            request.getRequestDispatcher("/WEB-INF/jsp/mamanoyousu_mama.jsp").forward(request, response);
            return;
        }

        // 型変換
        int physical = Integer.parseInt(physicalStr);
        int mental = Integer.parseInt(mentalStr);
        double sleep = Double.parseDouble(sleepStr);
        int stress = Integer.parseInt(stressStr);

        // セッション取得
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");
        int coupleId = (Integer) session.getAttribute("couple_id");

        Mamanoyousu m = new Mamanoyousu(
              familyId, coupleId, physical, mental, sleep, stress, memo
        );

        boolean result = dao.insert(m);

        if (result) {
            request.setAttribute("message", "記録しました！");
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
