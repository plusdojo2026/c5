package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Users;

public class UsersDao {
	// 引数で指定されたidpwでログイン成功ならtrueを返す
	public boolean isLoginOK(Users user) {
		Connection conn = null;
		boolean loginResult = false;
			
		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する　後でコード変更有
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp1?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "Mikan0729");
				
			// SELECT文を準備する
            String sql = "SELECT count(*) FROM users WHERE family_id=? AND couple_id=? AND password=?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, user.getFamilyId());
            pStmt.setInt(2, user.getCoupleId());    // int型なので setInt を使う
            pStmt.setString(3, user.getPassword());

            // SELECT文を実行し、結果表を取得する
            ResultSet rs = pStmt.executeQuery();

            // ユーザー情報が一致するユーザーがいれば結果をtrueにする
            rs.next();
            if (rs.getInt("count(*)") == 1) {
                loginResult = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            loginResult = false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            loginResult = false;
        } finally {
            // データベースを切断
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    loginResult = false;
                }
            }
        }

        // 結果を返す
        return loginResult;
    }


    // 2. 新規登録をするメソッド
    public boolean register(Users user) {
        Connection conn = null;
        boolean insertResult = false;
        
        try {
            // JDBCドライバを読み込む
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // データベースに接続する
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp1?"
                    + "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
                    "root", "Mikan0729");
            
            // INSERT文を準備する
            String sql = "INSERT INTO users (family_id, couple_id, password) VALUES (?, ?, ?)";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, user.getFamilyId());
            pStmt.setInt(2, user.getCoupleId());    // int型なので setInt を使う
            pStmt.setString(3, user.getPassword());
            
            // INSERT文を実行し、結果を取得する
            int rowsInserted = pStmt.executeUpdate();
            if (rowsInserted == 1) {
                insertResult = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            insertResult = false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            insertResult = false;
        } finally {
            // データベースを切断
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    insertResult = false;
                }
            }
        }

        // 結果を返す
        return insertResult;
    }
}

