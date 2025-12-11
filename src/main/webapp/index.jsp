<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hospital Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            padding: 40px;
            max-width: 600px;
            text-align: center;
        }
        
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 2.5em;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 40px;
            font-size: 1.1em;
        }
        
        .button-group {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 15px 40px;
            font-size: 1.1em;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: transform 0.3s, box-shadow 0.3s;
            font-weight: 600;
            display: inline-block;
        }
        
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-register {
            background: #28a745;
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .features {
            margin-top: 50px;
            text-align: left;
        }
        
        .features h3 {
            color: #333;
            margin-bottom: 20px;
        }
        
        .features ul {
            list-style: none;
            color: #666;
        }
        
        .features li {
            padding: 10px;
            margin: 5px 0;
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏥 Hospital Management System</h1>
        <p class="subtitle">Professional Healthcare Management Platform</p>
        
        <div class="button-group">
            <a href="login.jsp" class="btn btn-login">Login</a>
            <a href="register.jsp" class="btn btn-register">Register as Patient</a>
        </div>
        
        <div class="features">
            <h3>✨ Key Features</h3>
            <ul>
                <li>👨‍⚕️ Manage Doctor Profiles & Specializations</li>
                <li>📋 Book & Track Medical Appointments</li>
                <li>👥 Patient Registration & Medical History</li>
                <li>📊 Appointment Status Management</li>
                <li>🔐 Secure Role-Based Access Control</li>
                <li>💾 MongoDB Database Integration</li>
            </ul>
        </div>
    </div>
</body>
</html>
