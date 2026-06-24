package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Onedari;

public class OnedariDao {

    // １．おねだり一覧を取得するメソッド
    public List<Onedari> findByFamilyId(String familyId) {
        Connection conn = null;
        List<Onedari> list = new ArrayList<>();

        try {
            // JDBCドライバを読み込む
            Class.forName("com.mysql.cj.jdbc.Driver");

            // データベースに接続する
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8", "root", "Mikan0729");

            // SELECT文を準備する
            String sql = """
                SELECT 
                    onedari.*, 
                    category.name AS category_name, 
                    category.type AS category_type, 
                    category.size AS category_size 
                FROM onedari 
                INNER JOIN category ON onedari.category_id = category.id 
                WHERE onedari.family_id = ? 
                ORDER BY (onedari.updated_at IS NOT NULL) ASC, onedari.onedari_id DESC
                """;
            
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, familyId);

            // SELECT文を実行し、結果表を取得する
            ResultSet rs = pStmt.executeQuery();

            // 結果表からデータを取り出してリストに詰める
            while (rs.next()) {
                Onedari onedari = new Onedari();
                onedari.setOnedariId(rs.getInt("onedari_id"));
                onedari.setFamilyId(rs.getString("family_id"));
                onedari.setCoupleId(rs.getInt("couple_id"));
                onedari.setCategoryId(rs.getInt("category_id"));
                
                // データを受け取る
                onedari.setCategory(rs.getString("category_name"));
                onedari.setType(rs.getString("category_type"));
                onedari.setSize(rs.getString("category_size"));
                
                //ユーザーが自由に入力した商品名を取得
                onedari.setProductName(rs.getString("product_name"));
                onedari.setImagePath(rs.getString("image_path"));
                onedari.setCreatedAt(rs.getString("created_at"));
                onedari.setUpdatedAt(rs.getString("updated_at"));

                list.add(onedari);
            }
        } catch (SQLException e) {
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
        return list;
    }

    // ２．おねだりリストに新規登録をするメソッド
    public boolean register(Onedari onedari) {
        Connection conn = null;
        boolean insertResult = false;

     // JDBCドライバを読み込む
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8", "root", "Mikan0729");

            // INSERT文を準備する
            String sql = "INSERT INTO onedari (family_id, couple_id, category_id, product_name, image_path) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, onedari.getFamilyId());
            pStmt.setInt(2, onedari.getCoupleId());  		// int型なので setInt を使う   
            pStmt.setInt(3, onedari.getCategoryId());       // int型なので setInt を使う
            pStmt.setString(4, onedari.getProductName()); 
            pStmt.setString(5, onedari.getImagePath());

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

    // ３．購入完了状態に更新するメソッド
    public boolean completeOnedari(int onedariId) {
        Connection conn = null;
        boolean updateResult = false;

     // JDBCドライバを読み込む
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8", "root", "Mikan0729");
            
         // UPDATE文を準備する
            String sql = "UPDATE onedari SET updated_at = NOW() WHERE onedari_id = ?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setInt(1, onedariId);		// int型なので setInt を使う

         // UPDATE文を実行し、結果を取得する
            int rowsUpdated = pStmt.executeUpdate();
            if (rowsUpdated == 1) {
                updateResult = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            updateResult = false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            updateResult = false;
        } finally {
        	 // データベースを切断
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    updateResult = false;
                }
            }
        }
     // 結果を返す
        return updateResult;
    }

    // ４．購入完了をキャンセルするメソッド
    public boolean cancelOnedari(int onedariId) {
        Connection conn = null;
        boolean updateResult = false;

     // JDBCドライバを読み込む
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8", "root", "Mikan0729");

            // UPDATE文を準備する
            String sql = "UPDATE onedari SET updated_at = NULL WHERE onedari_id = ?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setInt(1, onedariId);		// int型なので setInt を使う

         // UPDATE文を実行し、結果を取得する
            int rowsUpdated = pStmt.executeUpdate();
            if (rowsUpdated == 1) {
                updateResult = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            updateResult = false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            updateResult = false;
        } finally {
        	// データベースを切断
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    updateResult = false;
                }
            }
        }
     // 結果を返す
        return updateResult;
    }


	// ５．おねだりを削除するメゾット	
	public boolean deleteOnedari(int onedariId) {
		Connection conn = null;
        boolean deleteResult = false;
        
        try {
            // JDBCドライバを読み込む
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // データベースに接続する
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8", "root", "Mikan0729");

            // DELETE文を準備する
            String sql = "DELETE FROM onedari WHERE onedari_id = ?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setInt(1, onedariId);

            // DELETE文を実行し、結果を取得する
            int rowsDeleted = pStmt.executeUpdate();
            if (rowsDeleted == 1) {
                deleteResult = true;
            }
        } catch (SQLException e) {
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
                } catch (SQLException e) {
                    e.printStackTrace();
                    deleteResult = false;
                }
            }
        }
        // 結果を返す
        return deleteResult;
	}
}