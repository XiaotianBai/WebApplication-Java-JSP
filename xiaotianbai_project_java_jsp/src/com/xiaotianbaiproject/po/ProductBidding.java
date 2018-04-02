package com.xiaotianbaiproject.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ProductBidding {
    /*bidding id*/
    private Integer biddingId;
    public Integer getBiddingId(){
        return biddingId;
    }
    public void setBiddingId(Integer biddingId){
        this.biddingId = biddingId;
    }

    /*item*/
    private Item itemObj;
    public Item getItemObj() {
        return itemObj;
    }
    public void setItemObj(Item itemObj) {
        this.itemObj = itemObj;
    }

    /*user*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*bidding time*/
    private String biddingTime;
    public String getBiddingTime() {
        return biddingTime;
    }
    public void setBiddingTime(String biddingTime) {
        this.biddingTime = biddingTime;
    }

    /*bidding price*/
    @NotNull(message="bidding price cannot be empty")
    private Float biddingPrice;
    public Float getBiddingPrice() {
        return biddingPrice;
    }
    public void setBiddingPrice(Float biddingPrice) {
        this.biddingPrice = biddingPrice;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProductBidding=new JSONObject(); 
		jsonProductBidding.accumulate("biddingId", this.getBiddingId());
		jsonProductBidding.accumulate("itemObj", this.getItemObj().getPTitle());
		jsonProductBidding.accumulate("itemObjPri", this.getItemObj().getItemId());
		jsonProductBidding.accumulate("userObj", this.getUserObj().getName());
		jsonProductBidding.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonProductBidding.accumulate("biddingTime", this.getBiddingTime().length()>19?this.getBiddingTime().substring(0,19):this.getBiddingTime());
		jsonProductBidding.accumulate("biddingPrice", this.getBiddingPrice());
		return jsonProductBidding;
    }}