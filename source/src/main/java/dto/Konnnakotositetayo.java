package dto;

/**
 * こんなことしてたよ テーブルのデータを保持するdto
 * konnnakotositetayo テーブルの1行分のデータを格納する
 */
public class Konnnakotositetayo {

    // こんなことしてたよID（主キー）
    private int konnnakotositetayoId;

    // ファミリーID
    private String familyId;

    // カップルID（0=妻, 1=夫）
    private int coupleId;

    // タスク名（ミルク・夜泣き・おむつ交換など）
    private String taskId;

    // 回数
    private int count;

    // 補足メモ
    private String memo;

    // 表示順
    private int displayOrder;

    // 登録日時
    private String createdAt;

    // 記録日（日ごとに管理）
    private String recordedDate;

    // 既読フラグ（0=未読, 1=既読）
    private int isRead;


    // ===== getter =====

    public int getKonnnakotositetayoId() {
        return konnnakotositetayoId;
    }

    public String getFamilyId() {
        return familyId;
    }

    public int getCoupleId() {
        return coupleId;
    }

    public String getTaskId() {
        return taskId;
    }

    public int getCount() {
        return count;
    }

    public String getMemo() {
        return memo;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public String getRecordedDate() {
        return recordedDate;
    }

    public int getIsRead() {
        return isRead;
    }


    // ===== setter =====

    public void setKonnnakotositetayoId(int konnnakotositetayoId) {
        this.konnnakotositetayoId = konnnakotositetayoId;
    }

    public void setFamilyId(String familyId) {
        this.familyId = familyId;
    }

    public void setCoupleId(int coupleId) {
        this.coupleId = coupleId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public void setRecordedDate(String recordedDate) {
        this.recordedDate = recordedDate;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }
}
