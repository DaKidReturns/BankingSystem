/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author rohit
 */

import javax.swing.JButton;

public class AccountButton extends JButton {
    public AccountButton( int accountNumber){
        //find account infromation from the database
        this.setText(""+accountNumber );
        this.setFont(new java.awt.Font("Fira Sans Semi-Light", 0, 15));
    }
    public AccountButton(){
        this.setText(""+0 );
        this.setFont(new java.awt.Font("Fira Sans Semi-Light", 0, 15));
    }
}
