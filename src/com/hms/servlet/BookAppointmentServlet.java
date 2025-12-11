package com.hms.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.AppointmentDAO;
import com.hms.dao.PatientDAO;
import com.hms.model.Appointment;
import com.hms.model.Patient;
import org.bson.types.ObjectId;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private PatientDAO patientDAO = new PatientDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in as patient
        HttpSession session = request.getSession(false);
        if (session == null || !"patient".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String userId = (String) session.getAttribute("userId");
        Patient patient = patientDAO.getPatientByUserId(userId);
        
        if (patient == null) {
            request.setAttribute("errorMessage", "Patient profile not found");
            request.getRequestDispatcher("patient/book_appointment.jsp")
                   .forward(request, response);
            return;
        }
        
        try {
            String doctorId = request.getParameter("doctorId");
            String appointmentDate = request.getParameter("appointmentDate");
            String appointmentTime = request.getParameter("appointmentTime");
            String symptoms = request.getParameter("symptoms");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(appointmentDate);
            
            Appointment appointment = new Appointment();
            appointment.setPatientId(patient.getId());
            appointment.setDoctorId(new ObjectId(doctorId));
            appointment.setAppointmentDate(date);
            appointment.setAppointmentTime(appointmentTime);
            appointment.setSymptoms(symptoms);
            
            if (appointmentDAO.bookAppointment(appointment)) {
                request.setAttribute("successMessage", 
                    "Appointment booked successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to book appointment");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("patient/book_appointment.jsp")
               .forward(request, response);
    }
}