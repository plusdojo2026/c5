package dto;

public class Sukusukukiroku {
	private int sukusukuId;		//すくすくID
	private String family_Id;	//家族名（夫婦共通）
	private double weight;		//体重
	private double temperature;	//体温
	private String note;		//メモ
	private String recordedAt;	//日時（自動入力）
	
	public Sukusukukiroku(int sukusukuId,String family_Id,double weight,double temperature,
			String note,String recordedAt) {
		super();
		this.sukusukuId=sukusukuId;
		this.family_Id=family_Id;
		this.weight=weight;
		this.temperature=temperature;
		this.note=note;
		this.recordedAt=recordedAt;
	}
	
	public int getsukusukuId() {
		return sukusukuId;
	}public void setsukusukuId(int sukusukuId) {
		this.sukusukuId=sukusukuId;
	}
	
	public String getfamily_Id() {
		return family_Id;
	}public void setfamily_Id(String family_Id) {
		this.family_Id=family_Id;
	}
	
	public double getweight () {
		return  weight;
	}public void setweight(double weight){
		this.weight=weight;
	}
	
	public double gettemperature(){
		return temperature;
	}public void settemperature(){
		this.temperature= temperature;
	}
	
	public String getnote(){
		return note;
	}public void setnote(){
		this.note=note;
	}
	
	public String getrecordedAt(){
		return recordedAt;
	}public void setrecordedAt(){
		this.recordedAt=recordedAt;
	}
}
