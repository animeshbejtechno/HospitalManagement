<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hms.dao.*, com.hms.model.*, java.util.*" %>
<%
    if (session.getAttribute("user") == null || !"patient".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    DoctorDAO doctorDAO = new DoctorDAO();
    List<Doctor> doctors = doctorDAO.getAllDoctors();
    if (doctors == null) {
        doctors = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Appointment</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">HMS - Patient Portal</div>
        <div class="nav-menu">
            <a href="<%= request.getContextPath() %>/patient/dashboard.jsp">Dashboard</a>
            <a href="<%= request.getContextPath() %>/patient/book_appointment.jsp" class="active">Book Appointment</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h2>Book Appointment</h2>
        
        <% String successMessage = (String) request.getAttribute("successMessage");
           String errorMessage = (String) request.getAttribute("errorMessage");
           if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } if (errorMessage != null) { %>
            <div class="alert alert-error"><%= errorMessage %></div>
        <% } %>
        
        <div class="card">
            <h3>Available Doctors</h3>
            <% if (doctors == null || doctors.isEmpty()) { %>
                <div class="alert alert-info">No doctors available at the moment. Please try again later.</div>
            <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Doctor Name</th>
                        <th>Specialization</th>
                        <th>Qualification</th>
                        <th>Experience</th>
                        <th>Fee</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Doctor doctor : doctors) { %>
                    <tr>
                        <td><%= doctor.getFullName() %></td>
                        <td><%= doctor.getSpecialization() %></td>
                        <td><%= doctor.getQualification() %></td>
                        <td><%= doctor.getExperience() %> years</td>
                        <td>₹<%= String.format("%.2f", doctor.getConsultationFee()) %></td>
                        <td>
                            <button onclick="openBookingModal('<%= doctor.getIdString() %>', 
                                    '<%= doctor.getFullName() %>')" 
                                    class="btn btn-small btn-primary">
                                Book
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </div>
    
    <!-- Booking Modal -->
    <div id="bookingModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Book Appointment</h3>
            <p id="doctorName"></p>
            
            <form action="../BookAppointmentServlet" method="post">
                <input type="hidden" id="doctorId" name="doctorId">
                
                <div class="form-group">
                    <label>Appointment Date:</label>
                    <input type="date" name="appointmentDate" 
                           min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" 
                           required>
                </div>
                
                <div class="form-group">
                    <label>Appointment Time:</label>
                    <input type="time" name="appointmentTime" required>
                </div>
                
                <div class="form-group">
                    <label>Symptoms:</label>
                    <textarea name="symptoms" rows="4" required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Confirm Booking</button>
            </form>
        </div>
    </div>
    
    <script>
        function openBookingModal(doctorId, doctorName) {
            document.getElementById('bookingModal').style.display = 'block';
            document.getElementById('doctorId').value = doctorId;
            document.getElementById('doctorName').textContent = 'Doctor: ' + doctorName;
        }
        
        function closeModal() {
            document.getElementById('bookingModal').style.display = 'none';
        }
        
        window.onclick = function(event) {
            var modal = document.getElementById('bookingModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>