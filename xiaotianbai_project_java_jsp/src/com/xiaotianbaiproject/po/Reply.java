package com.xiaotianbaiproject.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Reply {
    /*replyid*/
    private Integer replyId;
    public Integer getReplyId(){
        return replyId;
    }
    public void setReplyId(Integer replyId){
        this.replyId = replyId;
    }

    /*original post*/
    private PostInfo postInfoObj;
    public PostInfo getPostInfoObj() {
        return postInfoObj;
    }
    public void setPostInfoObj(PostInfo postInfoObj) {
        this.postInfoObj = postInfoObj;
    }

    /*reply content*/
    @NotEmpty(message="content cannot be empty")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*Replier*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*ReplyTime*/
    private String replyTime;
    public String getReplyTime() {
        return replyTime;
    }
    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonReply=new JSONObject(); 
		jsonReply.accumulate("replyId", this.getReplyId());
		jsonReply.accumulate("postInfoObj", this.getPostInfoObj().getPTitle());
		jsonReply.accumulate("postInfoObjPri", this.getPostInfoObj().getPostInfoId());
		jsonReply.accumulate("content", this.getContent());
		jsonReply.accumulate("userObj", this.getUserObj().getName());
		jsonReply.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonReply.accumulate("replyTime", this.getReplyTime().length()>19?this.getReplyTime().substring(0,19):this.getReplyTime());
		return jsonReply;
    }}