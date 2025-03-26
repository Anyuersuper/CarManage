package com.carmanage.dao;

public class cmcar {
    private String carid;

    private Integer uid;

    private String kind;

    private String year;

    private String status;

    public String getCarid() {
        return carid;
    }

    public void setCarid(String carid) {
        this.carid = carid == null ? null : carid.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind == null ? null : kind.trim();
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year == null ? null : year.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }
}