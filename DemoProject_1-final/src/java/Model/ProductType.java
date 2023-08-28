package Model;

import java.sql.Date;

/**
 *
 * @author win
 */
public class ProductType {
    int pid, sid, quantity;
    String pname, color, ram, cpu,harddriver, screen, describe;

    public ProductType() {
    }

    public ProductType(int pid, int sid, int quantity, String pname, String color, String ram, String cpu, String harddriver, String screen, String describe) {
        this.pid = pid;
        this.sid = sid;
        this.quantity = quantity;
        this.pname = pname;
        this.color = color;
        this.ram = ram;
        this.cpu = cpu;
        this.harddriver = harddriver;
        this.screen = screen;
        this.describe = describe;
    }

    public ProductType(int pid, String pname, String color) {
        this.pid = pid;
        this.pname = pname;
        this.color = color;
    }

    public ProductType(int pid, String pname, String color, String ram, String cpu, String harddriver, String screen) {
        this.pid = pid;
        this.pname = pname;
        this.color = color;
        this.ram = ram;
        this.cpu = cpu;
        this.harddriver = harddriver;
        this.screen = screen;
    }

    public ProductType(int sid, String pname, String color, String ram, String cpu, String harddriver, String screen, String describe) {
        this.sid = sid;
        this.pname = pname;
        this.color = color;
        this.ram = ram;
        this.cpu = cpu;
        this.harddriver = harddriver;
        this.screen = screen;
        this.describe = describe;
    }

    public ProductType(int pid, String pname) {
        this.pid = pid;
        this.pname = pname;
    }

    public ProductType(int pid, int sid, String pname, String color, String ram, String cpu, String harddriver, String screen, String describe) {
        this.pid = pid;
        this.sid = sid;
        this.pname = pname;
        this.color = color;
        this.ram = ram;
        this.cpu = cpu;
        this.harddriver = harddriver;
        this.screen = screen;
        this.describe = describe;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getHarddriver() {
        return harddriver;
    }

    public void setHarddriver(String harddriver) {
        this.harddriver = harddriver;
    }

    public String getScreen() {
        return screen;
    }

    public void setScreen(String screen) {
        this.screen = screen;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }
   
}
