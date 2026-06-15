package dao;

import dto.Futarinobalance;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * ふたりのバランス テーブルのDB操作クラス
 */
public class FutarinobalanceDao {

    // DB接続情報
    // ※ futarigoto_db は futarigoto_db.sql で作成したデータベース名
    private static final String URL      = "jdbc:mysql://localhost:3306/futarigoto_db?characterEncoding=UTF-8";
    private static final String USER     = "root";//rootはMYSQLのユーザー名
    private static final String PASSWORD = "";

    /**
     * 指定したfamilyIdのタスク一覧を全件取得する
     * coupleIdで絞り込まず全部取得する（妻・夫・未割当すべて）
     *
     * @param familyId セッションから取得したfamily_id
     * @return タスクのリスト（Futarinobalanceクラスのリスト）
     */
    //sessionはservletの37.38行目のsession.setAttributeで作成してる。
    
    public List<Futarinobalance> getTaskList(int familyId) {
    //survlet43.44.60行目

        // 結果を入れるリストを用意する
        List<Futarinobalance> list = new ArrayList<Futarinobalance>();

        // DB接続に使う変数
        Connection conn      = null;
        PreparedStatement ps = null;
        ResultSet rs         = null;

        try {
            // MySQLのドライバを読み込む(そういう書き方）
            Class.forName("com.mysql.cj.jdbc.Driver");

            // DBに接続する
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // SQL文
            // futarinobalanceテーブルとtodoテーブルをJOINして
            // タスク名も一緒に取得する
            // 担当者（couple_id）ごとに並べ、display_order の順番で並べる
            //b=futarinobalanceテーブルの省略
            //joinはb.todo_id　と　t.task_idを紐づけている。
            
            String sql = "SELECT b.balance_id, b.family_id, b.couple_id, b.todo_id, "
                       + "b.display_order, t.task_name "
                       + "FROM futarinobalance b "
                       + "JOIN todo t ON b.todo_id = t.task_id "
                       + "WHERE b.family_id = ? "
                       + "ORDER BY b.couple_id, b.display_order";

            // SQLの ? に family_id をセット（SQL文を実行する準備をする）
            ps = conn.prepareStatement(sql);
            ps.setInt(1, familyId);

            // SQL実行
            rs = ps.executeQuery();//excuteQuery=select

            // 結果を1件ずつdtoに詰めてリストに追加
            while (rs.next()) {
                Futarinobalance bean = new Futarinobalance();

                // rs.getInt("カラム名") でDBの値を取り出す
                bean.setBalanceId(rs.getInt("balance_id"));
                bean.setFamilyId(rs.getInt("family_id"));
                bean.setCoupleId(rs.getInt("couple_id"));
                bean.setTodoId(rs.getInt("todo_id"));
                bean.setDisplayOrder(rs.getInt("display_order"));
                bean.setTaskName(rs.getString("task_name"));

                list.add(bean);
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            // 必ず接続を閉じる
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
     * タスクの担当者（coupleId）と表示順（displayOrder）を更新する
     * ドラッグ&ドロップで担当が変わった時に呼ばれる
     *
     * @param balanceId    更新するレコードのbalance_id
     * @param coupleId     新しい担当（0=妻, 1=夫, 3=未割当）
     * @param displayOrder 新しい表示順
     * @return 成功:true / 失敗:false
     */
    public boolean updateCoupleId(int balanceId, int coupleId, int displayOrder) {

        Connection conn      = null;
        PreparedStatement ps = null;
        boolean result       = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // couple_id と display_order を更新するSQL
            String sql = "UPDATE futarinobalance "
                       + "SET couple_id = ?, display_order = ? "
                       + "WHERE balance_id = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, coupleId);
            ps.setInt(2, displayOrder);
            ps.setInt(3, balanceId);

            // 1件以上更新できたら成功
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
     * 初期データを登録する
     * familyIdのバランスデータがまだない場合に、todoテーブルの全タスクを未割当で登録する
     *
     * @param familyId セッションから取得したfamily_id
     */
    public void insertInitialData(int familyId) {

        Connection conn      = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // todoテーブルの全タスクを未割当(couple_id=２)で登録するSQL
            String sql = "INSERT INTO futarinobalance (family_id, couple_id, todo_id, display_order) "
                       + "SELECT ?, 2, task_id, task_id FROM todo";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, familyId);
            ps.executeUpdate();

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
    }


    /**
     * 指定したfamilyIdのデータが存在するか確認する
     * 初期データ登録の判断に使う
     *
     * @param familyId 確認したいfamily_id
     * @return データあり:true / データなし:false
     */
    public boolean existsData(int familyId) {

        Connection conn      = null;
        PreparedStatement ps = null;
        ResultSet rs         = null;
        boolean result       = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "SELECT COUNT(*) FROM futarinobalance WHERE family_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, familyId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // COUNT(*)が1以上ならデータあり
                if (rs.getInt(1) > 0) {
                    result = true;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            try {
                if (rs   != null) rs.close();
                if (ps   != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }
}
