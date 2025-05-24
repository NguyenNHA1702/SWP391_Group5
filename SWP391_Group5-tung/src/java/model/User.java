package model;

import java.util.Date;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String role;
    private boolean isApproved;
    private Date createdAt;
    private String username;
    private String address;

    // ✅ Constructor dùng trong RegisterServlet
    public User(String fullName, String email, String phone, String username, String password, String address, String role) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.address = address;
        this.role = role;                  // ✅ lấy từ form chọn
        this.isApproved = false;
        this.createdAt = new Date();
    }

    public User() {
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isApproved() {
        return isApproved;
    }

    public void setApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
