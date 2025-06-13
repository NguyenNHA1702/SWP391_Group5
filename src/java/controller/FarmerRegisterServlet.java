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
        String address = request.getParameter("address");
        String role = "farmer"; // Role mặc định là farmer

        // Kiểm tra trùng lặp
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

        // Tạo thư mục uploads/verifications nếu chưa tồn tại
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            if (!uploadDir.mkdirs()) {
                LOGGER.log(Level.SEVERE, "Failed to create directory: {0}", uploadPath);
                request.setAttribute("error", "Failed to create upload directory.");
                request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
                return;
            }
        }

        // Xử lý file tải lên
        Part filePart = request.getPart("verificationDocs");
        if (filePart == null || filePart.getSize() == 0) {
            LOGGER.log(Level.WARNING, "No file uploaded or file is empty.");
            request.setAttribute("error", "Please upload a verification document.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            LOGGER.log(Level.WARNING, "Uploaded file name is null or empty.");
            request.setAttribute("error", "Invalid file name.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Lưu file tạm thời với username
        String tempFilePath = uploadPath + File.separator + username + "_" + fileName;
        try {
            filePart.write(tempFilePath);
            LOGGER.log(Level.INFO, "File saved temporarily at: {0}", tempFilePath);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to save file: " + tempFilePath, e);
            request.setAttribute("error", "Failed to save uploaded file.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
            return;
        }

        // Đăng ký người dùng với document_path tạm thời
        String documentPath = UPLOAD_DIR + "/" + username + "_" + fileName;
        User newUser = new User(fullName, email, phone, username, password, address, role, documentPath);
        boolean userSuccess = UserDAO.INSTANCE.register(newUser);

        if (userSuccess) {
            // Lấy user_id
            int userId = UserDAO.INSTANCE.getUserIdByUsername(username);
            if (userId == -1) {
                LOGGER.log(Level.SEVERE, "Failed to retrieve user ID for username: {0}", username);
                request.setAttribute("error", "Failed to retrieve user ID.");
                request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
                return;
            }

            // Đổi tên file thành userId_filename
            String finalFilePath = uploadPath + File.separator + userId + "_" + fileName;
            File oldFile = new File(tempFilePath);
            File newFile = new File(finalFilePath);
            String finalDocumentPath = UPLOAD_DIR + "/" + userId + "_" + fileName;

            if (oldFile.renameTo(newFile)) {
                LOGGER.log(Level.INFO, "File renamed from {0} to {1}", new Object[]{tempFilePath, finalFilePath});
                // Cập nhật document_path với userId
                if (updateDocumentPath(userId, finalDocumentPath)) {
                    LOGGER.log(Level.INFO, "Document path updated for userId {0}: {1}", new Object[]{userId, finalDocumentPath});
                } else {
                    LOGGER.log(Level.WARNING, "Failed to update document path for userId: {0}", userId);
                }
            } else {
                LOGGER.log(Level.WARNING, "Failed to rename file from {0} to {1}", new Object[]{tempFilePath, finalFilePath});
                // Vẫn tiếp tục với document_path tạm thời nếu đổi tên thất bại
            }

            request.setAttribute("ms1", "Farmer account successfully created! Awaiting verification.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            LOGGER.log(Level.SEVERE, "Failed to register user: {0}", username);
            request.setAttribute("error", "Failed to create farmer account. Please try again later.");
            request.getRequestDispatcher("farmerSignUp.jsp").forward(request, response);
        }
    }

    private boolean updateDocumentPath(int userId, String documentPath) {
        String sql = "UPDATE users SET document_path = ? WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, documentPath);
            ps.setInt(2, userId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating document path for userId " + userId, e);
            return false;
        }
    }
}