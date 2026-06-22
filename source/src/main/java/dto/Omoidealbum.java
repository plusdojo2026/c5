package dto;//aa

import java.io.Serializable;
import java.sql.Timestamp;

public class Omoidealbum implements Serializable {
	private String familyId;		/*ファミリーID*/
	private int coupleId;			/*カップルID　妻=0,夫=1*/
	/*private int familyalbumId;		ファミリーアルバムID*/
	private int albumId;			/*自動採番*/
	private String photoPath;		/*写真の保存パス*/
	private String comment;			/*コメント*/
	private Timestamp createdAt;	/*作成日時*/
	
/*コンストラクタの生成!*/
	public Omoidealbum(String familyId,int coupleId,int albumId,String photoPath,String comment,Timestamp createdAt) {
		super();
		this.familyId = familyId;
		this.coupleId = coupleId;
		this.albumId = albumId;
		/*this.familyalbumId = familyalbumId;*/
		this.photoPath = photoPath;
		this.comment = comment;
		this.createdAt = createdAt;
	}
	
/*引数の無いコンストラクタ*/
	public Omoidealbum() {
		super();
		this.familyId = "";
		this.coupleId = -1; /*0=妻のため、-1で未設定を表す*/
		/*this.familyalbumId = 0;*/
		this.albumId = 0;
		this.photoPath = "" ;
		this.comment = "" ;
		this.createdAt = null ;
	}
	
/*ゲッタとセッタ*/
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
	
	/*public int getfamilyalbumId() {
		return familyalbumId;
	}

	public void setfamilyalbumId(int familyalbumId) {
		this.familyalbumId = familyalbumId;
	}*/
	
	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	
}

