# 🌊 Ocean View Resort - Management System

A professional **Java EE** web application designed for the management of the **Ocean View Resort in Galle, Sri Lanka**. This system allows staff to manage guest reservations and provides admins with tools to manage personnel, room pricing, and real-time reporting.



---

## 🚀 Features

### **Staff Portal**
* **Reservation Management:** Add, update, and delete guest bookings.
* **Search Engine:** Real-time filtering of reservations by guest name or ID.
* **Automated Billing:** Instant calculation of total costs based on room type and stay duration.

### **Admin Dashboard**
* **Staff Control:** Register, modify, or remove staff accounts.
* **Dynamic Pricing:** Update room rates (Single, Double, Suite) in real-time.
* **PDF Reports:** Generate professional, print-ready reservation summaries with one click.

### **Security & UI**
* **Role-Based Access:** Separate dashboards for Admin and Staff roles.
* **Modern UI:** Responsive design using **CSS3**, **Inter Fonts**, and a tropical resort-themed login.
* **Session Management:** Secure login/logout functionality to protect guest data.

---

## 🛠️ Tech Stack

* **Backend:** Java Servlet API (Jakarta EE)
* **Frontend:** JSP (JavaServer Pages), CSS3, HTML5
* **Database:** MySQL 8.0
* **Server:** Apache Tomcat 10.1
* **IDE:** IntelliJ IDEA 2025.3
* **Version Control:** Git & GitHub



---

## 🗄️ Database Setup

1.  Open **MySQL Workbench**.
2.  Go to `File > Open SQL Script`.
3.  Select the `db/database_setup.sql` file from this project.
4.  Execute the script (⚡ icon) to create the `ocean_view_resort` schema and populate it with test data.



---

## ⚙️ Local Installation

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/Achinidissanayake20/OceanViewResort-Reservation-System.git](https://github.com/Achinidissanayake20/OceanViewResort-Reservation-System.git)
    ```
2.  **Configure Database Credentials:**
    Open `src/main/java/util/DBConnection.java` and update the `PASSWORD` variable to match your local MySQL password.
3.  **Run on Tomcat:**
    * Open the project in **IntelliJ IDEA**.
    * Configure a **Tomcat 10.1** Local Server.
    * Deploy the `ocean_view_reservation:war exploded` artifact.
    * Click **Run**.

---

## 🔑 Default Credentials

| Role | Username | Password |
| :--- | :--- | :--- |
| **Admin** | `admin` | `admin123` |
| **Staff** | `staff` | `staff123` |

---

## 📂 Project Structure

```text
src/main/
  ├── java/com/oceanview/controller/  # Servlets (Logic)
  ├── java/util/                      # DB Connection & Helpers
  └── webapp/                         # JSPs, CSS, and Images
db/                                   # MySQL Database Scripts