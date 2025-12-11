 hospital_db;

// Create collections
db.createCollection("users");
db.createCollection("patients");
db.createCollection("doctors");
db.createCollection("appointments");

// Create indexes
db.users.createIndex({ "username": 1 }, { unique: true });
db.users.createIndex({ "email": 1 });
db.patients.createIndex({ "userId": 1 });
db.doctors.createIndex({ "userId": 1 });
db.doctors.createIndex({ "specialization": 1 });
db.appointments.createIndex({ "patientId": 1 });
db.appointments.createIndex({ "doctorId": 1 });
db.appointments.createIndex({ "appointmentDate": 1 });

// Insert default admin
db.users.insertOne({
    username: "admin",
    password: "admin123",
    email: "admin@hospital.com",
    role: "admin",
    fullName: "System Administrator"
});

// Insert sample doctor users
var doctorUsers = [
    {
        username: "dr.sarah",
        password: "doctor123",
        email: "sarah@hospital.com",
        role: "doctor",
        fullName: "Dr. Sarah Johnson"
    },
    {
        username: "dr.michael",
        password: "doctor123",
        email: "michael@hospital.com",
        role: "doctor",
        fullName: "Dr. Michael Chen"
    },
    {
        username: "dr.emily",
        password: "doctor123",
        email: "emily@hospital.com",
        role: "doctor",
        fullName: "Dr. Emily Davis"
    }
];

var insertResult = db.users.insertMany(doctorUsers);
var doctorUserIds = Object.values(insertResult.insertedIds);

// Insert doctor profiles
db.doctors.insertMany([
    {
        userId: doctorUserIds[0],
        fullName: "Dr. Sarah Johnson",
        specialization: "Cardiology",
        qualification: "MD, FACC",
        experience: 20,
        phone: "555-0101",
        email: "sarah@hospital.com",
        consultationFee: 150.00
    },
    {
        userId: doctorUserIds[1],
        fullName: "Dr. Michael Chen",
        specialization: "Neurology",
        qualification: "MD, PhD",
        experience: 15,
        phone: "555-0102",
        email: "michael@hospital.com",
        consultationFee: 180.00
    },
    {
        userId: doctorUserIds[2],
        fullName: "Dr. Emily Davis",
        specialization: "Pediatrics",
        qualification: "MD, FAAP",
        experience: 12,
        phone: "555-0103",
        email: "emily@hospital.com",
        consultationFee: 120.00
    }
]);

print("MongoDB Hospital Database Initialized Successfully!");
