package cypher;

import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class DS {
    private PrivateKey privateKey;
    private PublicKey publicKey;
    private KeyPair keyPair;

    public DS() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(1024);
        this.keyPair = keyPairGenerator.generateKeyPair();
    }
    // Tạo cặp khóa RSA
    public boolean generateKey() {
        if (keyPair == null) return false;
        publicKey = keyPair.getPublic();
        privateKey = keyPair.getPrivate();
        return true;
    }
    public String signData(String data) throws Exception {
        if (privateKey == null) {
            throw new IllegalStateException("Chưa tạo khóa, hãy gọi generateKeyPair() trước.");
        }
        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initSign(privateKey);
        signature.update(data.trim().getBytes());
        byte[] signedData = signature.sign();
        return Base64.getEncoder().encodeToString(signedData); // Mã hóa thành Base64
    }
    public boolean verifySignature(String data, String signatureBase64) throws Exception {
        if (publicKey == null) {
            throw new IllegalStateException("Chưa tạo khóa, hãy gọi generateKeyPair() trước.");
        }
        byte[] signatureBytes = Base64.getDecoder().decode(signatureBase64); // Giải mã từ Base64
        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initVerify(publicKey);
        signature.update(data.getBytes());
        return signature.verify(signatureBytes);
    }
    public String exportPrivateKey() {
        if (privateKey == null) return null;
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }
    public String exportPublicKey() {
        if (publicKey == null) return null;
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }

    public void importPublicKey(String publicKeyStr, String alg) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(publicKeyStr);
        KeyFactory keyFactory = KeyFactory.getInstance(alg);
        publicKey = keyFactory.generatePublic(new X509EncodedKeySpec(keyBytes));
    }

    public void importPrivateKey(String privateKeyStr, String alg) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(privateKeyStr);
        KeyFactory keyFactory = KeyFactory.getInstance(alg);
        privateKey = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(keyBytes));
    }
    public boolean isKeyPairValid() {
        try {
            String testMessage = "Test message";
            String testSignature = signData(testMessage);
            return verifySignature(testMessage, testSignature);
        } catch (Exception e) {
            return false;
        }
    }

    public static void main(String[] args) throws Exception {
        DS ds = new DS();
        ds.generateKey();
        String text = "Van ban Duoc Ki";
        String signature =ds.signData(text);
        System.out.println(signature);
        System.out.println("PublicKey = " + ds.exportPublicKey());
        System.out.println("PrivateKey = " + ds.exportPrivateKey());
        boolean verify = ds.verifySignature(text, signature);
        System.out.println(verify);
    }
}
