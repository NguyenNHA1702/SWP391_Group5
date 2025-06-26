package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
import java.util.List;

public class UserManagementServlet extends HttpServlet {
    private final UserDAO userDAO = UserDAO.INSTANCE;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy tham số tìm kiếm và lọc
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        List<User> users = userDAO.getManageableUsers(search, status); // Cập nhật phương thức
        request.setAttribute("users", users);
        request.getRequestDispatcher("/Admin/userManagement.jsp").forward(request, response);
    }

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    int userId;
    try {
        userId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect(request.getContextPath() + "/userManagement");
        return;
    }

    Boolean isApproved = null;
    if ("activate".equals(action)) {
        isApproved = true;
    } else if ("deactivate".equals(action)) {
        isApproved = false;
    }

    if (isApproved != null) {
        userDAO.updateUserApproval(userId, isApproved);
    }

    String search = request.getParameter("search");
    String status = request.getParameter("status");
    List<User> updatedUsers = userDAO.getManageableUsers(search, status);
    request.setAttribute("users", updatedUsers);
    request.getRequestDispatcher("/Admin/userManagement.jsp").forward(request, response);
}
}