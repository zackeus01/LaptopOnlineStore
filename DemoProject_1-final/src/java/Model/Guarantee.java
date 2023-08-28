/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author win
 */
public class Guarantee {

    int accounID, productID, evaluate, GuaranteeID;
    int Progress;
    Date ReceivedDate, DeliveryDate;
    String seri, comment, describe, personguarantee, fullname, address, phone, email, pimg;
    float expense;
    public Guarantee() {
    }

    public Guarantee(int accounID, int productID, int Progress, Date ReceivedDate, Date DeliveryDate, String seri, String describe, String personguarantee, String fullname, String address, String phone, String email, String pimg, float expense) {
        this.accounID = accounID;
        this.productID = productID;
        this.Progress = Progress;
        this.ReceivedDate = ReceivedDate;
        this.DeliveryDate = DeliveryDate;
        this.seri = seri;
        this.describe = describe;
        this.personguarantee = personguarantee;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.pimg = pimg;
        this.expense = expense;
    }

   

    public int getAccounID() {
        return accounID;
    }

    public void setAccounID(int accounID) {
        this.accounID = accounID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(int evaluate) {
        this.evaluate = evaluate;
    }

    public int getGuaranteeID() {
        return GuaranteeID;
    }

    public void setGuaranteeID(int GuaranteeID) {
        this.GuaranteeID = GuaranteeID;
    }

    public int getProgress() {
        return Progress;
    }

    public void setProgress(int Progress) {
        this.Progress = Progress;
    }

    public Date getReceivedDate() {
        return ReceivedDate;
    }

    public void setReceivedDate(Date ReceivedDate) {
        this.ReceivedDate = ReceivedDate;
    }

    public Date getDeliveryDate() {
        return DeliveryDate;
    }

    public void setDeliveryDate(Date DeliveryDate) {
        this.DeliveryDate = DeliveryDate;
    }

    public String getSeri() {
        return seri;
    }

    public void setSeri(String seri) {
        this.seri = seri;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getPersonguarantee() {
        return personguarantee;
    }

    public void setPersonguarantee(String personguarantee) {
        this.personguarantee = personguarantee;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public float getExpense() {
        return expense;
    }

    public void setExpense(float expense) {
        this.expense = expense;
    }

    public String getPimg() {
        return pimg;
    }

    public void setPimg(String pimg) {
        this.pimg = pimg;
    }
    
}
