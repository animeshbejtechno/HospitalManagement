package com.hms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.AppointmentDAO;

@WebServlet("/CancelAppointmentServlet")
public class CancelAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String appointmentId = request.getParameter("appointmentId");
        String role = (String) session.getAttribute("role");
        
        if (appointmentDAO.updateAppointmentStatus(appointmentId, "Cancelled")) {
            request.setAttribute("successMessage", "Appointment cancelled successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to cancel appointment");
        }
        
        if ("patient".equals(role)) {
            response.sendRedirect("patient/dashboard.jsp");
        } else if ("admin".equals(role)) {
            response.sendRedirect("admin/view_appointments.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}
