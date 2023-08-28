/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Context.MyDAO;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dinh Nguyen
 */
public class ReviewDAO extends MyDAO {
    
    public void insert(Review r) {
        xSql = "insert into Review (ProductID, [name], email, review, rating, postTime) values (?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, r.getPid());
            ps.setString(2, r.getName());
            ps.setString(3, r.getEmail());
            ps.setString(4, r.getReview());
            ps.setInt(5, r.getRating());
            Timestamp postTime = Timestamp.valueOf(r.getPostTime());
            ps.setTimestamp(6, postTime);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Review> getReviewByPid(int pid) {
        List<Review> t = new ArrayList<>();
        xSql = "select [name], email, review, rating, postTime from Review where productID = ? ORDER BY postTime desc";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            Review r;
            String name, email, review;
            int rating;
            Timestamp postTime;
            while (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
                review = rs.getString("review");
                rating = rs.getInt("rating");
                postTime = rs.getTimestamp("postTime");
                r = new Review(pid, name, email, review, rating, postTime.toLocalDateTime());
                t.add(r);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
}
