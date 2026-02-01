import java.util.Scanner;

public class Authentication {

    // Predefined credentials (can be replaced with database values)
    private static final String USERNAME = "admin";
    private static final String PASSWORD = "admin123";

    public static boolean login() {
        Scanner sc = new Scanner(System.in);
        int attempts = 3;

        while (attempts > 0) {
            System.out.print("Enter Username: ");
            String username = sc.nextLine();

            System.out.print("Enter Password: ");
            String password = sc.nextLine();

            if (username.equals(USERNAME) && password.equals(PASSWORD)) {
                System.out.println("Login successful. Welcome to Ocean View Resort System!");
                return true;
            } else {
                attempts--;
                System.out.println("Invalid username or password.");
                System.out.println("Attempts remaining: " + attempts);
            }
        }

        System.out.println("Too many failed attempts. Access denied.");
        return false;
    }
}