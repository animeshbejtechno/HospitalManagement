package com.hms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.DoctorDAO;

@WebServlet("/DeleteDoctorServlet")
public class DeleteDoctorServlet extends HttpServlet {
    private DoctorDAO doctorDAO = new DoctorDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String doctorId = request.getParameter("doctorId");
        
        if (doctorDAO.deleteDoctor(doctorId)) {
            request.setAttribute("successMessage", "Doctor deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete doctor");
        }
        
        response.sendRedirect("admin/manage_doctors.jsp");
    }
}