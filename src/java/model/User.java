package model;

import java.util.Date;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password; // password_hash
    private String phone;
    private String role;
    private boolean isApproved;
    private Date createdAt;

    // ✅ Constructor thêm để sử dụng trong RegisterServlet
    public User(String fullName, String email, String phone, String username, String password, String address) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.address = address;
        this.role = "consumer";      // Mặc định role
        this.isApproved = false;     // Mặc định chưa duyệt
        this.createdAt = new Date(); // Ngày tạo mặc định là hiện tại
    }

    // ✳️ Bạn cần thêm 2 trường bên dưới để khớp constructor trên
    private String username;
    private String address;

    public User() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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

    // Getters & Setters gốc
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
}
