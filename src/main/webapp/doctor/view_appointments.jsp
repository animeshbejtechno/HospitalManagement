<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hms.dao.*, com.hms.model.*, java.util.*" %>
<%
    if (session.getAttribute("user") == null || !"doctor".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    String userId = (String) session.getAttribute("userId");
    DoctorDAO doctorDAO = new DoctorDAO();
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    
    Doctor doctor = doctorDAO.getDoctorByUserId(userId);
    if (doctor == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    List<Appointment> appointments = appointmentDAO.getAppointmentsByDoctor(doctor.getIdString());
    if (appointments == null) {
        appointments = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Appointments</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">HMS - Doctor Portal</div>
        <div class="nav-menu">
            <a href="<%= request.getContextPath() %>/doctor/dashboard.jsp">Dashboard</a>
            <a href="<%= request.getContextPath() %>/doctor/view_appointments.jsp" class="active">Appointments</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h2>My Appointments</h2>
        
        <div class="card">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Patient</th>
                        <th>Symptoms</th>
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
                            <td><%= apt.getPatientName() %></td>
                            <td><%= apt.getSymptoms() %></td>
                            <td><span class="badge <%= apt.getStatus().toLowerCase() %>">
                                <%= apt.getStatus() %></span></td>
                            <td>
                                <% if ("Scheduled".equals(apt.getStatus())) { %>
                                    <button onclick="openUpdateModal('<%= apt.getIdString() %>')" 
                                            class="btn btn-small btn-primary">
                                        Update
                                    </button>
                                <% } %>
                            </td>
                        </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Update Modal -->
    <div id="updateModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Update Appointment Record</h3>
            
            <form action="../UpdateRecordServlet" method="post">
                <input type="hidden" id="appointmentId" name="appointmentId">
                
                <div class="form-group">
                    <label>Diagnosis:</label>
                    <textarea name="diagnosis" rows="3" required></textarea>
                </div>
                
                <div class="form-group">
                    <label>Prescription:</label>
                    <textarea name="prescription" rows="4" required></textarea>
                </div>
                
                <div class="form-group">
                    <label>Status:</label>
                    <select name="status" required>
                        <option value="Completed">Completed</option>
                        <option value="Scheduled">Keep Scheduled</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Record</button>
            </form>
        </div>
    </div>
    
    <script>
        function openUpdateModal(appointmentId) {
            document.getElementById('updateModal').style.display = 'block';
            document.getElementById('appointmentId').value = appointmentId;
        }
        
        function closeModal() {
            document.getElementById('updateModal').style.display = 'none';
        }
        
        window.onclick = function(event) {
            var modal = document.getElementById('updateModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>
