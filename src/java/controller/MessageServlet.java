package controller;

import java.io.IOException;
import java.sql.SQLException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.MessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Message;

@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {

    private MessageDAO messageDAO = new MessageDAO();
    private Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Invalid user ID\"}");
            return;
        }
        response.setContentType("application/json");

        try {
            if ("listConversations".equals(action)) {
                response.getWriter().write(gson.toJson(messageDAO.getConversations(userId)));
            } else if ("getMessages".equals(action)) {
                int otherUserId = Integer.parseInt(request.getParameter("otherUserId"));
                response.getWriter().write(gson.toJson(messageDAO.getMessages(userId, otherUserId)));
            } else if ("markAsRead".equals(action)) {
                int otherUserId = Integer.parseInt(request.getParameter("otherUserId"));
                messageDAO.markAsRead(userId, otherUserId);
                int unreadCount = messageDAO.getUnreadCount(userId);
                request.getSession().setAttribute("unreadMessages", unreadCount);
                response.getWriter().write("{\"status\": \"OK\"}");
            } else if ("listUsers".equals(action)) {
                response.getWriter().write(gson.toJson(messageDAO.getUsers(userId)));
            } else {
                response.getWriter().write("{\"error\": \"Unknown action\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Database error: " + e.getMessage());
            response.getWriter().write(gson.toJson(errorJson));
        } catch (Exception ex) {
            Logger.getLogger(MessageServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            json.append(line);
        }

        // Đọc action từ JSON
        JsonObject jsonObject = gson.fromJson(json.toString(), JsonObject.class);
        String action = jsonObject.get("action").getAsString();

        if ("sendMessage".equals(action)) {
            Message message = gson.fromJson(json.toString(), Message.class);
            try {
                messageDAO.sendMessage(message);
                int unreadCount = messageDAO.getUnreadCount(message.getReceiverId());
                request.getSession().setAttribute("unreadMessages", unreadCount);
                response.setContentType("application/json");
                response.getWriter().write("{\"status\": \"Message sent\"}");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
            } catch (Exception ex) {
                Logger.getLogger(MessageServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Unknown action\"}");
        }
    }
}
