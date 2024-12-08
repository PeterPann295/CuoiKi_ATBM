package cypher;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.DigestInputStream;
import java.security.MessageDigest;

public class SHA {
    public static final String SHA_1 = "SHA-1";
    public static final String SHA_224 = "SHA-224";
    public static final String SHA_256 = "SHA-256";
    public static final String SHA_384 = "SHA-384";
    public static final String SHA_512 = "SHA-512";

    public String hashText(String input_text) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");

        byte[] message_digest = md.digest(input_text.getBytes());

        BigInteger number = new BigInteger(1, message_digest);

        return number.toString(16);
    }

    public String hashFile(String input_file) throws Exception {

        FileInputStream fis = null;
        InputStream is = null;
        DigestInputStream dis = null;

        try {
            File file = new File(input_file);

            if (!file.isFile()) {
                return "";
            }

            fis = new FileInputStream(file);
            is = new BufferedInputStream(fis);

            MessageDigest md = MessageDigest.getInstance("SHA-256");

            dis = new DigestInputStream(is, md);

            byte[] input_byte = new byte[1024];
            int read_byte;

            do {
                read_byte = dis.read(input_byte);
            } while (read_byte != -1);

            BigInteger number = new BigInteger(1, dis.getMessageDigest().digest());
            return number.toString(16);


        } finally {
            if (fis != null) fis.close();
            if (is != null) is.close();
            if (dis != null) dis.close();
        }
    }

    public static void main(String[] args) throws Exception {

    }
}
