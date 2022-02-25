/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author rohit
 */
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
public class Main {
    public static Connection conn;
    public static LoginPage loginPage;
    public static UserPage userPage;
    public static AccountPage accountPage;
    public static BankerPage bankerPage;
    
    public static void main(String args[]) {
        initDatabase();
        userPage = null;
        accountPage = null;
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
                } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | UnsupportedLookAndFeelException ex  ) {
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                }
                loginPage = new LoginPage();
                loginPage.setVisible(true);
            }
        });
    }
    
    public static void initDatabase(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }
        catch(Exception e){
            e.printStackTrace();
        }
        String MySQLURL = "jdbc:mysql://localhost:3306/BANK";
        String databseUserName = "rohit";
        String databasePassword = "Admin@123";
        ResultSet rs ;
        conn = null;
        try {
            conn = DriverManager.getConnection(MySQLURL, databseUserName, databasePassword);
            if (conn != null) {
                System.out.println("Database connection is successful !!!!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try{
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("Select * from LOGINTAB");
            while(rs.next()){
                System.out.println(rs.getString("USERNAME")+" "+rs.getString("PASSWORD")+" "+ rs.getString("USERTYPE"));
            }
            
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
