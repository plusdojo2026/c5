package dto;

/**
 * ふたりのバランス テーブルのデータを保持するクラス
 * futarinobalance テーブルの1行分のデータを格納する
 */
public class Futarinobalance {

    // バランスID（主キー）
    private int balanceId;

    // ファミリーID（familiesテーブルと紐づく）
    private String familyId;

    // カップルID（0=妻担当, 1=夫担当, 2=両方, 3=未割当）
    private int coupleId;

    // タスクID（todoテーブルのtask_idと紐づく）
    private int todoId;

    // 表示順（ドラッグ&ドロップで変わる順番）
    private int displayOrder;

    // タスク名（todoテーブルから取得した名前）
    private String taskName;


    // ===== getter（値を取り出すメソッド） =====

    public int getBalanceId() {
        return balanceId;
    }

    public String getFamilyId() {
        return familyId;
    }

    public int getCoupleId() {
        return coupleId;
    }

    public int getTodoId() {
        return todoId;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public String getTaskName() {
        return taskName;
    }


    // ===== setter（値をセットするメソッド） =====

    public void setBalanceId(int balanceId) {
        this.balanceId = balanceId;
    }

    public void setFamilyId(String familyId) {
        this.familyId = familyId;
    }

    public void setCoupleId(int coupleId) {
        this.coupleId = coupleId;
    }

    public void setTodoId(int todoId) {
        this.todoId = todoId;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }
}