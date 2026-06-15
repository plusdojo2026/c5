package dto;

import java.io.Serializable;

public class Torisetu implements Serializable{
	private String familyId;		/*ファミリーID*/
	private int coupleId;			/*カップルID　妻=0,夫=1*/
	private int torisetuid;				/*自動採番*/
	private String happy1; 				/*喜ぶこと*/
	private String happy2; 			
	private String happy3; 			
	private String angry1; 				/*怒ること*/
	private String angry2; 			
	private String angry3; 			
	private String fun1; 				/*楽しいこと*/
	private String fun2; 			
	private String fun3; 			
	private String sad1; 				/*悲しいこと*/
	private String sad2; 			
	private String sad3; 			
	private String charge1; 			/*充電方法*/
	private String charge2; 			
	private String charge3; 			
	private String bad1; 				/*不機嫌かなと思ったら*/
	private String bad2; 			
	private String bad3; 			
	private String badaction1; 			/*対応方法*/
	private String badaction2; 			
	private String badaction3; 			
	private String updateAt;			/*更新日*/
	
	/*コンストラクタの生成*/	
	public Torisetu(String familyId,int coupleId,int torisetuid,String happy1,String happy2,String happy3,
			String angry1,String angry2,String angry3,String fun1,String fun2,String fun3,
			String sad1,String sad2,String sad3,String charge1,String charge2,String charge3,
			String bad1,String bad2,String bad3,String badaction1,String badaction2,String badaction3) {
		super();
		this.familyId = familyId;
		this.coupleId = coupleId;
		this.torisetuid = 0;
		this.happy1 = "happy1";
		this.happy2 = "happy2";
		this.happy3 = "happy3";
		this.angry1 = "angry1";
		this.angry2 = "angry2";
		this.angry3 = "angry3";
		this.fun1 = "fun1";
		this.fun2 = "fun2";
		this.fun3 = "fun3";
		this.sad1 = "sad1";
		this.sad2 = "sad2";
		this.sad3 = "sad3";
		this.charge1 = "charge1";
		this.charge2 = "charge2";
		this.charge3 = "charge3";
		this.bad1 = "bad1";
		this.bad2 = "bad2";
		this.bad3 = "bad3";
		this.badaction1 = "badaction1";
		this.badaction2 = "badaction2";
		this.badaction3 = "badaction3";
	}
	
/*引数の無いコンストラクタ*/
	public Torisetu() {
		super();
		this.familyId = "";
		this.coupleId = -1;	/*0が使用できないため*/
		this.torisetuid = 0;
		this.happy1 = "";
		this.happy2 = "";
		this.happy3 = "";
		this.angry1 = "";
		this.angry2 = "";
		this.angry3 = "";
		this.fun1 = "";
		this.fun2 = "";
		this.fun3 = "";
		this.sad1 = "";
		this.sad2 = "";
		this.sad3 = "";
		this.charge1 = "";
		this.charge2 = "";
		this.charge3 = "";
		this.bad1 = "";
		this.bad2 = "";
		this.bad3 = "";
		this.badaction1 = "";
		this.badaction2 = "";
		this.badaction3 = "";
	}

	/*ゲッタとセッタ*/
	public String getFamilyId() {
		return familyId;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}
	
	public int setCoupleId() {
		return coupleId;
	}

	public void setCoupleId(int coupleId) {
		this.coupleId = coupleId;
	}
	
	public int getTorisetuid() {
		return torisetuid;
	}

	public void setTorisetuid(int torisetuid) {
		this.torisetuid = torisetuid;
	}

	public String getHappy1() {
		return happy1;
	}

	public void setHappy1(String happy1) {
		this.happy1 = happy1;
	}

	public String getHappy2() {
		return happy2;
	}

	public void setHappy2(String happy2) {
		this.happy2 = happy2;
	}

	public String getHappy3() {
		return happy3;
	}

	public void setHappy3(String happy3) {
		this.happy3 = happy3;
	}

	public String getAngry1() {
		return angry1;
	}

	public void setAngry1(String angry1) {
		this.angry1 = angry1;
	}

	public String getAngry2() {
		return angry2;
	}

	public void setAngry2(String angry2) {
		this.angry2 = angry2;
	}

	public String getAngry3() {
		return angry3;
	}

	public void setAngry3(String angry3) {
		this.angry3 = angry3;
	}

	public String getFun1() {
		return fun1;
	}

	public void setFun1(String fun1) {
		this.fun1 = fun1;
	}

	public String getFun2() {
		return fun2;
	}

	public void setFun2(String fun2) {
		this.fun2 = fun2;
	}

	public String getFun3() {
		return fun3;
	}

	public void setFun3(String fun3) {
		this.fun3 = fun3;
	}

	public String getSad1() {
		return sad1;
	}

	public void setSad1(String sad1) {
		this.sad1 = sad1;
	}

	public String getSad2() {
		return sad2;
	}

	public void setSad2(String sad2) {
		this.sad2 = sad2;
	}

	public String getSad3() {
		return sad3;
	}

	public void setSad3(String sad3) {
		this.sad3 = sad3;
	}

	public String getCharge1() {
		return charge1;
	}

	public void setCharge1(String charge1) {
		this.charge1 = charge1;
	}

	public String getCharge2() {
		return charge2;
	}

	public void setCharge2(String charge2) {
		this.charge2 = charge2;
	}

	public String getCharge3() {
		return charge3;
	}

	public void setCharge3(String charge3) {
		this.charge3 = charge3;
	}

	public String getBad1() {
		return bad1;
	}

	public void setBad1(String bad1) {
		this.bad1 = bad1;
	}

	public String getBad2() {
		return bad2;
	}

	public void setBad2(String bad2) {
		this.bad2 = bad2;
	}

	public String getBad3() {
		return bad3;
	}

	public void setBad3(String bad3) {
		this.bad3 = bad3;
	}

	public String getBadaction1() {
		return badaction1;
	}

	public void setBadaction1(String badaction1) {
		this.badaction1 = badaction1;
	}

	public String getBadaction2() {
		return badaction2;
	}

	public void setBadaction2(String badaction2) {
		this.badaction2 = badaction2;
	}

	public String getBadaction3() {
		return badaction3;
	}

	public void setBadaction3(String badaction3) {
		this.badaction3 = badaction3;
	}

	public String getUpdateAt() {
		return updateAt;
	}

	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}
	
	
	
}
