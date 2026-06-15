package dto;


import java.io.Serializable;

public class Users implements Serializable {
	private String familyId;  // ファミリーコード
    private int coupleId;     // ママパパ区分（0:ママ / 1:パパ）
    private String password;  //パスワード
    
	public String getFamilyId() {
		return familyId;
	}
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}
	public int getCoupleId() {
		return coupleId;
	}
	public void setCoupleId(int coupleId) {
		this.coupleId = coupleId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Users() {
    }

    //  3つのデータをまとめて箱に入れるためのコンストラクタ
    public Users(String familyId, int coupleId, String password) {
        this.familyId = familyId;
        this.coupleId = coupleId;
        this.password = password;
    }
}
