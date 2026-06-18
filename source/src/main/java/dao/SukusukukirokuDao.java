package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import dto.Sukusukukiroku;

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
				String sql ="""
						SELECT*
						FROM sukusukukiroku
						WERER family_id = ?
						ORDER BY recorded_at DESC
						""";

				PreparedStatement pStmt = conn.prepareStatement(sql);
	            pStmt.setString(1, familyId);

	            // SQL文を実行し結果を取得
	            ResultSet rs = pStmt.executeQuery();
	            
	            //DTOに詰める
	            while(rs.next()) {
	            	Sukusukukiroku record =new Sukusukukiroku();
	            	
	            	record.setSukusukuId(rs.getInt("sukusuku_id"));
	            	record.setFamilyId(rs.getString("family_id"));
	            	record.setWeight(rs.getDouble("weight"));
	            	record.setTemperature(rs.getDouble("temperature"));
	            	record.setNote(rs.getString("note"));
	            	record.setRecordedAt(rs.getString("recorded_at"));
	            	
	            	list.sdd(record);
	            }
	            
			}catch (Exception e) {
				e.printStackTrace();
			}finally{
				//DB切断
				try {
					if (conn!= null)conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;
	}
	//最新データ取得
	
}
