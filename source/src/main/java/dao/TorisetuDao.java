package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dto.Torisetu;

public class TorisetuDao {
	
	//--------トリセツを入力する--------
	//引数proで登録されたレコードを登録し、成功したらtrueを返す
	public boolean insert(Torisetu pro) {
		Connection conn = null;
		boolean result = false;
	//JDBCドライバ読み込み
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
	//DBに接続
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/futarigoto_db?characterEncoding=UTF-8","root","");
	//SQLを準備
	String sql = "INSERT INTO torisetu("
								+ "family_id,copple_id,torisetu_id,"
								+ "happy1,happy2,happy3,"
								+ "angry1,angry2,angry3,"
								+ "fun1,fun2,fun3,"
								+ "sad1,sad2,sad3,"
								+ "charge1,charge2,charge3,"
								+ "bad1,bad2,bad3,"
								+ "badaction1,badaction2,badaction3,"
								+ "update_at"
								+ ") VALUES(?,-1,0,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
	PreparedStatement pStmt = conn.prepareStatement(sql);
	
	//SQLの？に値を入れる
	if (pro.getHappy1() != null) {
		pStmt.setString(1, pro.getHappy1());
	} else {
		pStmt.setString(1, "");
		
	if (pro.getHappy2() != null) {
		pStmt.setString(2, pro.getHappy2());
	} else {
		pStmt.setString(2, "");
			
	if (pro.getHappy3() != null) {
		pStmt.setString(3, pro.getHappy3());
	} else {
		pStmt.setString(3, "");
		
	if (pro.getAngry1() != null) {
		pStmt.setString(4, pro.getAngry1());
	} else {
		pStmt.setString(4, "");

	if (pro.getAngry2() != null) {
		pStmt.setString(5, pro.getAngry2());
	} else {
		pStmt.setString(5, "");
		
	if (pro.getAngry3() != null) {
		pStmt.setString(6, pro.getAngry3());
	} else {
		pStmt.setString(6, "");
		
	if (pro.getHappy1() != null) {
		pStmt.setString(1, pro.getHappy1());
	} else {
		pStmt.setString(1, "");
		
	if (pro.getHappy1() != null) {
		pStmt.setString(1, pro.getHappy1());
	} else {
		pStmt.setString(1, "");
		
	if (pro.getHappy1() != null) {
		pStmt.setString(1, pro.getHappy1());
	} else {
		pStmt.setString(1, "");
			
	if (pro.getHappy1() != null) {
		pStmt.setString(1, pro.getHappy1());
	} else {
		pStmt.setString(1, "");
				
	if (pro.getHappy1() != null) {
		pStmt.setString(1, pro.getHappy1());
	} else {
		pStmt.setString(1, "");
		


	//SQLを実行する
	
	
	if(pStmt.executeUpdate()==1) {
		result = true;
	}
	
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		if(conn != null)try {conn.close();}catch(SQLException e) {}
	}
	return result;
}
    
	}
}
