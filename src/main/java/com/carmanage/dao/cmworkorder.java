package com.carmanage.dao;

import java.util.Date;

public class cmworkorder {
    private String workorderid;

    private Integer uid;

    private Integer cmuid;

    private String carid;

    private Date starttime;

    private Date finishedtime;

    private String status;

    public String getWorkorderid() {
        return workorderid;
    }

    public void setWorkorderid(String workorderid) {
        this.workorderid = workorderid == null ? null : workorderid.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCmuid() {
        return cmuid;
    }

    public void setCmuid(Integer cmuid) {
        this.cmuid = cmuid;
    }

    public String getCarid() {
        return carid;
    }

    public void setCarid(String carid) {
        this.carid = carid == null ? null : carid.trim();
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Date getFinishedtime() {
        return finishedtime;
    }

    public void setFinishedtime(Date finishedtime) {
        this.finishedtime = finishedtime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }
}