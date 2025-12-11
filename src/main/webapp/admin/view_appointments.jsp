<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hms.model.Appointment" %>
<%@ page import="com.hms.dao.AppointmentDAO" %>

<%
    if (session == null || session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Appointments - Hospital Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .header-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .btn {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
        }
        
        .btn:hover {
            background: #764ba2;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        
        th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        tr:hover {
            background: #f5f5f5;
        }
        
        .status {
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: 600;
        }
        
        .status-scheduled {
            background: #cfe4ff;
            color: #0050b3;
        }
        
        .status-completed {
            background: #d1e7d6;
            color: #0a5e0f;
        }
        
        .status-cancelled {
            background: #ffd6d6;
            color: #b70e0e;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📅 All Appointments</h1>
        
        <div class="header-controls">
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="btn">← Back to Dashboard</a>
            <button onclick="location.reload()" class="btn">🔄 Refresh</button>
        </div>
        
        <%
            try {
                AppointmentDAO appointmentDAO = new AppointmentDAO();
                List<Appointment> appointments = appointmentDAO.getAllAppointments();
                
                if (appointments != null && !appointments.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Doctor Name</th>
                    <th>Specialization</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Appointment apt : appointments) { %>
                <tr>
                    <td><%= apt.getPatientName() != null ? apt.getPatientName() : "N/A" %></td>
                    <td><%= apt.getDoctorName() != null ? apt.getDoctorName() : "N/A" %></td>
                    <td><%= apt.getDoctorSpecialization() != null ? apt.getDoctorSpecialization() : "N/A" %></td>
                    <td><%= apt.getAppointmentDate() != null ? apt.getAppointmentDate() : "N/A" %></td>
                    <td><%= apt.getAppointmentTime() != null ? apt.getAppointmentTime() : "N/A" %></td>
                    <td>
                        <span class="status status-<%= apt.getStatus().toLowerCase() %>">
                            <%= apt.getStatus() %>
                        </span>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
                } else {
        %>
        <div class="no-data">
            <p>No appointments found.</p>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("<div class='no-data'>Error loading appointments: " + e.getMessage() + "</div>");
            }
        %>
    </div>
</body>
</html>
