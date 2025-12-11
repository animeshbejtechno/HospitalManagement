<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hms.dao.*, com.hms.model.*, java.util.*" %>
<%
    if (session.getAttribute("user") == null || !"doctor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    String fullName = (String) session.getAttribute("fullName");
    String userId = (String) session.getAttribute("userId");
    
    DoctorDAO doctorDAO = new DoctorDAO();
    Doctor doctor = doctorDAO.getDoctorByUserId(userId);
    if (doctor == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">HMS - Doctor Portal</div>
        <div class="nav-menu">
            <a href="<%= request.getContextPath() %>/doctor/dashboard.jsp" class="active">Dashboard</a>
            <a href="<%= request.getContextPath() %>/doctor/view_appointments.jsp">Appointments</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h1>Welcome, Dr. <%= fullName %>!</h1>
        
        <div class="dashboard-grid">
            <div class="card">
                <h3>Doctor Information</h3>
                <p><strong>Specialization:</strong> <%= doctor.getSpecialization() %></p>
                <p><strong>Qualification:</strong> <%= doctor.getQualification() %></p>
                <p><strong>Experience:</strong> <%= doctor.getExperience() %> years</p>
                <p><strong>Consultation Fee:</strong> ₹<%= String.format("%.2f", doctor.getConsultationFee()) %></p>
            </div>
            
            <div class="card">
                <h3>Quick Actions</h3>
                <a href="<%= request.getContextPath() %>/doctor/view_appointments.jsp" class="btn btn-primary">View Appointments</a>
            </div>
        </div>
    </div>
</body>
</html>
