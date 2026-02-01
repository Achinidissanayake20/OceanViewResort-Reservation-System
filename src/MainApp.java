import javax.swing.text.View;
import java.util.Scanner;
import java.sql.Connection;

public class MainApp {

    public static void main(String[] args) {

        // Step 1: Test database connection
        System.out.println("Testing database connection...");
        Connection con = DBConnection.getConnection();
        if (con == null) {
            System.out.println("Cannot connect to the database. Exiting system.");
            return;
        }

        // Step 2: User Authentication
        if (!Authentication.login()) {
            System.out.println("System closed.");
            return;
        }

        Scanner sc = new Scanner(System.in);
        int choice;

        do {
            System.out.println("\n===== Ocean View Resort Reservation System =====");
            System.out.println("1. Add New Reservation");
            System.out.println("2. View Reservation Details");
            System.out.println("3. Calculate & Print Bill");
            System.out.println("4. Edit Reservation");
            System.out.println("5. Help Section");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");

            // Input validation
            while (!sc.hasNextInt()) {
                System.out.print("Invalid input. Enter a number: ");
                sc.next();
            }

            choice = sc.nextInt();
            sc.nextLine(); // clear input buffer

            switch (choice) {
                case 1:
                    AddReservation.addNewReservation();
                    break;
                case 2:
                    ViewReservation.showReservationDetails(); // new option
                    break;
                case 3:
                    System.out.print("Enter Reservation Number: ");
                    String reservationNo = sc.nextLine();
                    CalculateBill.calculateBill(reservationNo);
                    break;
                case 4:
                    EditReservation.editReservation();
                    break;
                case 5:
                    HelpSection.showHelp();
                    break;
                case 6:
                    ExitSystem.exitApplication();
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }

        } while (choice != 3);

        sc.close();
    }
}