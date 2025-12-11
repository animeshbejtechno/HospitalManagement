<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hms.dao.*, com.hms.model.*, java.util.*" %>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    String fullName = (String) session.getAttribute("fullName");
    
    PatientDAO patientDAO = new PatientDAO();
    DoctorDAO doctorDAO = new DoctorDAO();
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    
    int totalPatients = (patientDAO.getAllPatients() != null) ? patientDAO.getAllPatients().size() : 0;
    int totalDoctors = (doctorDAO.getAllDoctors() != null) ? doctorDAO.getAllDoctors().size() : 0;
    int totalAppointments = (appointmentDAO.getAllAppointments() != null) ? appointmentDAO.getAllAppointments().size() : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">HMS - Admin Portal</div>
        <div class="nav-menu">
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="active">Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/manage_doctors.jsp">Doctors</a>
            <a href="<%= request.getContextPath() %>/admin/view_appointments.jsp">Appointments</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h1>Admin Dashboard</h1>
        <p>Welcome, <%= fullName %></p>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Patients</h3>
                <p class="stat-number"><%= totalPatients %></p>
            </div>
            
            <div class="stat-card">
                <h3>Total Doctors</h3>
                <p class="stat-number"><%= totalDoctors %></p>
            </div>
            
            <div class="stat-card">
                <h3>Total Appointments</h3>
                <p class="stat-number"><%= totalAppointments %></p>
            </div>
        </div>
        
        <div class="dashboard-grid">
            <div class="card">
                <h3>Quick Actions</h3>
                <a href="<%= request.getContextPath() %>/admin/manage_doctors.jsp" class="btn btn-primary">Manage Doctors</a>
                <a href="view_appointments.jsp" class="btn btn-secondary">View Appointments</a>
            </div>
            
            <div class="card">
                <h3>System Information</h3>
                <p><strong>Database:</strong> MongoDB</p>
                <p><strong>Status:</strong> Active</p>
            </div>
        </div>
    </div>
</body>
</html>
