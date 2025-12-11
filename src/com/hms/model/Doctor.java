package com.hms.model;

import org.bson.types.ObjectId;

public class Doctor {
    private ObjectId id;
    private ObjectId userId;
    private String fullName;
    private String specialization;
    private String qualification;
    private int experience;
    private String phone;
    private String email;
    private double consultationFee;
    
    public Doctor() {}
    
    // Getters and Setters
    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }
    
    public String getIdString() { return id != null ? id.toHexString() : null; }
    
    public ObjectId getUserId() { return userId; }
    public void setUserId(ObjectId userId) { this.userId = userId; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { 
        this.specialization = specialization; 
    }
    
    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { 
        this.qualification = qualification; 
    }
    
    public int getExperience() { return experience; }
    public void setExperience(int experience) { this.experience = experience; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public double getConsultationFee() { return consultationFee; }
    public void setConsultationFee(double consultationFee) { 
        this.consultationFee = consultationFee; 
    }
}