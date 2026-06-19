package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Mamanoyousu;

public class MamanoyousuDao {
	//データベース接続
	private static final String URL= "jdbc:mysql://localhost:3306/c5?characterEncoding=UTF-8";//接続するデータベース名
	private static final String USER     = "root";//MySQLにログインするユーザー名
											      //⚠root は 管理者ユーザー
    private static final String PASSWORD = "";//上記ユーザーのパスワード
    
    //データ登録、SQL準備
    public boolean insert(Mamanoyousu m) {
    	String sql="INSERT INTO mamanoyousu "
    	                + "(family_id, couple_id, physical_score, mental_score, sleep_hours, stress, memo, recorded_date) "
    	                + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
    	try(Connection conn= 
    			DriverManager.getConnection(URL, USER, PASSWORD);
                PreparedStatement ps = conn.prepareStatement(sql)){
 

    		ps.setString(1, m.getFamilyId());
            ps.setInt(2, m.getCoupleId());
            ps.setInt(3, m.getPhysicalScore());
            ps.setInt(4, m.getMentalScore());
            ps.setDouble(5, m.getSleepHours());
            ps.setInt(6, m.getStress());
            ps.setString(7, m.getMemo());

            return ps.executeUpdate() > 0;

    }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

// 最新データ取得
     public Mamanoyousu findLatest(String familyId) {

         String sql = "SELECT * FROM mamanoyousu "
                    + "WHERE family_id=? ORDER BY recorded_date DESC LIMIT 1";

         try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
              PreparedStatement ps = conn.prepareStatement(sql))
         {    
        	 ps.setString(1, familyId);
             ResultSet rs = ps.executeQuery();

             if (rs.next()) {
                 Mamanoyousu m = new Mamanoyousu();
                 m.setPhysicalScore(rs.getInt("physical_score"));
                 m.setMentalScore(rs.getInt("mental_score"));
                 m.setSleepHours(rs.getDouble("sleep_hours"));
                 m.setStress(rs.getInt("stress"));
                 m.setMemo(rs.getString("memo"));
                 return m;
             }

         } catch (Exception e) {
             e.printStackTrace();
         }
         return null;
     }
 }

