package com.xiaotianbaiproject.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Item {
    /*itemid*/
    private Integer itemId;
    public Integer getItemId(){
        return itemId;
    }
    public void setItemId(Integer itemId){
        this.itemId = itemId;
    }

    /*itemclass*/
    private ItemClass itemClassObj;
    public ItemClass getItemClassObj() {
        return itemClassObj;
    }
    public void setItemClassObj(ItemClass itemClassObj) {
        this.itemClassObj = itemClassObj;
    }

    /*itemtitle*/
    @NotEmpty(message="item title cannot be empty")
    private String pTitle;
    public String getPTitle() {
        return pTitle;
    }
    public void setPTitle(String pTitle) {
        this.pTitle = pTitle;
    }

    /*item photo*/
    private String itemPhoto;
    public String getItemPhoto() {
        return itemPhoto;
    }
    public void setItemPhoto(String itemPhoto) {
        this.itemPhoto = itemPhoto;
    }

    /*item description*/
    @NotEmpty(message="item description cannot be empty")
    private String itemDesc;
    public String getItemDesc() {
        return itemDesc;
    }
    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    /*user*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*start price*/
    @NotNull(message="start price cannot be empty")
    private Float startPrice;
    public Float getStartPrice() {
        return startPrice;
    }
    public void setStartPrice(Float startPrice) {
        this.startPrice = startPrice;
    }

    /*start time*/
    private String startTime;
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /*end time*/
    private String endTime;
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonItem=new JSONObject(); 
		jsonItem.accumulate("itemId", this.getItemId());
		jsonItem.accumulate("itemClassObj", this.getItemClassObj().getClassName());
		jsonItem.accumulate("itemClassObjPri", this.getItemClassObj().getClassId());
		jsonItem.accumulate("pTitle", this.getPTitle());
		jsonItem.accumulate("itemPhoto", this.getItemPhoto());
		jsonItem.accumulate("itemDesc", this.getItemDesc());
		jsonItem.accumulate("userObj", this.getUserObj().getName());
		jsonItem.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonItem.accumulate("startPrice", this.getStartPrice());
		jsonItem.accumulate("startTime", this.getStartTime().length()>19?this.getStartTime().substring(0,19):this.getStartTime());
		jsonItem.accumulate("endTime", this.getEndTime().length()>19?this.getEndTime().substring(0,19):this.getEndTime());
		return jsonItem;
    }}