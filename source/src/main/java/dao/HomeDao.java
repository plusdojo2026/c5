package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Home;

public class HomeDao {

/** 夫婦別にランダムなポップアップメッセージを取得する　*/
public Home getRandomPopup(int coupleId) {
	Connection conn = null;
	Home popup = null;

	try {
		// JDBCドライバを読み込む
		Class.forName("com.mysql.cj.jdbc.Driver");

		// DB接続
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Tokyo&connectTimeout=30000", "c5", "xMN3sWVGp4WNhyCz");

		// SQL文を準備
		String sql =
			"SELECT * FROM popup "
			+ "WHERE couple_id = ? "
			+ "ORDER BY RAND() "
			+ "LIMIT 1";

		PreparedStatement pStmt = conn.prepareStatement(sql);

		pStmt.setInt(1, coupleId);

		// SQL実行
		ResultSet rs = pStmt.executeQuery();

		// 取得できた場合
		if (rs.next()) {
			popup = new Home(
				rs.getInt("popup_id"),
				rs.getInt("couple_id"),
				rs.getString("message")
			);
		}

	}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// DB切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return popup;
	}
}