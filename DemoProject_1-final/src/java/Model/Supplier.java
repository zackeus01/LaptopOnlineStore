/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author win
 */
public class Supplier {
    private int sid;
    private String sname, note;

    public Supplier() {
    }

    public Supplier(int sid, String sname, String note) {
        this.sid = sid;
        this.sname = sname;
        this.note = note;
    }

    public Supplier(int sid, String sname) {
        this.sid = sid;
        this.sname = sname;
    }

   
    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
}
