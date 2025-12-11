# Hospital Management System - Deployment Guide

## Prerequisites
- Java 21 JDK installed
- Tomcat 9.0.100 installed at `/opt/tomcat9`
- MongoDB 4.11.1 running on `localhost:27017`

## Pre-Deployment Checklist

### 1. Verify Java Compilation
✅ All 17 Java files compile successfully with ZERO errors

### 2. Project Structure
✅ 17 Source files (config, dao, model, servlet packages)
✅ 11 JSP pages (admin, doctor, patient portals)
✅ 2 CSS stylesheets (responsive design)
✅ 3 MongoDB driver libraries
✅ web.xml deployment descriptor configured

### 3. Database Setup
Run MongoDB initialization script:
```bash
cd /home/ani/eclipse-workspace/HospitalManagement
mongo database/init_mongodb.js
# or for MongoDB 5.0+
mongosh database/init_mongodb.js
```

### 4. Build WAR File
```bash
cd /home/ani/eclipse-workspace/HospitalManagement
jar -cvf HospitalManagement.war -C src/main/webapp .
jar -uvf HospitalManagement.war -C build/classes com
```

### 5. Deploy to Tomcat
```bash
cp HospitalManagement.war /opt/tomcat9/webapps/
```

### 6. Start Tomcat
```bash
/opt/tomcat9/bin/startup.sh
```

### 7. Access Application
- **Home:** http://localhost:8080/HospitalManagement
- **Login Page:** http://localhost:8080/HospitalManagement/login.jsp
- **Register:** http://localhost:8080/HospitalManagement/register.jsp

## Default Test Credentials
(After running init_mongodb.js)
- Admin: admin / admin123
- Doctor: doctor1 / pass123
- Patient: patient1 / pass123

## Troubleshooting

### MongoDB Connection Issues
- Ensure MongoDB is running: `mongosh` or `mongo`
- Check connection: `mongo mongodb://localhost:27017`
- Verify collections created: `db.getCollectionNames()`

### Servlet Mapping Issues
- Check web.xml is deployed correctly
- All servlets have @WebServlet annotations
- Mapping paths: /LoginServlet, /RegisterPatientServlet, etc.

### JSP File Not Found
- Verify JSP files copied to build output
- Check path: src/main/webapp/*.jsp

## Verification Commands

```bash
# Verify Java compilation
cd /home/ani/eclipse-workspace/HospitalManagement
javac -cp ".:src/main/webapp/WEB-INF/lib/*:/opt/tomcat9/lib/servlet-api.jar" \
  src/com/hms/**/*.java -d build/classes

# Count compiled classes
find build/classes/com/hms -name "*.class" | wc -l

# Check WAR contents
jar -tf HospitalManagement.war | grep -E "\.(class|jsp|css|xml)$"
```

## System Architecture
- **Frontend:** JSP with HTML5/CSS3 (3 portals: Admin, Doctor, Patient)
- **Backend:** Java Servlets with DAO pattern
- **Database:** MongoDB with BSON documents
- **Container:** Tomcat 9.0.100

## Features Implemented
✅ User Authentication (3 roles: Admin, Doctor, Patient)
✅ Patient Management (registration, profile, medical history)
✅ Doctor Management (add, delete, list by specialization)
✅ Appointment System (book, view, cancel, update)
✅ Session Management (login/logout, security)
✅ Responsive UI (mobile-friendly design)
✅ Error Handling (null checks, validation)

---
**Status: READY FOR DEPLOYMENT** 🚀
