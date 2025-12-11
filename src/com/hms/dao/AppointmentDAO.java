package com.hms.dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;
import com.hms.config.MongoDBConnection;
import com.hms.model.Appointment;
import com.hms.model.Patient;
import com.hms.model.Doctor;
import java.util.ArrayList;
import java.util.List;
import static com.mongodb.client.model.Filters.*;

public class AppointmentDAO {
    private MongoCollection<Document> collection;
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;
    
    public AppointmentDAO() {
        MongoDatabase database = MongoDBConnection.getDatabase();
        collection = database.getCollection("appointments");
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
    }
    
    public boolean bookAppointment(Appointment appointment) {
        try {
            Document doc = new Document("patientId", appointment.getPatientId())
                    .append("doctorId", appointment.getDoctorId())
                    .append("appointmentDate", appointment.getAppointmentDate())
                    .append("appointmentTime", appointment.getAppointmentTime())
                    .append("status", appointment.getStatus())
                    .append("symptoms", appointment.getSymptoms())
                    .append("diagnosis", appointment.getDiagnosis())
                    .append("prescription", appointment.getPrescription())
                    .append("createdAt", appointment.getCreatedAt());
            
            collection.insertOne(doc);
            appointment.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Appointment> getAppointmentsByPatient(String patientId) {
        List<Appointment> appointments = new ArrayList<>();
        try {
            for (Document doc : collection.find(eq("patientId", new ObjectId(patientId)))) {
                appointments.add(documentToAppointment(doc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appointments;
    }
    
    public List<Appointment> getAppointmentsByDoctor(String doctorId) {
        List<Appointment> appointments = new ArrayList<>();
        try {
            for (Document doc : collection.find(eq("doctorId", new ObjectId(doctorId)))) {
                appointments.add(documentToAppointment(doc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appointments;
    }
    
    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        try {
            for (Document doc : collection.find()) {
                appointments.add(documentToAppointment(doc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appointments;
    }
    
    public boolean updateAppointmentStatus(String appointmentId, String status) {
        try {
            Document update = new Document("$set", new Document("status", status));
            collection.updateOne(eq("_id", new ObjectId(appointmentId)), update);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateAppointmentRecord(Appointment appointment) {
        try {
            Document update = new Document("$set", new Document()
                    .append("diagnosis", appointment.getDiagnosis())
                    .append("prescription", appointment.getPrescription())
                    .append("status", appointment.getStatus()));
            
            collection.updateOne(eq("_id", appointment.getId()), update);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Appointment documentToAppointment(Document doc) {
        Appointment appointment = new Appointment();
        appointment.setId(doc.getObjectId("_id"));
        appointment.setPatientId(doc.getObjectId("patientId"));
        appointment.setDoctorId(doc.getObjectId("doctorId"));
        appointment.setAppointmentDate(doc.getDate("appointmentDate"));
        appointment.setAppointmentTime(doc.getString("appointmentTime"));
        appointment.setStatus(doc.getString("status"));
        appointment.setSymptoms(doc.getString("symptoms"));
        appointment.setDiagnosis(doc.getString("diagnosis"));
        appointment.setPrescription(doc.getString("prescription"));
        appointment.setCreatedAt(doc.getDate("createdAt"));
        
        // Fetch related data
        try {
            Patient patient = patientDAO.getPatientById(
                appointment.getPatientIdString());
            if (patient != null) {
                appointment.setPatientName(patient.getFullName());
            }
            
            Doctor doctor = doctorDAO.getDoctorById(
                appointment.getDoctorIdString());
            if (doctor != null) {
                appointment.setDoctorName(doctor.getFullName());
                appointment.setDoctorSpecialization(doctor.getSpecialization());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return appointment;
    }
}