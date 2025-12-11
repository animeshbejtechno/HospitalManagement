<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hms.dao.*, com.hms.model.*, java.util.*" %>
<%
    if (session.getAttribute("user") == null || !"patient".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    String fullName = (String) session.getAttribute("fullName");
    String userId = (String) session.getAttribute("userId");
    
    PatientDAO patientDAO = new PatientDAO();
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    
    Patient patient = patientDAO.getPatientByUserId(userId);
    if (patient == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    List<Appointment> appointments = appointmentDAO.getAppointmentsByPatient(patient.getIdString());
    if (appointments == null) {
        appointments = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">HMS - Patient Portal</div>
        <div class="nav-menu">
            <a href="<%= request.getContextPath() %>/patient/dashboard.jsp" class="active">Dashboard</a>
            <a href="<%= request.getContextPath() %>/patient/book_appointment.jsp">Book Appointment</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h1>Welcome, <%= fullName %>!</h1>
        
        <div class="dashboard-grid">
            <div class="card">
                <h3>Patient Information</h3>
                <p><strong>Age:</strong> <%= patient.getAge() %></p>
                <p><strong>Gender:</strong> <%= patient.getGender() %></p>
                <p><strong>Blood Group:</strong> <%= patient.getBloodGroup() %></p>
                <p><strong>Phone:</strong> <%= patient.getPhone() %></p>
                <p><strong>Registration Date:</strong> <%= patient.getRegistrationDate() %></p>
            </div>
            
            <div class="card">
                <h3>Quick Actions</h3>
                <a href="<%= request.getContextPath() %>/patient/book_appointment.jsp" class="btn btn-primary">Book New Appointment</a>
            </div>
        </div>
        
        <div class="card">
            <h3>My Appointments</h3>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Doctor</th>
                        <th>Specialization</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (appointments.isEmpty()) { %>
                        <tr><td colspan="6">No appointments found</td></tr>
                    <% } else {
                        for (Appointment apt : appointments) { %>
                        <tr>
                            <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(apt.getAppointmentDate()) %></td>
                            <td><%= apt.getAppointmentTime() %></td>
                            <td><%= apt.getDoctorName() %></td>
                            <td><%= apt.getDoctorSpecialization() %></td>
                            <td><span class="badge <%= apt.getStatus().toLowerCase() %>">
                                <%= apt.getStatus() %></span></td>
                            <td>
                                <% if ("Scheduled".equals(apt.getStatus())) { %>
                                    <form action="../CancelAppointmentServlet" method="post" 
                                          style="display:inline;">
                                        <input type="hidden" name="appointmentId" 
                                               value="<%= apt.getIdString() %>">
                                        <button type="submit" class="btn btn-small btn-danger" 
                                                onclick="return confirm('Cancel this appointment?')">
                                            Cancel
                                        </button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
