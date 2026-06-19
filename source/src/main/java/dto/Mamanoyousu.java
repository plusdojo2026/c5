package dto;

public class Mamanoyousu {
	private int mamanoyousuId; //ママの様子ID(主キー)
	private String familyId;	/*家族名（夫婦共通）*/
	private int coupleId;		/*夫01、妻00*/
	private int physicalScore;	/*体調*/
	private int mentalScore;	/*メンタル*/
	private double sleepHours;	/*睡眠時間*/
	private int stress;			/*ストレス値*/
	private String memo;		/*メモ*/
	
	public Mamanoyousu() {}
	
	public Mamanoyousu(String familyId,int coupleId,int physicalScore,int mentalScore,double sleepHours,
			int stress, String memo) {
		this.familyId=familyId;
		this.coupleId=coupleId;
		this.physicalScore=physicalScore;
		this.mentalScore=mentalScore;
		this.sleepHours=sleepHours;
		this.stress=stress;
		this.memo=memo;
	}
	
	//ゲッター・セッター
	public int getMamanoyousuId() {
		return mamanoyousuId;
	} public void setMamanoyousuId(int mamanoyousuId) {
		this.mamanoyousuId= mamanoyousuId;
	}
	
	public String getFamilyId(){
		return familyId;
	}
	public void setFamilyId(String familyId) {
		this.familyId = familyId; }
	
	public int getCoupleId() {
		return coupleId;
	}
	public void setCoupleId(int coupleId) {
		this.coupleId = coupleId;}
	
	public int getPhysicalScore() { 
		return physicalScore; 
	}
	public void setPhysicalScore(int physicalScore) { 
		this.physicalScore = physicalScore;}
	
	public int getMentalScore() { 
		return mentalScore;
	}
	public void setMentalScore(int mentalScore) {
		this.mentalScore = mentalScore;
	}
	
	public double getSleepHours() {
		return sleepHours;
	}
	public void setSleepHours(double sleepHours) {
		this.sleepHours = sleepHours;
	}
	
	public int getStress() {
		return stress;
	}
	public void setStress(int stress) {
		this.stress = stress;
	}
	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
}
