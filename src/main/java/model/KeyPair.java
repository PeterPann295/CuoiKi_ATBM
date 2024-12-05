package model;

import java.sql.Timestamp;

public class KeyPair {
    private int id;
    private Customer customer;
    private String publicKey;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public KeyPair() {}

    public KeyPair(int id, Customer customer, String publicKey, String status) {}

    public KeyPair(Customer customer, String publicKey, String status) {
        this.customer = customer;
        this.publicKey = publicKey;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
