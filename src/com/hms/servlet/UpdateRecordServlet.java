package com.hms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.AppointmentDAO;
import com.hms.model.Appointment;
import org.bson.types.ObjectId;

@WebServlet("/UpdateRecordServlet")
public class UpdateRecordServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in as doctor
        HttpSession session = request.getSession(false);
        if (session == null || !"doctor".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            String appointmentId = request.getParameter("appointmentId");
            String diagnosis = request.getParameter("diagnosis");
            String prescription = request.getParameter("prescription");
            String status = request.getParameter("status");
            
            Appointment appointment = new Appointment();
            appointment.setId(new ObjectId(appointmentId));
            appointment.setDiagnosis(diagnosis);
            appointment.setPrescription(prescription);
            appointment.setStatus(status);
            
            if (appointmentDAO.updateAppointmentRecord(appointment)) {
                request.setAttribute("successMessage", "Record updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update record");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        response.sendRedirect("doctor/view_appointments.jsp");
    }
}