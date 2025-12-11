# Hospital Management System

A complete **Java-based Hospital Management System** with role-based access control (Admin, Doctor, Patient) and cloud database integration using MongoDB Atlas.

## Features

✅ **Three-Role System**
- **Admin Portal**: Manage doctors, view appointments, system statistics
- **Doctor Portal**: View assigned appointments, update patient records
- **Patient Portal**: Book appointments, view medical history

✅ **Core Functionality**
- User authentication with session management
- Doctor management (add, update, delete)
- Appointment booking and cancellation
- Patient registration and profile management
- Real-time doctor availability
- Medical record updates

✅ **Technology Stack**
- **Backend**: Java Servlets (JDK 21)
- **Frontend**: JSP (Java Server Pages) with HTML5/CSS3
- **Web Server**: Apache Tomcat 9.0
- **Database**: MongoDB Atlas (Cloud)
- **Design Pattern**: MVC (Model-View-Controller)

## System Architecture

```
┌─────────────────────────────────────────────────┐
│         Tomcat Web Server (Port 8080)           │
│  ┌────────────────────────────────────────────┐ │
│  │          JSP Views Layer                   │ │
│  │  (index, login, register, dashboards)     │ │
│  └────────────────────────────────────────────┘ │
│  ┌────────────────────────────────────────────┐ │
│  │      Servlet Controller Layer              │ │
│  │  (LoginServlet, AddDoctorServlet, etc.)   │ │
│  └────────────────────────────────────────────┘ │
│  ┌────────────────────────────────────────────┐ │
│  │      DAO (Data Access Object) Layer        │ │
│  │  (UserDAO, DoctorDAO, PatientDAO, etc.)   │ │
│  └────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────┐
│      MongoDB Atlas Cloud Database               │
│  Collections:                                   │
│  - users (6 documents)                         │
│  - doctors (6 documents)                       │
│  - patients (1 document)                       │
│  - appointments (3 documents)                  │
└─────────────────────────────────────────────────┘
```

## Project Structure

```
HospitalManagement/
├── src/
│   ├── com/hms/
│   │   ├── config/          # Database configuration
│   │   │   └── MongoDBConnection.java
│   │   ├── dao/             # Data Access Objects
│   │   │   ├── UserDAO.java
│   │   │   ├── DoctorDAO.java
│   │   │   ├── PatientDAO.java
│   │   │   └── AppointmentDAO.java
│   │   ├── model/           # Data Models (POJOs)
│   │   │   ├── User.java
│   │   │   ├── Doctor.java
│   │   │   ├── Patient.java
│   │   │   └── Appointment.java
│   │   └── servlet/         # HTTP Request Handlers
│   │       ├── LoginServlet.java
│   │       ├── AddDoctorServlet.java
│   │       ├── BookAppointmentServlet.java
│   │       ├── DeleteDoctorServlet.java
│   │       ├── CancelAppointmentServlet.java
│   │       ├── RegisterPatientServlet.java
│   │       ├── UpdateRecordServlet.java
│   │       └── LogoutServlet.java
│   └── main/webapp/         # Web Resources
│       ├── css/
│       │   └── style.css    # Professional styling
│       ├── WEB-INF/
│       │   ├── web.xml      # Deployment descriptor
│       │   └── lib/         # Dependencies (MongoDB JARs)
│       ├── index.jsp        # Home page
│       ├── login.jsp        # Authentication
│       ├── register.jsp     # Patient registration
│       ├── admin/           # Admin Portal
│       │   ├── dashboard.jsp
│       │   ├── manage_doctors.jsp
│       │   └── view_appointments.jsp
│       ├── doctor/          # Doctor Portal
│       │   ├── dashboard.jsp
│       │   ├── view_appointments.jsp
│       │   └── update_record.jsp
│       └── patient/         # Patient Portal
│           ├── dashboard.jsp
│           └── book_appointment.jsp
├── build/                   # Compiled output
├── database/                # Database initialization scripts
├── .gitignore
├── .classpath
├── .project
└── DEPLOYMENT_GUIDE.md
```

## Setup & Installation

### Prerequisites
- Java Development Kit (JDK) 21 or higher
- Apache Tomcat 9.0+
- MongoDB Atlas Account (free tier available)
- Git

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/HospitalManagement.git
cd HospitalManagement
```

### Step 2: Configure MongoDB Atlas Connection
1. Create a MongoDB Atlas account at https://www.mongodb.com/cloud/atlas
2. Create a free cluster
3. Get your connection string
4. Update `src/com/hms/config/MongoDBConnection.java`:
   ```java
   String CONNECTION_STRING = "mongodb+srv://username:password@cluster.mongodb.net/hospital_db?retryWrites=true&w=majority";
   ```

### Step 3: Compile Java Code
```bash
cd /path/to/HospitalManagement
javac -d build/classes -cp "src/main/webapp/WEB-INF/lib/*:/opt/tomcat9/lib/*" \
  $(find src/com -name "*.java")
```

### Step 4: Create WAR File
```bash
jar -cvf HospitalManagement.war -C src/main/webapp . && \
jar -uvf HospitalManagement.war -C build/classes com
```

### Step 5: Deploy to Tomcat
```bash
cp HospitalManagement.war /path/to/tomcat/webapps/
/path/to/tomcat/bin/startup.sh
```

### Step 6: Access the Application
```
http://localhost:8080/HospitalManagement/
```

## Default Credentials

### Admin Portal
- **Username**: `admin`
- **Password**: `admin123`

### Doctor Portal
- **Username**: `dr.sarah` (or any doctor username)
- **Password**: `password123`

### Patient Portal
- **Username**: `animeshbej399`
- **Password**: `password123`

Or register a new patient account via the registration page.

## Database Collections

### Users Collection
```json
{
  "_id": ObjectId,
  "username": "string",
  "password": "string",
  "email": "string",
  "role": "admin|doctor|patient",
  "fullName": "string"
}
```

### Doctors Collection
```json
{
  "_id": ObjectId,
  "userId": ObjectId,
  "fullName": "string",
  "specialization": "string",
  "qualification": "string",
  "experience": number,
  "phone": "string",
  "email": "string",
  "consultationFee": number
}
```

### Patients Collection
```json
{
  "_id": ObjectId,
  "userId": ObjectId,
  "fullName": "string",
  "age": number,
  "gender": "string",
  "bloodGroup": "string",
  "phone": "string",
  "registrationDate": "string"
}
```

### Appointments Collection
```json
{
  "_id": ObjectId,
  "patientId": ObjectId,
  "doctorId": ObjectId,
  "appointmentDate": "string",
  "appointmentTime": "string",
  "status": "confirmed|completed|cancelled",
  "notes": "string"
}
```

## Key Features Explained

### Authentication & Authorization
- Session-based authentication
- Role-based access control
- Password protection
- Session timeout management

### Doctor Management
- Add/delete doctors (admin only)
- View all doctors with specialization
- Filter doctors by specialty
- Consultation fee display in INR (₹)

### Appointment System
- Real-time doctor availability
- Book appointments with date/time selection
- Cancel appointments
- View appointment history

### Responsive UI
- Gradient purple design
- Professional styling with CSS
- Mobile-friendly layout
- Modal dialogs for forms
- Data tables with delete actions

## API Endpoints (Servlets)

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/LoginServlet` | POST | User authentication |
| `/LogoutServlet` | GET | Session termination |
| `/RegisterPatientServlet` | POST | Patient registration |
| `/AddDoctorServlet` | POST | Add new doctor (admin) |
| `/DeleteDoctorServlet` | POST | Remove doctor (admin) |
| `/BookAppointmentServlet` | POST | Create appointment |
| `/CancelAppointmentServlet` | POST | Cancel appointment |
| `/UpdateRecordServlet` | POST | Update medical records |

## Troubleshooting

### Issue: "Username already exists" but doctors not showing
**Solution**: Clear browser cache or use hard refresh (Ctrl+Shift+R)

### Issue: 404 errors when navigating
**Solution**: Ensure context path is correct in JSP files. Should use `<%= request.getContextPath() %>`

### Issue: MongoDB connection fails
**Solution**: 
- Verify connection string in `MongoDBConnection.java`
- Check IP whitelist in MongoDB Atlas (allow all: 0.0.0.0/0)
- Ensure database and collections exist

### Issue: Consultation fee shows as null
**Solution**: Ensure all doctors have valid fee values (not null). Default is 0.0

## Performance Optimizations

- Cache-busting headers to prevent stale data
- Connection pooling with MongoDB driver
- Efficient DAO queries
- CSS and JS minification ready
- Lazy loading of lists

## Security Features

- Session-based authentication
- Password hashing ready (can be enhanced with BCrypt)
- SQL injection prevention (using parameterized queries)
- CSRF protection ready (add tokens for forms)
- Role-based access control

## Future Enhancements

- [ ] Email notifications for appointments
- [ ] SMS reminders
- [ ] Payment gateway integration
- [ ] PDF report generation for medical records
- [ ] Appointment history archiving
- [ ] Doctor availability scheduling
- [ ] Patient feedback/rating system
- [ ] Admin dashboard with analytics
- [ ] Multi-language support
- [ ] Two-factor authentication

## Dependencies

- MongoDB Java Driver 4.11.1
- Apache Tomcat 9.0+
- Servlet API 4.0+
- BSON Library 4.11.1

## License

This project is open source and available under the MIT License.

## Author

**Hospital Management System Development Team**

---

## Support & Contribution

For issues, questions, or contributions:
1. Open an issue on GitHub
2. Create a pull request with improvements
3. Email: dev@hospitalmanagement.com

## Deployment Checklist

- [ ] MongoDB Atlas cluster created
- [ ] Connection string configured
- [ ] Java code compiled successfully
- [ ] WAR file created
- [ ] Tomcat running on port 8080
- [ ] Application accessible at localhost:8080/HospitalManagement/
- [ ] All test credentials working
- [ ] Doctors visible in admin panel
- [ ] Doctor booking works in patient panel
- [ ] Appointments display correctly

---

**Version**: 1.0.0  
**Last Updated**: December 2025  
**Status**: Production Ready ✅
