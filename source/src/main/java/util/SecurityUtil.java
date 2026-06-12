package util;

import java.security.MessageDigest;

public class SecurityUtil {
	/**
     * 生パスワードをSHA-256でハッシュ化（64文字の英数字に暗号化）するメソッド
     */
    public static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        try {
            // SHA-256の暗号化モジュールを準備
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            // パスワード文字列をバイト列に変換してハッシュ値を計算
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            
            // 計算されたバイト列を、16進数の文字列（64文字）に変換
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString(); // 変換したハッシュ値を返す
        } catch (Exception e) {
            // 例外が発生した場合はランタイム例外としてスロー
            throw new RuntimeException(e);
        }
    }

}
