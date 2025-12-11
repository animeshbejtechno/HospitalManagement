package com.hms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.UserDAO;
import com.hms.dao.DoctorDAO;
import com.hms.model.User;
import com.hms.model.Doctor;

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private DoctorDAO doctorDAO = new DoctorDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String specialization = request.getParameter("specialization");
        String qualification = request.getParameter("qualification");
        int experience = Integer.parseInt(request.getParameter("experience"));
        String phone = request.getParameter("phone");
        double consultationFee = Double.parseDouble(request.getParameter("consultationFee"));
        
        // Check if username exists
        if (userDAO.usernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists");
            request.getRequestDispatcher("admin/manage_doctors.jsp")
                   .forward(request, response);
            return;
        }
        
        // Create user account
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setRole("doctor");
        user.setFullName(fullName);
        
        if (userDAO.registerUser(user)) {
            // Create doctor profile
            Doctor doctor = new Doctor();
            doctor.setUserId(user.getId());
            doctor.setFullName(fullName);
            doctor.setSpecialization(specialization);
            doctor.setQualification(qualification);
            doctor.setExperience(experience);
            doctor.setPhone(phone);
            doctor.setEmail(email);
            doctor.setConsultationFee(consultationFee);
            
            if (doctorDAO.addDoctor(doctor)) {
                request.setAttribute("successMessage", "Doctor added successfully!");
                request.getRequestDispatcher("admin/manage_doctors.jsp")
                       .forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Error creating doctor profile");
                request.getRequestDispatcher("admin/manage_doctors.jsp")
                       .forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Error creating user account");
            request.getRequestDispatcher("admin/manage_doctors.jsp")
                   .forward(request, response);
        }
    }
}