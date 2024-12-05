package model;

import java.sql.Timestamp;

public class KeyPairModel {
    private int id;
    private int customerId;
    private String publicKey;
    private String status; // "active" hoặc "revoked"
    private Timestamp createdAt;
    private Timestamp revokedAt;

    public KeyPairModel(){}

    public KeyPairModel(int id, int customerId, String publicKey, String status, Timestamp createdAt, Timestamp revokedAt) {
        this.id = id;
        this.customerId = customerId;
        this.publicKey = publicKey;
        this.status = status;
        this.createdAt = createdAt;
        this.revokedAt = revokedAt;
    }

    public KeyPairModel( int customerId, String publicKey, String status) {
        this.customerId = customerId;
        this.publicKey = publicKey;
        this.status = status;
        this.createdAt = createdAt;
        this.revokedAt = revokedAt;
    }

    // Getters và setters
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getRevokedAt() {
        return revokedAt;
    }

    public void setRevokedAt(Timestamp revokedAt) {
        this.revokedAt = revokedAt;
    }
}
