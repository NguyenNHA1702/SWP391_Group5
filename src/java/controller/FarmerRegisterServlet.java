package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.User;
import utils.DBUtil;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FarmerRegisterServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/verifications";
    private static final Logger LOGGER = Logger.getLogger(FarmerRegisterServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String role = "farmer";

        if (UserDAO.INSTANCE.isUsernameExist(username)) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        } else if (UserDAO.INSTANCE.isEmailExist(email)) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        } else if (UserDAO.INSTANCE.isPhoneExist(phone)) {
            request.setAttribute("error", "Phone number already exists!");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Tạo thư mục lưu file nếu chưa có
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            LOGGER.log(Level.SEVERE, "Failed to create directory: {0}", uploadPath);
            request.setAttribute("error", "Failed to create upload directory.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Lấy file từ form
        Part filePart = request.getPart("verificationDocs");
        if (filePart == null || filePart.getSize() == 0) {
            LOGGER.warning("No file uploaded or file is empty.");
            request.setAttribute("error", "Please upload a verification document.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            request.setAttribute("error", "Invalid file name.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // ✅ Chỉ cho phép các định dạng file hợp lệ
        String lowerFile = fileName.toLowerCase();
        if (!(lowerFile.endsWith(".pdf") || lowerFile.endsWith(".jpg") || lowerFile.endsWith(".jpeg")
                || lowerFile.endsWith(".png") || lowerFile.endsWith(".docx") || lowerFile.endsWith(".zip"))) {
            request.setAttribute("error", "Only files with .pdf, .jpg, .png, .jpeg, .docx, .zip are allowed.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Ghi file tạm thời: username_filename.ext
        String tempFileName = username + "_" + fileName;
        String tempFilePath = uploadPath + File.separator + tempFileName;

        try {
            filePart.write(tempFilePath);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to save uploaded file: " + tempFilePath, e);
            request.setAttribute("error", "Failed to save uploaded file.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Đăng ký user
        String documentPath = UPLOAD_DIR + "/" + tempFileName;
        User newUser = new User(fullName, email, phone, username, password, role, documentPath);
        boolean registered = UserDAO.INSTANCE.register(newUser);

        if (!registered) {
            LOGGER.severe("Failed to register user.");
            request.setAttribute("error", "Failed to create farmer account.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Lấy lại user_id để đổi tên file
        int userId = UserDAO.INSTANCE.getUserIdByUsername(username);
        if (userId == -1) {
            LOGGER.warning("Failed to get userId after registration.");
            request.setAttribute("error", "Registration error.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        String finalFileName = userId + "_" + fileName;
        String finalFilePath = uploadPath + File.separator + finalFileName;
        File oldFile = new File(tempFilePath);
        File newFile = new File(finalFilePath);

        String finalDocumentPath = UPLOAD_DIR + "/" + finalFileName;

        if (oldFile.renameTo(newFile)) {
            updateDocumentPath(userId, finalDocumentPath);
        }

        request.setAttribute("ms1", "Farmer account successfully created! Awaiting admin verification.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    private boolean updateDocumentPath(int userId, String documentPath) {
        String sql = "UPDATE users SET document_path = ? WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, documentPath);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating document path for userId " + userId, e);
            return false;
        }
    }
}
