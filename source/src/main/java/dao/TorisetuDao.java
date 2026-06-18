package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Torisetu;

public class TorisetuDao {
	
//--------トリセツを表示する--------
	public Torisetu selectByFamilyIdAndCoupleId(String familyId,int coupleId) {
        Connection conn = null;
        Torisetu card = null;
    //JDBCドライバ読み込み
    	try {Class.forName("com.mysql.cj.jdbc.Driver");
    //DBに接続　※仮の入力
    	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/futarigoto_db?characterEncoding=UTF-8","root","");
    //SQLを準備
    	String sql = "SELECT * FROM torisetu WHERE family_id=? AND couple_id=?";
    	PreparedStatement pStmt = conn.prepareStatement(sql);
    	pStmt.setString(1,familyId);
    	pStmt.setInt(2,coupleId);
    	ResultSet rs = pStmt.executeQuery();
    	
    	if(rs.next()) {
    	   card = new Torisetu();
   	
           card.setFamilyId(rs.getString("family_id"));
           card.setCoupleId(rs.getInt("couple_id"));
           card.setTorisetuId(rs.getInt("torisetu_id"));
           card.setHappy1(rs.getString("happy1"));
           card.setHappy2(rs.getString("happy2"));
           card.setHappy3(rs.getString("happy3"));
           card.setAngry1(rs.getString("angry1"));
           card.setAngry2(rs.getString("angry2"));
           card.setAngry3(rs.getString("angry3"));
           card.setFun1(rs.getString("fun1"));
           card.setFun2(rs.getString("fun2"));
           card.setFun3(rs.getString("fun3"));
   		   card.setSad1(rs.getString("sad1"));
           card.setSad2(rs.getString("sad2"));
           card.setSad3(rs.getString("sad3"));
           card.setCharge1(rs.getString("charge1"));
           card.setCharge2(rs.getString("charge2"));
           card.setCharge3(rs.getString("charge3"));
           card.setBad1(rs.getString("bad1"));
           card.setBad2(rs.getString("bad2"));
           card.setBad3(rs.getString("bad3"));
           card.setBadaction1(rs.getString("badaction1"));
           card.setBadaction2(rs.getString("badaction2"));
           card.setBadaction3(rs.getString("badaction3"));
           card.setUpdateAt(rs.getTimestamp("update_at").toString());
   	}
   	
   	//SQLを実行する
   	}catch(Exception e) {
   		e.printStackTrace();
   	}finally {
   		if(conn != null)try {conn.close();}catch(SQLException e) {}
   	}
   	return card;
    }
	
//--------トリセツを入力する--------
	//引数proで登録されたレコードを登録し、成功したらtrueを返す
	public boolean insert(Torisetu pro) {
		Connection conn = null;
		boolean result = false;
	//JDBCドライバ読み込み
	try {Class.forName("com.mysql.cj.jdbc.Driver");
	//DBに接続　※仮の入力
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/futarigoto_db?characterEncoding=UTF-8","root","");
	//SQLを準備
	String sql = "INSERT INTO torisetu("
										+ "family_id,couple_id,"
										+ "happy1,happy2,happy3,"
										+ "angry1,angry2,angry3,"
										+ "fun1,fun2,fun3,"
										+ "sad1,sad2,sad3,"
										+ "charge1,charge2,charge3,"
										+ "bad1,bad2,bad3,"
										+ "badaction1,badaction2,badaction3,"
										+ "update_at"
										+ ") VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
	PreparedStatement pStmt = conn.prepareStatement(sql);
	
			
	//"INSERT INTO Torisetu VALUES (?,0,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	//SQLの？に値を入れる
	pStmt.setString(1,pro.getFamilyId());
	pStmt.setInt(2,pro.getCoupleId());
	
	if (pro.getHappy1() != null) {
		pStmt.setString(3, pro.getHappy1());
	} else {
		pStmt.setString(3, "");
		
	}if (pro.getHappy2() != null) {
		pStmt.setString(4, pro.getHappy2());
	} else {
		pStmt.setString(4, "");
	
	}if (pro.getHappy3() != null) {
		pStmt.setString(5, pro.getHappy3());
	} else {
		pStmt.setString(5, "");
	
	}if (pro.getAngry1() != null) {
		pStmt.setString(6, pro.getAngry1());
	} else {
		pStmt.setString(6, "");
	
	}if (pro.getAngry2() != null) {
		pStmt.setString(7, pro.getAngry2());
	} else {
		pStmt.setString(7, "");
	
	}if (pro.getAngry3() != null) {
		pStmt.setString(8, pro.getAngry3());
	} else {
		pStmt.setString(8, "");
	
	}if (pro.getFun1() != null) {
		pStmt.setString(9, pro.getFun1());
	} else {
		pStmt.setString(9, "");
	
	}if (pro.getFun2() != null) {
		pStmt.setString(10, pro.getFun2());
	} else {
		pStmt.setString(10, "");
	
	}if (pro.getFun3() != null) {
		pStmt.setString(11, pro.getFun3());
	} else {
		pStmt.setString(11, "");
	
	}if (pro.getSad1() != null) {
		pStmt.setString(12, pro.getSad1());
	} else {
		pStmt.setString(12, "");
	
	}if (pro.getSad2() != null) {
		pStmt.setString(13, pro.getSad2());
	} else {
		pStmt.setString(13, "");
	
	}if (pro.getSad3() != null) {
		pStmt.setString(14, pro.getSad3());
	} else {
		pStmt.setString(14, "");
	
	}if (pro.getCharge1() != null) {
		pStmt.setString(15, pro.getCharge1());
	} else {
		pStmt.setString(15, "");
	
	}if (pro.getCharge2() != null) {
		pStmt.setString(16, pro.getCharge2());
	} else {
		pStmt.setString(16, "");
	
	}if (pro.getCharge3() != null) {
		pStmt.setString(17, pro.getCharge3());
	} else {
		pStmt.setString(17, "");
	
	}if (pro.getBad1() != null) {
		pStmt.setString(18, pro.getBad1());
	} else {
		pStmt.setString(18, "");
	
	}if (pro.getBad2() != null) {
		pStmt.setString(19, pro.getBad2());
	} else {
		pStmt.setString(19, "");
	
	}if (pro.getBad3() != null) {
		pStmt.setString(20, pro.getBad3());
	} else {
		pStmt.setString(20, "");
	
	}if (pro.getBadaction1() != null) {
		pStmt.setString(21, pro.getBadaction1());
	} else {
		pStmt.setString(21, "");
	
	}if (pro.getBadaction2() != null) {
		pStmt.setString(22, pro.getBadaction2());
	} else {
		pStmt.setString(22, "");
	
	}if (pro.getBadaction3() != null) {
		pStmt.setString(23, pro.getBadaction3());
	} else {
		pStmt.setString(23, "");
	}

	
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
    
//--------トリセツを更新する--------
	//引数proで登録されたレコードを登録し、成功したらtrueを返す
	public boolean update(Torisetu pro) {
		Connection conn = null;
		boolean result = false;
	//JDBCドライバ読み込み
	try {Class.forName("com.mysql.cj.jdbc.Driver");
	//DBに接続　※仮の入力
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/futarigoto_db?characterEncoding=UTF-8","root","");
	//SQLを準備
		String sql = "UPDATE torisetu SET happy1=?,happy2=?,happy3=?,"
											+ "angry1=?,angry2=?,angry3=?,"
											+ "fun1=?,fun2=?,fun3=?,"
											+ "sad1=?,sad2=?,sad3=?,"
											+ "charge1=?,charge2=?,charge3=?,"
											+ "bad1=?,bad2=?,bad3=?,"
											+ "badaction1=?,badaction2=?,badaction3=?,"
											+ "update_at=NOW() WHERE family_id=? AND couple_id=?";
		PreparedStatement pStmt = conn.prepareStatement(sql);
	//SQLの？に値を入れる
		pStmt.setString(1, pro.getHappy1());
		pStmt.setString(2, pro.getHappy2());
		pStmt.setString(3, pro.getHappy3());
		pStmt.setString(4, pro.getAngry1());
		pStmt.setString(5, pro.getAngry2());
		pStmt.setString(6, pro.getAngry3());
		pStmt.setString(7, pro.getFun1());
		pStmt.setString(8, pro.getFun2());
		pStmt.setString(9, pro.getFun3());
		pStmt.setString(10, pro.getSad1());
		pStmt.setString(11, pro.getSad2());
		pStmt.setString(12, pro.getSad3());
		pStmt.setString(13, pro.getCharge1());
		pStmt.setString(14, pro.getCharge2());
		pStmt.setString(15, pro.getCharge3());
		pStmt.setString(16, pro.getBad1());
		pStmt.setString(17, pro.getBad2());
		pStmt.setString(18, pro.getBad3());
		pStmt.setString(19, pro.getBadaction1());
		pStmt.setString(20, pro.getBadaction2());
		pStmt.setString(21, pro.getBadaction3());
		
		pStmt.setString(22, pro.getFamilyId());
		pStmt.setInt(23, pro.getCoupleId());
	
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
