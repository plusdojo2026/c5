package dao;//aa

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Omoidealbum;

public class OmoidealbumDao {
	
	//--------日記の一覧をfamilyIdとcoupleIdで取得し、タイムライン形式で並べる。--------
		public List<Omoidealbum> FindByFamilyIdAndCoupleId(String familyId,int coupleId){
		//結果を格納するリスト
			List<Omoidealbum> list = new ArrayList<Omoidealbum>();
		//DB接続に使う変数
			Connection conn = null;
		//JDBCドライバを読み込む
			try {Class.forName("com.mysql.cj.jdbc.Driver");
		//DBに接続 ※仮の入力
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8","root","password");
		//SQLを準備
			String sql = "SELECT * FROM album WHERE family_id=? AND couple_id ORDER BY album_id DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
		//SQLを完成
			ps.setString(1,familyId);
		// SQL文を実行し、結果表を取得する
			ResultSet rs = ps.executeQuery();
		// 結果表をコレクションにコピーする
			while (rs.next()) {
			Omoidealbum album = new Omoidealbum(rs.getString("family_id"),
											 	rs.getInt("couple_id"),
											 	rs.getInt("album_id"),
											 	rs.getString("photo_path"), 
											 	rs.getString("comment"),
											 	rs.getTimestamp("created_at"));
				list.add(album);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
		// データベースを切断
			if (conn != null)
				try { conn.close();
					} catch (SQLException e) {}
					}
		// 結果を返す
		return list;
		}
	
	//--------引数albumで指定されたレコードを削除し、成功したらtrueを返す--------
		public boolean delete(Omoidealbum album) {
		Connection conn = null;
		boolean result = false;
		
		//JDBCドライバを読み込む
		try {Class.forName("com.mysql.cj.jdbc.Driver");
		//DBに接続　※仮の入力
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8","root","password");
		//SQLを準備
		String sql = "DELETE FROM album WHERE album_id =? AND family_id AND couple_id=?";
		PreparedStatement pStmt = conn.prepareStatement(sql);
		//SQLを完成
		pStmt.setInt(1,album.getAlbumId());
		//SQLを実行
		if(pStmt.executeUpdate()==1) {
				result = true;
		}
	}catch(SQLException e) {
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} finally {
		// データベースを切断
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// 結果を返す
	return result;
}
	
	
	//--------日記を登録する--------//
		//引数albumで指定されたレコードを登録し、成功したらtrueを返す//
		public boolean insert(Omoidealbum album) {
		Connection conn = null;
		boolean result = false;
		
		//JDBCをドライバ読み込む
		try {Class.forName("com.mysql.cj.jdbc.Driver");
		//DBに接続
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8","root","password");
		//SQLを準備
		String sql = "INSERT INTO album (family_id, couple_id, photo_path, comment, created_at) VALUES(?,?,?,?,NOW())";
		PreparedStatement ps = conn.prepareStatement(sql);
		
		//SQLの？に値を入れる
		ps.setString(1, album.getFamilyId());
		ps.setInt(2,album.getCoupleId());
		ps.setString(3,album.getPhotoPath());
		ps.setString(4, album.getComment());
		
		//SQLを実行
		if(ps.executeUpdate()==1) {
			result = true;
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
		//DBを切断
			if(conn != null)try {conn.close();}catch(SQLException e) {}
		}
		//結果を返す
		return result;
	}
	
	
}
