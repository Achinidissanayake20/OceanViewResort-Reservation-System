public class ExitSystem {

    public static void exitApplication() {
        System.out.println("\nClosing Ocean View Resort Reservation System...");

        // Close DB connection safely
        DBConnection.closeConnection();

        System.out.println("System exited safely. Goodbye!");
        System.exit(0);
    }
}