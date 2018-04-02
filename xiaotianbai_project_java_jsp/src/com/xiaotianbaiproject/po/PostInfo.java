package com.xiaotianbaiproject.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class PostInfo {
    /*postid*/
    private Integer postInfoId;
    public Integer getPostInfoId(){
        return postInfoId;
    }
    public void setPostInfoId(Integer postInfoId){
        this.postInfoId = postInfoId;
    }

    /*post title*/
    @NotEmpty(message="post id cannot be empty")
    private String pTitle;
    public String getPTitle() {
        return pTitle;
    }
    public void setPTitle(String pTitle) {
        this.pTitle = pTitle;
    }

    /*post content*/
    @NotEmpty(message="post content cannot be empty")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*poster*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*post add time*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*hits*/
    @NotNull(message="must input hitnum")
    private Integer hitNum;
    public Integer getHitNum() {
        return hitNum;
    }
    public void setHitNum(Integer hitNum) {
        this.hitNum = hitNum;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPostInfo=new JSONObject(); 
		jsonPostInfo.accumulate("postInfoId", this.getPostInfoId());
		jsonPostInfo.accumulate("pTitle", this.getPTitle());
		jsonPostInfo.accumulate("content", this.getContent());
		jsonPostInfo.accumulate("userObj", this.getUserObj().getName());
		jsonPostInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonPostInfo.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		jsonPostInfo.accumulate("hitNum", this.getHitNum());
		return jsonPostInfo;
    }}