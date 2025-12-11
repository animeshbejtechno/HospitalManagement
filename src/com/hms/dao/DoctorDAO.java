package com.hms.dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;
import com.hms.config.MongoDBConnection;
import com.hms.model.Doctor;
import java.util.ArrayList;
import java.util.List;
import static com.mongodb.client.model.Filters.*;

public class DoctorDAO {
    private MongoCollection<Document> collection;
    
    public DoctorDAO() {
        MongoDatabase database = MongoDBConnection.getDatabase();
        collection = database.getCollection("doctors");
    }
    
    public boolean addDoctor(Doctor doctor) {
        try {
            Document doc = new Document("userId", doctor.getUserId())
                    .append("fullName", doctor.getFullName())
                    .append("specialization", doctor.getSpecialization())
                    .append("qualification", doctor.getQualification())
                    .append("experience", doctor.getExperience())
                    .append("phone", doctor.getPhone())
                    .append("email", doctor.getEmail())
                    .append("consultationFee", doctor.getConsultationFee());
            
            collection.insertOne(doc);
            doctor.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        try {
            for (Document doc : collection.find()) {
                doctors.add(documentToDoctor(doc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return doctors;
    }
    
    public Doctor getDoctorById(String doctorId) {
        try {
            Document doc = collection.find(eq("_id", new ObjectId(doctorId))).first();
            return doc != null ? documentToDoctor(doc) : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public Doctor getDoctorByUserId(String userId) {
        try {
            Document doc = collection.find(eq("userId", new ObjectId(userId))).first();
            return doc != null ? documentToDoctor(doc) : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public List<Doctor> getDoctorsBySpecialization(String specialization) {
        List<Doctor> doctors = new ArrayList<>();
        try {
            for (Document doc : collection.find(eq("specialization", specialization))) {
                doctors.add(documentToDoctor(doc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return doctors;
    }
    
    public boolean deleteDoctor(String doctorId) {
        try {
            collection.deleteOne(eq("_id", new ObjectId(doctorId)));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Doctor documentToDoctor(Document doc) {
        Doctor doctor = new Doctor();
        doctor.setId(doc.getObjectId("_id"));
        doctor.setUserId(doc.getObjectId("userId"));
        doctor.setFullName(doc.getString("fullName"));
        doctor.setSpecialization(doc.getString("specialization"));
        doctor.setQualification(doc.getString("qualification"));
        doctor.setExperience(doc.getInteger("experience"));
        doctor.setPhone(doc.getString("phone"));
        doctor.setEmail(doc.getString("email"));
        // Handle both Integer and Double for consultationFee, default to 0.0 if null
        Object feeObj = doc.get("consultationFee");
        if (feeObj instanceof Integer) {
            doctor.setConsultationFee(((Integer) feeObj).doubleValue());
        } else if (feeObj instanceof Double) {
            doctor.setConsultationFee((Double) feeObj);
        } else {
            doctor.setConsultationFee(0.0); // Default if null
        }
        return doctor;
    }
}
