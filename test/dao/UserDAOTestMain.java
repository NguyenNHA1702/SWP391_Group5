package dao;

import model.User;
import java.util.List;

public class UserDAOTestMain {
    public static void main(String[] args) {
        try {
            int currentUserId = 1; // thay đổi ID nếu cần

            System.out.println("Danh sách tất cả user (trừ userID=" + currentUserId + "):");
            List<User> allUsers = UserDAO.INSTANCE.getAllUsersExcept(currentUserId);
            for (User u : allUsers) {
                System.out.println(u.getUsername() + " - " + u.getFullName());
            }

            System.out.println("\nTìm user chứa từ 'admin':");
            List<User> foundUsers = UserDAO.INSTANCE.searchUsersExcept(currentUserId, "admin");
            for (User u : foundUsers) {
                System.out.println(u.getUsername() + " - " + u.getFullName());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
