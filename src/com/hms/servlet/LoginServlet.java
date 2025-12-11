package com.hms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.hms.dao.UserDAO;
import com.hms.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDAO.validateUser(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getIdString());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("fullName", user.getFullName());
            
            // Redirect based on role
            String contextPath = request.getContextPath();
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect(contextPath + "/admin/dashboard.jsp");
                    break;
                case "doctor":
                    response.sendRedirect(contextPath + "/doctor/dashboard.jsp");
                    break;
                case "patient":
                    response.sendRedirect(contextPath + "/patient/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect(contextPath + "/index.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}