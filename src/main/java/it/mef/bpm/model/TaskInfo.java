package it.mef.bpm.model;

public class TaskInfo {
    private long id;
    private String processId;
    private long dateOfIssue;

    public TaskInfo(){

    }

    public TaskInfo setId(long taskId){
        this.id = taskId;
        return this;
    }

    public TaskInfo setProcessId(String processId){
        this.processId = processId;
        return this;
    }

    public TaskInfo setdateOfIssue(long dateOfIssue){
        this.dateOfIssue = dateOfIssue;
        return this;
    }

    public long getDateOfIssue() {
        return dateOfIssue;
    }

    public long getId() {
        return id;
    }

    public String getProcessId() {
        return processId;
    }

}
