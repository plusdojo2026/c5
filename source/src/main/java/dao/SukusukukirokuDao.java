package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Sukusukukiroku;

public class SukusukukirokuDao {
	//すくすく記録を取得するメソッド
	public List<Sukusukukiroku> findByFamilyId(String familyId){
		Connection conn = null;
		List <Sukusukukiroku> list = new ArrayList<>();
		
			try {
				//JDBCドライバ
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				//DB接続
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Tokyo&connectTimeout=30000", "c5", "xMN3sWVGp4WNhyCz");
				//SQL文
				String sql ="""
						SELECT*
						FROM sukusukukiroku
						WHERE family_id = ?
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
	            	record.setfamily_Id(rs.getString("family_id"));
	            	record.setWeight(rs.getDouble("weight"));
	            	record.setTemperature(rs.getDouble("temperature"));
	            	record.setNote(rs.getString("note"));
	            	record.setRecordedAt(rs.getString("recorded_at"));
	            	
	            	list.add(record);
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
	public boolean insert(Sukusukukiroku record) {
		Connection conn= null;
		boolean result= false;
		
		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DBに接続する
			conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8",
					"root",
					"password");
		
		//SQL文
		String sql ="""
				INSERT INTO sukusukukiroku(family_id,weight,temperature,note,recorded_at)
				 VALUES(?,?,?,?,NOW())
				""";
		PreparedStatement pStmt	= conn.prepareStatement(sql);
		pStmt.setString(1, record.getfamily_Id());
		pStmt.setDouble(2, record.getWeight());
		pStmt.setDouble(3, record.getTemperature());
		pStmt.setString(4, record.getNote());
		

		int count = pStmt.executeUpdate();
        if (count == 1) {
                result = true;
            }
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
		//DB切断
		try {
			if (conn!= null)conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	return result;
  }	
	
	
	//削除のメゾット
	public boolean deleteSukusuku(int sukusukuId) {
		Connection conn = null;
        boolean deleteResult = false;
        
        try {
            // JDBCドライバを読み込む
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // データベースに接続する
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8", "root", "password");

            // DELETE文を準備する
            String sql = "DELETE FROM sukusukukiroku WHERE sukusuku_id = ?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setInt(1, sukusukuId);

            // DELETE文を実行し、結果を取得する
            int rowsDeleted = pStmt.executeUpdate();
            if (rowsDeleted == 1) {
                deleteResult = true;
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            deleteResult = false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            deleteResult = false;
        } finally {
            // データベースを切断
            if (conn != null) {
                try {
                    conn.close();
                } catch (java.sql.SQLException e) {
                    e.printStackTrace();
                    deleteResult = false;
                }
            }
        }
        // 結果を返す
        return deleteResult;
	}
	
}
