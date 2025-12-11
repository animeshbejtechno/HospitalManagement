package com.hms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.UserDAO;
import com.hms.dao.PatientDAO;
import com.hms.model.User;
import com.hms.model.Patient;

@WebServlet("/RegisterPatientServlet")
public class RegisterPatientServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private PatientDAO patientDAO = new PatientDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String bloodGroup = request.getParameter("bloodGroup");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Check if username exists
        if (userDAO.usernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create user account
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setRole("patient");
        user.setFullName(fullName);
        
        if (userDAO.registerUser(user)) {
            // Create patient profile
            Patient patient = new Patient();
            patient.setUserId(user.getId());
            patient.setFullName(fullName);
            patient.setAge(age);
            patient.setGender(gender);
            patient.setBloodGroup(bloodGroup);
            patient.setPhone(phone);
            patient.setAddress(address);
            
            if (patientDAO.addPatient(patient)) {
                request.setAttribute("successMessage", 
                    "Registration successful! Please login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", 
                    "Error creating patient profile");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Registration failed");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}