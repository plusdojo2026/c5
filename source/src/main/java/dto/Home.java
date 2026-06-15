package dto;

public class Home {

	/** ポップアップを識別するためのID */
	private int popupId;

	/** パパ・ママを識別するID */
	private int coupleId;

	/** ホーム画面のポップアップに表示するメッセージ */
	private String message;

public Home() {
	}

	/** ポップアップ情報を初期化するコンストラクタ */
	public Home(int popupId, int coupleId, String message) {
		this.popupId = popupId;
		this.coupleId = coupleId;
		this.message = message;
	}

	/** ポップアップIDを取得する */
	public int getPopupId() {
		return popupId;
	}

	/** ポップアップIDを設定する */
	public void setPopupId(int popupId) {
		this.popupId = popupId;
	}

	/** 表示対象者IDを取得する */
	public int getCoupleId() {
		return coupleId;
	}

	/** 表示対象者IDを設定する*/
	public void setCoupleId(int coupleId) {
		this.coupleId = coupleId;
	}

	/** ポップアップに表示するメッセージを取得する */
	public String getMessage() {
		return message;
	}

	/** ポップアップに表示するメッセージを設定する */
	public void setMessage(String message) {
		this.message = message;
	}
}