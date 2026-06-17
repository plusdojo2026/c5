package dao;

import java.sql.DriverManager;

public class SukusukukirokuDao {
	//すくすく記録を取得するメソッド
	public List<Sukusukukiroku> findByFamilyId(String familyId){
		Connection conn = null;
		List <sukusukukiroku> list = new AllayList<>();
		
			try {
				//JDBCドライバ
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				//DB接続
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/",//接続するデータベース名
			            "root",//MySQLにログインするユーザー名 //⚠root は 管理者ユーザー
			            ""
						);	
				//SQL文
			}
	}
	
}
