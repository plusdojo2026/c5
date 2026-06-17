package dao;

import dto.Konnnakotositetayo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * こんなことしてたよ テーブルのDB操作クラス
 */
public class KonnnakotositetayoDao {

    // DB接続情報
    private static final String URL      = "jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8";
    private static final String USER     = "root";
    private static final String PASSWORD = "password";

    /**
     * タイムライン一覧を取得する
     * 同じfamily_idのデータを新しい順に取得する
     *
     * @param familyId ログイン中のfamily_id
     * @return タイムラインのリスト
     */
    public List<Konnnakotositetayo> getTimelineList(String familyId) {

        // 結果を格納するリスト
        List<Konnnakotositetayo> list = new ArrayList<Konnnakotositetayo>();

        // DB接続に使う変数
        Connection conn        = null;
        PreparedStatement ps   = null;
        ResultSet rs           = null;

        try {
            // ドライバを読み込む
            Class.forName("com.mysql.cj.jdbc.Driver");

            // DB接続
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // SQL文（同じfamily_idのデータを新しい順に取得）
            String sql = "SELECT * FROM konnnakotositetayo WHERE family_id = ? ORDER BY created_at DESC";

            // SQLをセット
            ps = conn.prepareStatement(sql);
            ps.setString(1, familyId);

            // SQL実行
            rs = ps.executeQuery();

            // 結果をBeanに詰めてリストに追加
            while (rs.next()) {
                Konnnakotositetayo bean = new Konnnakotositetayo();

                bean.setKonnnakotositetayoId(rs.getInt("konnnakotositetayo_id"));
                bean.setFamilyId(rs.getString("family_id"));
                bean.setCoupleId(rs.getInt("couple_id"));
                bean.setTaskId(rs.getString("task_id"));
                bean.setCount(rs.getInt("count"));
                bean.setMemo(rs.getString("memo"));
                bean.setDisplayOrder(rs.getInt("display_order"));
                bean.setCreatedAt(rs.getString("created_at"));
                bean.setRecordedDate(rs.getString("recorded_date"));
                bean.setIsRead(rs.getInt("is_read"));

                list.add(bean);
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            // 接続を閉じる
            try {
                if (rs   != null) rs.close();
                if (ps   != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }


    /**
     * 記録を1件追加する
     *
     * @param bean 追加するデータ
     * @return 成功:true / 失敗:false
     */
    public boolean insert(Konnnakotositetayo bean) {

        Connection conn      = null;
        PreparedStatement ps = null;
        boolean result       = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // SQL文
            String sql = "INSERT INTO konnnakotositetayo "
                       + "(family_id, couple_id, task_id, count, memo, recorded_date, is_read, created_at) "
                       + "VALUES (?, ?, ?, ?, ?, CURDATE(), 0, NOW())";

            ps = conn.prepareStatement(sql);
            ps.setString(1, bean.getFamilyId());
            ps.setInt(2,    bean.getCoupleId());
            ps.setInt(3, Integer.parseInt(bean.getTaskId()));
            ps.setInt(4,    bean.getCount());
            ps.setString(5, bean.getMemo());

            // SQL実行（1件以上更新できたら成功）
            int count = ps.executeUpdate();
            if (count > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            try {
                if (ps   != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }


    /**
     * 既読にする（相手の記録を確認した時）
     *
     * @param konnnakotositetayoId 既読にするレコードのID
     * @return 成功:true / 失敗:false
     */
    public boolean updateIsRead(int konnnakotositetayoId) {

        Connection conn      = null;
        PreparedStatement ps = null;
        boolean result       = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // SQL文
            String sql = "UPDATE konnnakotositetayo SET is_read = 1 WHERE konnnakotositetayo_id = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, konnnakotositetayoId);

            int count = ps.executeUpdate();
            if (count > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            try {
                if (ps   != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }
}

