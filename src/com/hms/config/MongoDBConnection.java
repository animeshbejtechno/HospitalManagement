package com.hms.config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class MongoDBConnection {
    private static MongoClient mongoClient;
    private static MongoDatabase database;
    
    private static final String CONNECTION_STRING = "mongodb+srv://animeshbej399_db_user:1319TxZW3670pdBx@cluster0.79zanv4.mongodb.net/?retryWrites=true&w=majority";
    private static final String DATABASE_NAME = "hospital_db";
    
    static {
        try {
            mongoClient = MongoClients.create(CONNECTION_STRING);
            database = mongoClient.getDatabase(DATABASE_NAME);
            System.out.println("MongoDB Connected Successfully!");
        } catch (Exception e) {
            System.err.println("MongoDB Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static MongoDatabase getDatabase() {
        return database;
    }
    
    public static void close() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
