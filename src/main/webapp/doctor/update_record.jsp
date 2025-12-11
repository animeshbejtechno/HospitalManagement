<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hms.model.Appointment" %>
<%@ page import="com.hms.dao.AppointmentDAO" %>

<%
    if (session == null || session.getAttribute("userId") == null || !"doctor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    String userId = (String) session.getAttribute("userId");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Patient Record - Hospital Management</title>
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
            max-width: 1000px;
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
        
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-btn:hover {
            background: #764ba2;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
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
        
        .appointment-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            display: none;
        }
        
        .appointment-form.active {
            display: block;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 600;
        }
        
        input[type="text"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: inherit;
        }
        
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .btn-update {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }
        
        .btn-update:hover {
            background: #218838;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        
        .btn-edit {
            background: #17a2b8;
            color: white;
            padding: 5px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.9em;
        }
        
        .btn-edit:hover {
            background: #138496;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📝 Update Patient Records</h1>
        <a href="dashboard.jsp" class="back-btn">← Back to Dashboard</a>
        
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
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Appointment apt : appointments) { %>
                <tr>
                    <td><%= apt.getPatientName() != null ? apt.getPatientName() : "N/A" %></td>
                    <td><%= apt.getAppointmentDate() != null ? apt.getAppointmentDate() : "N/A" %></td>
                    <td><%= apt.getAppointmentTime() != null ? apt.getAppointmentTime() : "N/A" %></td>
                    <td><%= apt.getStatus() %></td>
                    <td>
                        <button class="btn-edit" onclick="toggleForm('<%= apt.getIdString() %>')">Edit</button>
                    </td>
                </tr>
                <tr id="form-<%= apt.getIdString() %>" style="display:none;">
                    <td colspan="5">
                        <div class="appointment-form">
                            <form action="../UpdateRecordServlet" method="POST">
                                <input type="hidden" name="appointmentId" value="<%= apt.getIdString() %>">
                                
                                <div class="form-group">
                                    <label>Diagnosis</label>
                                    <textarea name="diagnosis" required><%= apt.getDiagnosis() != null ? apt.getDiagnosis() : "" %></textarea>
                                </div>
                                
                                <div class="form-group">
                                    <label>Prescription</label>
                                    <textarea name="prescription" required><%= apt.getPrescription() != null ? apt.getPrescription() : "" %></textarea>
                                </div>
                                
                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" required>
                                        <option value="Scheduled" <%= "Scheduled".equals(apt.getStatus()) ? "selected" : "" %>>Scheduled</option>
                                        <option value="Completed" <%= "Completed".equals(apt.getStatus()) ? "selected" : "" %>>Completed</option>
                                        <option value="Cancelled" <%= "Cancelled".equals(apt.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="btn-update">Save Changes</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <%
                } else {
        %>
        <div class="no-data">
            <p>No appointments to update.</p>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("<div class='no-data'>Error loading appointments: " + e.getMessage() + "</div>");
            }
        %>
    </div>
    
    <script>
        function toggleForm(appointmentId) {
            const formRow = document.getElementById('form-' + appointmentId);
            if (formRow.style.display === 'none') {
                formRow.style.display = 'table-row';
            } else {
                formRow.style.display = 'none';
            }
        }
    </script>
</body>
</html>
