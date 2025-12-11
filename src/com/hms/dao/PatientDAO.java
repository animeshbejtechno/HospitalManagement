package com.hms.dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;
import com.hms.config.MongoDBConnection;
import com.hms.model.Patient;
import java.util.ArrayList;
import java.util.List;
import static com.mongodb.client.model.Filters.*;

public class PatientDAO {
    private MongoCollection<Document> collection;
    
    public PatientDAO() {
        MongoDatabase database = MongoDBConnection.getDatabase();
        collection = database.getCollection("patients");
    }
    
    public boolean addPatient(Patient patient) {
        try {
            Document doc = new Document("userId", patient.getUserId())
                    .append("fullName", patient.getFullName())
                    .append("age", patient.getAge())
                    .append("gender", patient.getGender())
                    .append("bloodGroup", patient.getBloodGroup())
                    .append("phone", patient.getPhone())
                    .append("address", patient.getAddress())
                    .append("registrationDate", patient.getRegistrationDate())
                    .append("medicalHistory", patient.getMedicalHistory());
            
            collection.insertOne(doc);
            patient.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Patient getPatientByUserId(String userId) {
        try {
            Document doc = collection.find(eq("userId", new ObjectId(userId))).first();
            return doc != null ? documentToPatient(doc) : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public Patient getPatientById(String patientId) {
        try {
            Document doc = collection.find(eq("_id", new ObjectId(patientId))).first();
            return doc != null ? documentToPatient(doc) : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        try {
            for (Document doc : collection.find()) {
                patients.add(documentToPatient(doc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return patients;
    }
    
    public boolean updatePatient(Patient patient) {
        try {
            Document update = new Document("$set", new Document()
                    .append("fullName", patient.getFullName())
                    .append("age", patient.getAge())
                    .append("gender", patient.getGender())
                    .append("bloodGroup", patient.getBloodGroup())
                    .append("phone", patient.getPhone())
                    .append("address", patient.getAddress())
                    .append("medicalHistory", patient.getMedicalHistory()));
            
            collection.updateOne(eq("_id", patient.getId()), update);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Patient documentToPatient(Document doc) {
        Patient patient = new Patient();
        patient.setId(doc.getObjectId("_id"));
        patient.setUserId(doc.getObjectId("userId"));
        patient.setFullName(doc.getString("fullName"));
        patient.setAge(doc.getInteger("age"));
        patient.setGender(doc.getString("gender"));
        patient.setBloodGroup(doc.getString("bloodGroup"));
        patient.setPhone(doc.getString("phone"));
        patient.setAddress(doc.getString("address"));
        patient.setRegistrationDate(doc.getDate("registrationDate"));
        patient.setMedicalHistory(doc.getString("medicalHistory"));
        return patient;
    }
}
