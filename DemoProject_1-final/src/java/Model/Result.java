/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


/**
 *
 * @author win
 */
public class Result {
    String colum, table;
    String value;   

    public Result(String colum, String table, String value) {
        this.colum = colum;
        this.table = table;
        this.value = value;
    }

    public String getColum() {
        return colum;
    }

    public void setColoum(String colum) {
        this.colum = colum;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Result() {
    }

   
   
}
