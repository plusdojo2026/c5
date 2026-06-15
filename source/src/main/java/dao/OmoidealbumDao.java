package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dto.Omoidealbum;

public class OmoidealbumDao {

	public boolean insert(Omoidealbum album) {
		Connection conn = null;
		boolean result = false;
		
		/*JDBCドライバ読み込み*/
		try {
			Class.forName("conn.mysql.cj.jdbc.Driver");
		/*DBに接続*/
			conn = DriverManager.getConnection("");
		/*SQLを準備*/
		String sql = "INSERT INTO album(family_id,couple_id,photo_path,comment,created_at)"
					+"VALUES(?,?,?,?,NOW())";
		PreparedStatement ps = conn.prepareStatement(sql);
		
		/*SQLの？に値を入れる*/
		ps.setString(1, album.getFamilyId());
		ps.setInt(2,album.getCoupleId());
		ps.setString(3,album.getPhotoPath());
		ps.setString(4, album.getComment());
		
		/*SQLを実行する*/
		if(ps.executeUpdate()==1) {
			result = true;
		}
		
		}
	}
	
}
