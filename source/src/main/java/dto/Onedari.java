package dto;

import java.io.Serializable;

public class Onedari implements Serializable {
    private static final long serialVersionUID = 1L;

    private int onedariId;        // おねだりID（主キー）
    private String familyId;      // ファミリーコード
    private int coupleId;         // ママパパ区分（0:ママ / 1:パパ）
    private int categoryId;       // カテゴリID（マスタのID番号が入る箱）
    private String category;      // カテゴリ（マスタから引っ張る日本語名）
    private String productName;   // 商品名（ブランドや自由記述名）
    private String type;          // タイプ（テープ、パンツ、缶など）
    private String size;          // サイズ（新生児、S、Mなど）
    private String imagePath;     // 画像のファイル名
    private String createdAt;     // 登録日時
    private String updatedAt;     // 購入日時（空でなければ購入済み）
    
    public int getOnedariId() {
        return onedariId;
    }
    public void setOnedariId(int onedariId) {
        this.onedariId = onedariId;
    }
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
    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public String getSize() {
        return size;
    }
    public void setSize(String size) {
        this.size = size;
    }
    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    public String getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Onedari() {
    }
    
    //データをまとめて箱に入れるためのコンストラクタ
    public Onedari(int onedariId, String familyId, int coupleId, int categoryId, String category, 
                   String productName, String type, String size, String imagePath, String createdAt, String updatedAt) {
        this.onedariId = onedariId;
        this.familyId = familyId;
        this.coupleId = coupleId;
        this.categoryId = categoryId;
        this.category = category;
        this.productName = productName;
        this.type = type;
        this.size = size;
        this.imagePath = imagePath;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;     
    }
}
