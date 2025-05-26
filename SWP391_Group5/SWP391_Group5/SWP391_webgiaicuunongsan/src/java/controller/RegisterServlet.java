package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");

        String fullName = request.getParameter("name").trim();
        String email = request.getParameter("email").trim().toLowerCase();  // ✨ chuẩn hóa email
        String password = request.getParameter("password").trim();
        String phone = request.getParameter("phone").trim();

        String role = "consumer";  // mặc định

        // ✨ Kiểm tra email đã tồn tại
        if (UserDAO.isEmailExist(email)) {
            response.getWriter().print("exists");
            return;
        }

        // ✨ Nếu muốn mã hóa mật khẩu: password = BCrypt.hashpw(password, BCrypt.gensalt());

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone);
        newUser.setRole(role);

        boolean success = UserDAO.register(newUser);

        if (success) {
            response.getWriter().print("success");
        } else {
            response.getWriter().print("fail");
        }
    }
}
