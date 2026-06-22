package servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.OnedariDao;
import dto.Onedari;

@WebServlet("/OnedariServlet")
@MultipartConfig 
public class OnedariServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * 1. おねだりリスト画面を表示する（GETリクエスト）
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // セッションからログイン中のファミリーIDを取得
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");
        
        // ログインしていない場合はログイン画面に強制リダイレクト
        if (familyId == null) {
            response.sendRedirect("/c5/LoginServlet");
            return;
        }

        // DAOを使って、この家族のおねだりリストをデータベースから全件取得する
        OnedariDao odao = new OnedariDao();
        List<Onedari> onedariList = odao.findByFamilyId(familyId);

        // JSP側の ${onedariList} にデータを引き渡す
        request.setAttribute("onedariList", onedariList);

        // おねだりリストのJSP（onedari.jsp）へフォワードして表示
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/onedari.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * 2. おねだりの追加、および購入状態の変更を行う（POSTリクエスト）
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 文字化け防止
        request.setCharacterEncoding("UTF-8");
        
        // セッションからファミリーIDとパパママ区分を取得する
        HttpSession session = request.getSession();
        String familyId = (String) session.getAttribute("family_id");
        Integer coupleId = (Integer) session.getAttribute("couple_id"); // ログイン中ユーザーの区分(0か1)を取得       
        
        
        // ログインしていない場合はログイン画面に強制リダイレクト
        if (familyId == null || coupleId == null) {
            response.sendRedirect("/c5/LoginServlet");
            return;
        }
        
        // JavaScriptからの非同期通信（チェックボックス）かどうかの判定
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String onedariIdStr = request.getParameter("onedariId");
        
        // おねだり削除の処理ルート
        if ("delete".equals(action) && onedariIdStr != null) {
            int onedariId = Integer.parseInt(onedariIdStr);
            OnedariDao odao = new OnedariDao();
            
            // DAOの削除メソッドを呼び出す
            odao.deleteOnedari(onedariId);
            
            // 削除完了後、一覧画面にリダイレクトして画面を更新する
            response.sendRedirect("/c5/OnedariServlet");
            return; // 処理を完全に終了させる
        }
        
        if (action != null && idStr != null) {
            // チェックボックスの制御ルート
            int onedariId = Integer.parseInt(idStr);
            OnedariDao odao = new OnedariDao();
            boolean success = false;
            
            if ("complete".equals(action)) {
                // 購入完了（updated_at に現在時刻を入れるなど、DAOのメソッドを呼び出す）
                success = odao.completeOnedari(onedariId); 
            } else if ("cancel".equals(action)) {
                // 購入キャンセル（updated_at を NULL に戻すなど、DAOのメソッドを呼び出す）
                success = odao.cancelOnedari(onedariId); 
            }
            
            // 非同期通信（fetch）には画面を返さず、ステータスコード（200か500）だけを返す
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK（JS側の response.ok が真になる）
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 エラー
            }
            return; // ここで処理を完全に終了させる
        }

        // 各フォームからおねだりが新規追加されたときの処理
        String itemCategory = request.getParameter("item-category");
        OnedariDao odao = new OnedariDao();
        Onedari onedari = new Onedari();
        onedari.setFamilyId(familyId);
        onedari.setCoupleId(coupleId); //  DTOに誰がおねだりしたかを格納
        
        // 画像ファイルアップロード処理
        Part part = request.getPart("item-image");
        String imagePath = "no-image.png";
        
        if (part != null && part.getSize() > 0) {
            String originalName = part.getSubmittedFileName();
            String ext = originalName.substring(originalName.lastIndexOf("."));
            imagePath = UUID.randomUUID().toString() + ext;
            
            String savePath = getServletContext().getRealPath("/upload");
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            part.write(savePath + File.separator + imagePath);
        }
        onedari.setImagePath(imagePath);

        // 選択肢からマスタID（1〜14）を自動で割り出す処理
        int categoryId = 14; // デフォルトは「その他(14)」
        String productName = "";

        if ("おむつ".equals(itemCategory)) {
            productName = request.getParameter("omutsu-brand");
            String type = request.getParameter("omutsu-type");
            String size = request.getParameter("omutsu-size");
            categoryId = determineOmutsuCategoryId(type, size); // 下のメソッドでIDを計算する
            
        } else if ("ミルク".equals(itemCategory)) {
            productName = request.getParameter("milk-brand");
            String type = request.getParameter("milk-type");
            if ("缶".equals(type)) { categoryId = 11; }
            else if ("スティック".equals(type)) { categoryId = 12; }
            else if ("キューブ".equals(type)) { categoryId = 13; }
            
        } else if ("その他".equals(itemCategory)) {
            productName = request.getParameter("other-name");
            categoryId = 14;
        }
        
        onedari.setCategoryId(categoryId); //  割り出したマスタのID番号を格納
        onedari.setProductName(productName);
        
        // データベースに登録を実行
        odao.register(onedari);
        
        // リダイレクト 「追加しました！」1秒間自動表示
        response.sendRedirect("/c5/OnedariServlet?msg=success");
    }

    /**
     *  選ばれたタイプとサイズから、おむつのマスタID（1〜10）を割り出すための判定メソッド
     */
    private int determineOmutsuCategoryId(String type, String size) {
        if ("テープ".equals(type)) {
            if ("新生児".equals(size)) return 1;
            if ("S".equals(size)) return 2;
            if ("M".equals(size)) return 3;
            if ("L".equals(size)) return 4;
            if ("BIG".equals(size)) return 5;
        } else if ("パンツ".equals(type)) {
            if ("新生児".equals(size)) return 6;
            if ("S".equals(size)) return 7;
            if ("M".equals(size)) return 8;
            if ("L".equals(size)) return 9;
            if ("BIG".equals(size)) return 10;
        }
        return 14; // 万が一どれにも当てはまらなければ「その他」にする
    }
}
