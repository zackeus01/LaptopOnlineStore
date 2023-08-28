/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;
/**
 *
 * @author Dinh Nguyen
 */
public class Review {
    
    private int pid;
    private String name;
    private String email;
    private String review;
    private int rating;
    private LocalDateTime postTime;

    public Review() {
    }

    public Review(int pid, String name, String email, String review, int rating, LocalDateTime postTime) {
        this.pid = pid;
        this.name = name;
        this.email = email;
        this.review = review;
        this.rating = rating;
        this.postTime = postTime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public LocalDateTime getPostTime() {
        return postTime;
    }

    public void setPostTime(LocalDateTime postTime) {
        this.postTime = postTime;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }
    
    
}
