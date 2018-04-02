package com.xiaotianbaiproject.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ItemClass {
    /*id*/
    private Integer classId;
    public Integer getClassId(){
        return classId;
    }
    public void setClassId(Integer classId){
        this.classId = classId;
    }

    /*name*/
    @NotEmpty(message="name cannot be empty")
    private String className;
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }

    /*description*/
    @NotEmpty(message="description cannot be empty")
    private String classDesc;
    public String getClassDesc() {
        return classDesc;
    }
    public void setClassDesc(String classDesc) {
        this.classDesc = classDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonItemClass=new JSONObject(); 
		jsonItemClass.accumulate("classId", this.getClassId());
		jsonItemClass.accumulate("className", this.getClassName());
		jsonItemClass.accumulate("classDesc", this.getClassDesc());
		return jsonItemClass;
    }}