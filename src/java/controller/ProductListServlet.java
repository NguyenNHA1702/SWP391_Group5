/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name="ProductListServlet", urlPatterns={"/productList"})
public class ProductListServlet extends HttpServlet {
   
       /**
     * Xử lý yêu cầu HTTP GET để hiển thị danh sách sản phẩm.
     * - Nhận tham số tìm kiếm theo tên sản phẩm và tiêu chí sắp xếp
     * - Lọc và sắp xếp danh sách sản phẩm theo yêu cầu
     * - Truyền danh sách sản phẩm vào request và chuyển tiếp đến trang productList.jsp
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         // Lấy tham số tìm kiếm tên sản phẩm từ URL
        String name = request.getParameter("name");
        if (name == null) {
            name = "";
        }
         // Lấy tham số sắp xếp sản phẩm
        String sort = request.getParameter("sort");
        if (sort == null) {
            sort = "";
        }
         // Lấy danh sách sản phẩm theo tên và tiêu chí sắp xếp
        List<Product> productList = ProductDAO.getProductsByNameSorted(name, sort);
        request.setAttribute("products", productList);
         // Chuyển tiếp đến trang danh sách sản phẩm (Buyer/productList.jsp)
        request.getRequestDispatcher("Buyer/productList.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
