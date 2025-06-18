package model;

import java.util.Date;

public class User {

    private int userId; // đổi từ "id" cho đúng với DB
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String username;
    private String address;
    private String role;
    private String documentPath;
    private boolean isApproved;
    private Date createdAt;

    // Constructor mặc định
    public User() {}

    // Constructor với 7 tham số (không có documentPath)
    public User(String fullName, String email, String phone, String username, String password, String address, String role) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.address = address;
        this.role = role;
        this.isApproved = false;
    }

    // Constructor với 8 tham số (bao gồm documentPath)
    public User(String fullName, String email, String phone, String username, String password, String address, String role, String documentPath) {
        this(fullName, email, phone, username, password, address, role);
        this.documentPath = documentPath;
    }

    // Getters & Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getDocumentPath() {
        return documentPath;
    }

    public void setDocumentPath(String documentPath) {
        this.documentPath = documentPath;
    }

    public boolean isApproved() {
        return isApproved;
    }

    public void setApproved(boolean approved) {
        isApproved = approved;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
