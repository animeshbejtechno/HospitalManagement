package com.hms.model;

import org.bson.types.ObjectId;
import java.util.Date;

public class Appointment {
    private ObjectId id;
    private ObjectId patientId;
    private ObjectId doctorId;
    private Date appointmentDate;
    private String appointmentTime;
    private String status; // Scheduled, Completed, Cancelled
    private String symptoms;
    private String diagnosis;
    private String prescription;
    private Date createdAt;
    
    // Additional fields for display
    private String patientName;
    private String doctorName;
    private String doctorSpecialization;
    
    public Appointment() {
        this.createdAt = new Date();
        this.status = "Scheduled";
    }
    
    // Getters and Setters
    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }
    
    public String getIdString() { return id != null ? id.toHexString() : null; }
    
    public ObjectId getPatientId() { return patientId; }
    public void setPatientId(ObjectId patientId) { this.patientId = patientId; }
    
    public String getPatientIdString() { 
        return patientId != null ? patientId.toHexString() : null; 
    }
    
    public ObjectId getDoctorId() { return doctorId; }
    public void setDoctorId(ObjectId doctorId) { this.doctorId = doctorId; }
    
    public String getDoctorIdString() { 
        return doctorId != null ? doctorId.toHexString() : null; 
    }
    
    public Date getAppointmentDate() { return appointmentDate; }
    public void setAppointmentDate(Date appointmentDate) { 
        this.appointmentDate = appointmentDate; 
    }
    
    public String getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(String appointmentTime) { 
        this.appointmentTime = appointmentTime; 
    }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getSymptoms() { return symptoms; }
    public void setSymptoms(String symptoms) { this.symptoms = symptoms; }
    
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    
    public String getPrescription() { return prescription; }
    public void setPrescription(String prescription) { 
        this.prescription = prescription; 
    }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
    
    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
    
    public String getDoctorSpecialization() { return doctorSpecialization; }
    public void setDoctorSpecialization(String doctorSpecialization) { 
        this.doctorSpecialization = doctorSpecialization; 
    }
}