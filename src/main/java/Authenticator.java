import static Auth.Authentication.getAptoToken;

public class Authenticator{
    public static String token;

    public static void main(String[] args) {
        token = getAptoToken();
        System.out.println(token);
    }
}
