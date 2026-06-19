package dto;

public class Sukusukukiroku {
	private int sukusukuId;		//すくすくID
	private String family_Id;	//家族名（夫婦共通）
	private double weight;		//体重
	private double temperature;	//体温
	private String note;		//メモ
	private String recordedAt;	//日時（自動入力）
	
	//引数なしコンストラクタ
	public Sukusukukiroku() {}

	//引数ありコンストラクタ
	public Sukusukukiroku(int sukusukuId,String family_Id,double weight,double temperature,
			String note,String recordedAt) {
		super();
		this.sukusukuId=sukusukuId;
		this.family_Id=family_Id;
		this.temperature=temperature;
		this.weight=weight;		
		this.note=note;
		this.recordedAt=recordedAt;
	}
	
	public int getSukusukuId() {
		return sukusukuId;
	}public void setSukusukuId(int sukusukuId) {
		this.sukusukuId=sukusukuId;
	}
	
	public String getfamily_Id() {
		return family_Id;
	}public void setfamily_Id(String family_Id) {
		this.family_Id=family_Id;
	}
	
	public double getTemperature(){
		return temperature;
	}public void setTemperature(double temperature){
		this.temperature= temperature;
	}
	
	public double getWeight () {
		return  weight;
	}public void setWeight(double weight){
		this.weight=weight;
	}
	
	public String getNote(){
		return note;
	}public void setNote(String note){
		this.note=note;
	}
	
	public String getRecordedAt(){
		return recordedAt;
	}public void setRecordedAt(String recordedAt){
		this.recordedAt=recordedAt;
	}
}
