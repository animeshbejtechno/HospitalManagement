package com.hms.dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;
import com.hms.config.MongoDBConnection;
import com.hms.model.User;
import static com.mongodb.client.model.Filters.*;

public class UserDAO {
    private MongoCollection<Document> collection;
    
    public UserDAO() {
        MongoDatabase database = MongoDBConnection.getDatabase();
        collection = database.getCollection("users");
    }
    
    public User validateUser(String username, String password) {
        Document doc = collection.find(and(eq("username", username), 
                                          eq("password", password))).first();
        
        if (doc != null) {
            return documentToUser(doc);
        }
        return null;
    }
    
    public boolean registerUser(User user) {
        try {
            Document doc = new Document("username", user.getUsername())
                    .append("password", user.getPassword())
                    .append("email", user.getEmail())
                    .append("role", user.getRole())
                    .append("fullName", user.getFullName());
            
            collection.insertOne(doc);
            user.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean usernameExists(String username) {
        return collection.countDocuments(eq("username", username)) > 0;
    }
    
    public User getUserById(String userId) {
        try {
            Document doc = collection.find(eq("_id", new ObjectId(userId))).first();
            return doc != null ? documentToUser(doc) : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    private User documentToUser(Document doc) {
        User user = new User();
        user.setId(doc.getObjectId("_id"));
        user.setUsername(doc.getString("username"));
        user.setPassword(doc.getString("password"));
        user.setEmail(doc.getString("email"));
        user.setRole(doc.getString("role"));
        user.setFullName(doc.getString("fullName"));
        return user;
    }
}