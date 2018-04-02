package com.xiaotianbaiproject.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class UserInfo {
    /*username*/
    @NotEmpty(message="username cannot be empty")
    private String user_name;
    public String getUser_name(){
        return user_name;
    }
    public void setUser_name(String user_name){
        this.user_name = user_name;
    }

    /*password*/
    @NotEmpty(message="password cannot be empty")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*name*/
    @NotEmpty(message="name cannot be empty")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*gender*/
    @NotEmpty(message="gender cannot be empty")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*dob*/
    @NotEmpty(message="birth date cannot be empty")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*user image*/
    private String userImage;
    public String getUserImage() {
        return userImage;
    }
    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    /*user phone*/
    @NotEmpty(message="phone number cannot be empty")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*city*/
    @NotEmpty(message="city cannot be empty")
    private String city;
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }

    /*address*/
    @NotEmpty(message="address cannot be empty")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*email*/
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    /*paypal account*/
    @NotEmpty(message="paypal account cannot be empty")
    private String paypalAccount;
    public String getPaypalAccount() {
        return paypalAccount;
    }
    public void setPaypalAccount(String paypalAccount) {
        this.paypalAccount = paypalAccount;
    }

    /*create time*/
    private String createTime;
    public String getCreateTime() {
        return createTime;
    }
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonUserInfo=new JSONObject(); 
		jsonUserInfo.accumulate("user_name", this.getUser_name());
		jsonUserInfo.accumulate("password", this.getPassword());
		jsonUserInfo.accumulate("name", this.getName());
		jsonUserInfo.accumulate("gender", this.getGender());
		jsonUserInfo.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonUserInfo.accumulate("userImage", this.getUserImage());
		jsonUserInfo.accumulate("telephone", this.getTelephone());
		jsonUserInfo.accumulate("city", this.getCity());
		jsonUserInfo.accumulate("address", this.getAddress());
		jsonUserInfo.accumulate("email", this.getEmail());
		jsonUserInfo.accumulate("paypalAccount", this.getPaypalAccount());
		jsonUserInfo.accumulate("createTime", this.getCreateTime().length()>19?this.getCreateTime().substring(0,19):this.getCreateTime());
		return jsonUserInfo;
    }}