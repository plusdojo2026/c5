package servlet;

import dao.KonnnakotositetayoDao;
import dto.Konnnakotositetayo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * こんなことしてたよ 画面のServlet
 */
@WebServlet("/KonnnakotositetayoServlet")
public class KonnnakotositetayoServlet extends HttpServlet {

    /**
     * GETリクエスト：画面表示
     * タイムライン一覧を取得してJSPに渡す
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字コードの設定
        request.setCharacterEncoding("UTF-8");
     // ===== 削除リクエストの判定 =====
        // actionパラメータが "delete" なら削除処理を行う
        String action = request.getParameter("action");
        if ("delete".equals(action)) {

            // セッションからfamily_idを取得
            HttpSession delSession = request.getSession();
            String delFamilyId = (String) delSession.getAttribute("family_id");

            // ログインしていない場合はログイン画面へ
            if (delFamilyId == null) {
                response.sendRedirect("LoginServlet");
                return;
            }

            // DAOで自分の記録を全削除
            KonnnakotositetayoDao delDao = new KonnnakotositetayoDao();
            delDao.deleteAll(delFamilyId);

            // 削除後は画面を再読み込み（リダイレクト）
            response.sendRedirect("KonnnakotositetayoServlet");
            return;
        }
        // ===== ここまで削除リクエスト =====

        // セッションからfamily_idを取得
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");

        // ログインしていない場合はログイン画面に戻す
        if (familyId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // DAOを使ってタイムラインデータを取得
        //dao.getTimelineList(familyId); 
        //①どのインスタンスの(dao)②どのメソッドを(getTimelineList)③何を渡して呼ぶか。(familyId)
        //引数＝メソッドに渡す値。familyIdが引数。
        KonnnakotositetayoDao dao = new KonnnakotositetayoDao();
        List<Konnnakotositetayo> timelineList = dao.getTimelineList(familyId);

        // JSPにデータを渡す
        //データに名前をつけて預けるメソッド。ServletからJSPにデータを渡すときに使う。
        request.setAttribute("timelineList", timelineList);

        // JSPに遷移
        request.getRequestDispatcher("WEB-INF/jsp/konnnakotositetayo.jsp")
               .forward(request, response);
    }


    /**
     * POSTリクエスト：記録の追加
     * モーダルのフォームから送られたデータをDBに保存する
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字コードの設定
        request.setCharacterEncoding("UTF-8");

        // セッションからデータを取得
        //文字列なら文字列で処理、整数なら整数に変換して処理
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");
        Object coupleIdObj = session.getAttribute("couple_id");
        int coupleId;
        if (coupleIdObj instanceof Integer) {
            coupleId = (Integer) coupleIdObj;
        } else {
            coupleId = Integer.parseInt((String) coupleIdObj);
        }

        // ログインしていない場合はログイン画面に戻す
        if (familyId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // フォーム（JSPにあるユーザーの入力欄）からnameを指定してデータを受け取る
        String taskId   = request.getParameter("task_id");
        String countStr = request.getParameter("count");
        String memo     = request.getParameter("memo");

        // ===== バリデーション =====
        // タスクが選択されていない場合
        if (taskId == null || taskId.equals("")) {
            request.setAttribute("message", "項目を選択してください。");
            doGet(request, response);
            return;
        }

        // 回数が入力されていない場合
        if (countStr == null || countStr.equals("")) {
            request.setAttribute("message", "回数を入力してください。");
            doGet(request, response);
            return;
        }

        // 回数を数値に変換
        int count = Integer.parseInt(countStr);

        // memoがnullの場合は空文字にする
        if (memo == null) {
            memo = "";
        }

        // Beanにデータをセット
        Konnnakotositetayo bean = new Konnnakotositetayo ();
        bean.setFamilyId(familyId);
        bean.setCoupleId(coupleId);
        bean.setTaskId(taskId);
        bean.setCount(count);
        bean.setMemo(memo);

        // DAOを使ってDBに保存
        KonnnakotositetayoDao dao = new KonnnakotositetayoDao();
        boolean result = dao.insert(bean);

        // 保存失敗の場合
        if (result == false) {
            request.setAttribute("message", "記録に失敗しました。もう一度お試しください。");
            doGet(request, response);
            return;
        }

        // 保存成功 → 画面をリダイレクト（再読み込みで重複送信を防ぐ）
        response.sendRedirect("KonnnakotositetayoServlet");
    }
}
