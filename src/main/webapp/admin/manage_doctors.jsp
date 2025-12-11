<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hms.dao.*, com.hms.model.*, java.util.*" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    DoctorDAO doctorDAO = new DoctorDAO();
    List<Doctor> doctors = doctorDAO.getAllDoctors();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Doctors</title>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">HMS - Admin Portal</div>
        <div class="nav-menu">
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp">Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/manage_doctors.jsp" class="active">Doctors</a>
            <a href="<%= request.getContextPath() %>/admin/view_appointments.jsp">Appointments</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h2>Manage Doctors</h2>
        
        <% String successMessage = (String) request.getAttribute("successMessage");
           String errorMessage = (String) request.getAttribute("errorMessage");
           if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
            <script>
                setTimeout(function() {
                    location.reload();
                }, 2000);
            </script>
        <% } if (errorMessage != null) { %>
            <div class="alert alert-error"><%= errorMessage %></div>
        <% } %>
        
        <button onclick="openAddModal()" class="btn btn-primary">Add New Doctor</button>
        
        <div class="card">
            <h3>All Doctors</h3>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Specialization</th>
                        <th>Qualification</th>
                        <th>Experience</th>
                        <th>Phone</th>
                        <th>Fee</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (doctors.isEmpty()) { %>
                        <tr><td colspan="7">No doctors found</td></tr>
                    <% } else {
                        for (Doctor doctor : doctors) { %>
                        <tr>
                            <td><%= doctor.getFullName() %></td>
                            <td><%= doctor.getSpecialization() %></td>
                            <td><%= doctor.getQualification() %></td>
                            <td><%= doctor.getExperience() %> years</td>
                            <td><%= doctor.getPhone() %></td>
                            <td>₹<%= String.format("%.2f", doctor.getConsultationFee()) %></td>
                            <td>
                                <form action="../DeleteDoctorServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="doctorId" value="<%= doctor.getIdString() %>">
                                    <button type="submit" class="btn btn-small btn-danger" 
                                            onclick="return confirm('Delete this doctor?')">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Add Doctor Modal -->
    <div id="addDoctorModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Add New Doctor</h3>
            
            <form action="../AddDoctorServlet" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name:</label>
                        <input type="text" name="fullName" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Specialization:</label>
                        <input type="text" name="specialization" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Qualification:</label>
                        <input type="text" name="qualification" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Experience (years):</label>
                        <input type="number" name="experience" min="0" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Phone:</label>
                        <input type="tel" name="phone" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Consultation Fee:</label>
                    <input type="number" name="consultationFee" step="0.01" min="0" required>
                </div>
                
                <hr>
                <h4>Account Details</h4>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Username:</label>
                        <input type="text" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">Add Doctor</button>
            </form>
        </div>
    </div>
    
    <script>
        function openAddModal() {
            document.getElementById('addDoctorModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('addDoctorModal').style.display = 'none';
        }
        
        window.onclick = function(event) {
            var modal = document.getElementById('addDoctorModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>