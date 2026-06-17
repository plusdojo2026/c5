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
	try {Class.forName("com.mysql.cj.jdbc.Driver");
	//DBに接続　※仮の入力
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/futarigoto_db?characterEncoding=UTF-8","root","");
	//SQLを準備
	String sql = "INSERT INTO torisetu("
										+ "family_id,couple_id,torisetu_id,"
										+ "happy1,happy2,happy3,"
										+ "angry1,angry2,angry3,"
										+ "fun1,fun2,fun3,"
										+ "sad1,sad2,sad3,"
										+ "charge1,charge2,charge3,"
										+ "bad1,bad2,bad3,"
										+ "badaction1,badaction2,badaction3,"
										+ "update_at"
										+ ") VALUES(?,0,0,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
	PreparedStatement pStmt = conn.prepareStatement(sql);
	
			
	//"INSERT INTO Torisetu VALUES (?,0,0,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	//SQLの？に値を入れる
	pStmt.setString(1,pro.getFamilyId());
	pStmt.setInt(2,pro.getCoupleId());
	pStmt.setInt(3,pro.getTorisetuId());
	
	if (pro.getHappy1() != null) {
		pStmt.setString(4, pro.getHappy1());
	} else {
		pStmt.setString(4, "");
		
	}if (pro.getHappy2() != null) {
		pStmt.setString(5, pro.getHappy2());
	} else {
		pStmt.setString(5, "");
	
	}if (pro.getHappy3() != null) {
		pStmt.setString(6, pro.getHappy3());
	} else {
		pStmt.setString(6, "");
	
	}if (pro.getAngry1() != null) {
		pStmt.setString(7, pro.getAngry1());
	} else {
		pStmt.setString(7, "");
	
	}if (pro.getAngry2() != null) {
		pStmt.setString(8, pro.getAngry2());
	} else {
		pStmt.setString(8, "");
	
	}if (pro.getAngry3() != null) {
		pStmt.setString(9, pro.getAngry3());
	} else {
		pStmt.setString(9, "");
	
	}if (pro.getFun1() != null) {
		pStmt.setString(10, pro.getFun1());
	} else {
		pStmt.setString(10, "");
	
	}if (pro.getFun2() != null) {
		pStmt.setString(11, pro.getFun2());
	} else {
		pStmt.setString(11, "");
	
	}if (pro.getFun3() != null) {
		pStmt.setString(12, pro.getFun3());
	} else {
		pStmt.setString(12, "");
	
	}if (pro.getSad1() != null) {
		pStmt.setString(13, pro.getSad1());
	} else {
		pStmt.setString(13, "");
	
	}if (pro.getSad2() != null) {
		pStmt.setString(14, pro.getSad2());
	} else {
		pStmt.setString(14, "");
	
	}if (pro.getSad3() != null) {
		pStmt.setString(15, pro.getSad3());
	} else {
		pStmt.setString(15, "");
	
	}if (pro.getCharge1() != null) {
		pStmt.setString(16, pro.getCharge1());
	} else {
		pStmt.setString(16, "");
	
	}if (pro.getCharge2() != null) {
		pStmt.setString(17, pro.getCharge2());
	} else {
		pStmt.setString(17, "");
	
	}if (pro.getCharge3() != null) {
		pStmt.setString(18, pro.getCharge3());
	} else {
		pStmt.setString(18, "");
	
	}if (pro.getBad1() != null) {
		pStmt.setString(19, pro.getBad1());
	} else {
		pStmt.setString(19, "");
	
	}if (pro.getBad2() != null) {
		pStmt.setString(20, pro.getBad2());
	} else {
		pStmt.setString(20, "");
	
	}if (pro.getBad3() != null) {
		pStmt.setString(21, pro.getBad3());
	} else {
		pStmt.setString(21, "");
	
	}if (pro.getBadaction1() != null) {
		pStmt.setString(22, pro.getBadaction1());
	} else {
		pStmt.setString(22, "");
	
	}if (pro.getBadaction2() != null) {
		pStmt.setString(23, pro.getBadaction2());
	} else {
		pStmt.setString(23, "");
	
	}if (pro.getBadaction3() != null) {
		pStmt.setString(24, pro.getBadaction3());
	} else {
		pStmt.setString(24, "");
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
		String sql = "UPDATE torisetu　SET("
											+ "family_id=?,couple_id=?,torisetu_id=?,"
											+ "happy1=?,happy2=?,happy3=?,"
											+ "angry1=?,angry2=?,angry3=?,"
											+ "fun1=?,fun2=?,fun3=?,"
											+ "sad1=?,sad2=?,sad3=?,"
											+ "charge1=?,charge2=?,charge3=?,"
											+ "bad1=?,bad2=?,bad3=?,"
											+ "badaction1=?,badaction2=?,badaction3=?,"
											+ "update_at=?"
											+ ") VALUES(?,0,0,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
		PreparedStatement pStmt = conn.prepareStatement(sql);
	//SQLの？に値を入れる
		pStmt.setString(1,pro.getFamilyId());
		pStmt.setInt(2,pro.getCoupleId());
		pStmt.setInt(3,pro.getTorisetuId());
			
		if (pro.getHappy1() != null) {
			pStmt.setString(4, pro.getHappy1());
		} else {
			pStmt.setString(4, "");
			
		}if (pro.getHappy2() != null) {
			pStmt.setString(5, pro.getHappy2());
		} else {
			pStmt.setString(5, "");
		
		}if (pro.getHappy3() != null) {
			pStmt.setString(6, pro.getHappy3());
		} else {
			pStmt.setString(6, "");
		
		}if (pro.getAngry1() != null) {
			pStmt.setString(7, pro.getAngry1());
		} else {
			pStmt.setString(7, "");
			
		}if (pro.getAngry2() != null) {
			pStmt.setString(8, pro.getAngry2());
		} else {
			pStmt.setString(8, "");
		
		}if (pro.getAngry3() != null) {
			pStmt.setString(9, pro.getAngry3());
		} else {
			pStmt.setString(9, "");
		
		}if (pro.getFun1() != null) {
			pStmt.setString(10, pro.getFun1());
		} else {
			pStmt.setString(10, "");
		
		}if (pro.getFun2() != null) {
			pStmt.setString(11, pro.getFun2());
		} else {
			pStmt.setString(11, "");
		
		}if (pro.getFun3() != null) {
			pStmt.setString(12, pro.getFun3());
		} else {
			pStmt.setString(12, "");
		
		}if (pro.getSad1() != null) {
			pStmt.setString(13, pro.getSad1());
		} else {
			pStmt.setString(13, "");
			
		}if (pro.getSad2() != null) {
			pStmt.setString(14, pro.getSad2());
		} else {
			pStmt.setString(14, "");
		
		}if (pro.getSad3() != null) {
			pStmt.setString(15, pro.getSad3());
		} else {
			pStmt.setString(15, "");
		
		}if (pro.getCharge1() != null) {
			pStmt.setString(16, pro.getCharge1());
		} else {
			pStmt.setString(16, "");
			
		}if (pro.getCharge2() != null) {
			pStmt.setString(17, pro.getCharge2());
		} else {
			pStmt.setString(17, "");
			
		}if (pro.getCharge3() != null) {
			pStmt.setString(18, pro.getCharge3());
		} else {
			pStmt.setString(18, "");
			
		}if (pro.getBad1() != null) {
			pStmt.setString(19, pro.getBad1());
		} else {
			pStmt.setString(19, "");
			
		}if (pro.getBad2() != null) {
			pStmt.setString(20, pro.getBad2());
		} else {
			pStmt.setString(20, "");
			
		}if (pro.getBad3() != null) {
			pStmt.setString(21, pro.getBad3());
		} else {
			pStmt.setString(21, "");
			
		}if (pro.getBadaction1() != null) {
			pStmt.setString(22, pro.getBadaction1());
		} else {
			pStmt.setString(22, "");
			
		}if (pro.getBadaction2() != null) {
			pStmt.setString(23, pro.getBadaction2());
		} else {
			pStmt.setString(23, "");
			
		}if (pro.getBadaction3() != null) {
			pStmt.setString(24, pro.getBadaction3());
		} else {
			pStmt.setString(24, "");
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
	
}
