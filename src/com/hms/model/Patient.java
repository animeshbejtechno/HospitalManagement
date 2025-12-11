package com.hms.model;

import org.bson.types.ObjectId;
import java.util.Date;

public class Patient {
    private ObjectId id;
    private ObjectId userId;
    private String fullName;
    private int age;
    private String gender;
    private String bloodGroup;
    private String phone;
    private String address;
    private Date registrationDate;
    private String medicalHistory;
    
    public Patient() {
        this.registrationDate = new Date();
    }
    
    // Getters and Setters
    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }
    
    public String getIdString() { return id != null ? id.toHexString() : null; }
    
    public ObjectId getUserId() { return userId; }
    public void setUserId(ObjectId userId) { this.userId = userId; }
    
    public String getUserIdString() { return userId != null ? userId.toHexString() : null; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    
    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public Date getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Date registrationDate) { 
        this.registrationDate = registrationDate; 
    }
    
    public String getMedicalHistory() { return medicalHistory; }
    public void setMedicalHistory(String medicalHistory) { 
        this.medicalHistory = medicalHistory; 
    }
}