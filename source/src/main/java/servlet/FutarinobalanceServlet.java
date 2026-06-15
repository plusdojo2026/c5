package servlet;

import dao.FutarinobalanceDao;
import dto.Futarinobalance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * ふたりのバランス 画面のServlet
 */
@WebServlet("/FutarinobalanceServlet")
public class FutarinobalanceServlet extends HttpServlet {

    /**
     * GETリクエスト：画面の初期表示
     * DBからタスク一覧を取得してJSPに渡す
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字コードの設定
        request.setCharacterEncoding("UTF-8");

        // セッションからfamily_idを取得
        HttpSession session = request.getSession();

     // ===== 開発用：仮セッションデータ（テスト後に削除） =====
        session.setAttribute("family_id", 1);
        session.setAttribute("couple_id", 0);
        // =====================================================

        // セッションのfamily_idをint型で取得する
        // getAttribute()でLoginServlet.javaでsessionに保存したファミリーIDを取得
        String familyIdStr = (String) session.getAttribute("family_id");
        int familyId = Integer.parseInt(familyIdStr);

        // ログインしていない場合はログイン画面に戻す
        if (familyIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // DAOを使う準備
        FutarinobalanceDao dao = new FutarinobalanceDao();

        // 初めてアクセスした場合（データがない場合）は初期データを登録する
        boolean exists = dao.existsData(familyId);
        if (exists == false) {
            dao.insertInitialData(familyId);
        }

        // DBからタスク一覧を全件取得する
        // → FutarinobalanceDao.java の getTaskList() を呼ぶ
        List<Futarinobalance> allList = dao.getTaskList(familyId);

        // 妻担当（couple_id=0）のリストを作る
        List<Futarinobalance> mamaList = new ArrayList<Futarinobalance>();

        // 夫担当（couple_id=1）のリストを作る
        List<Futarinobalance> papaList = new ArrayList<Futarinobalance>();

        // 未割当（couple_id=3）のリストを作る
        List<Futarinobalance> unassignedList = new ArrayList<Futarinobalance>();

        // allListを1件ずつ見てcouple_idで振り分ける
        for (int i = 0; i < allList.size(); i++) {
            Futarinobalance bean = allList.get(i);

            if (bean.getCoupleId() == 0) {
                // couple_id=0 → ママリストに追加
                mamaList.add(bean);

            } else if (bean.getCoupleId() == 1) {
                // couple_id=1 → パパリストに追加
                papaList.add(bean);

            } else {
                // couple_id=3（未割当）→ 未割当リストに追加
                unassignedList.add(bean);
            }
        }

        // JSPに各リストを渡す
        // → futarinobalance.jsp の mamaList・papaList・unassignedList で受け取る
        request.setAttribute("mamaList",       mamaList);
        request.setAttribute("papaList",       papaList);
        request.setAttribute("unassignedList", unassignedList);

        // JSPに遷移する
        request.getRequestDispatcher("/WEB-INF/jsp/futarinobalance.jsp")
               .forward(request, response);
    }


    /**
     * POSTリクエスト：ドラッグ&ドロップで担当変更した時
     * JSPのJavaScriptからfetch()で送られてくる
     * balanceId・coupleId・displayOrderを受け取ってDBを更新する
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字コードの設定
        request.setCharacterEncoding("UTF-8");

        // JavaScriptから送られてきたデータを受け取る
        // ※ futarinobalance.jsp の JavaScript の fetch() で送っている値
        String balanceIdStr   = request.getParameter("balance_id");
        String coupleIdStr    = request.getParameter("couple_id");
        String displayOrderStr = request.getParameter("display_order");

        // 受け取った値がnullでないか確認する
        if (balanceIdStr == null || coupleIdStr == null || displayOrderStr == null) {
            // nullの場合はエラーを返す
            response.getWriter().write("error");
            return;
        }

        // String型をint型に変換する
        int balanceId   = Integer.parseInt(balanceIdStr);
        int coupleId    = Integer.parseInt(coupleIdStr);
        int displayOrder = Integer.parseInt(displayOrderStr);

        // DAOを使ってDBを更新する
        // → FutarinobalanceDao.java の updateCoupleId() を呼ぶ
        FutarinobalanceDao dao = new FutarinobalanceDao();
        boolean result = dao.updateCoupleId(balanceId, coupleId, displayOrder);

        // 結果をJavaScriptに返す
        if (result == true) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
    }
}
