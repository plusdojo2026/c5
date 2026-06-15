package dao;

import dto.Mamanoyousu;

public class MamanoyousuDao {
	//データベース接続
	private static final String URL= "jdbc:mysql://localhost:3306/";//接続するデータベース名
	private static final String USER     = "root";//MySQLにログインするユーザー名
											      //⚠root は 管理者ユーザー
    private static final String PASSWORD = "";//上記ユーザーのパスワード
    
    //データ登録
    public boolean insert(Mamanoyousu m) {
    	String sql="INSERT INTO mamanoyousu "
    	                + "(family_id, couple_id, physical_score, mental_score, sleep_hours, stress, memo, recorded_date) "
    	                + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";

    }
}
