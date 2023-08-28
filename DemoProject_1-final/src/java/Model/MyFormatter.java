/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.text.NumberFormat;
import java.util.Locale;

/**
 *
 * @author Dinh Nguyen
 */
public class MyFormatter {

    public MyFormatter() {
    }
    
    public String formatPrice(float price) {
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String formattedPrice = nf.format(price);
        return formattedPrice;
    }
    
}
