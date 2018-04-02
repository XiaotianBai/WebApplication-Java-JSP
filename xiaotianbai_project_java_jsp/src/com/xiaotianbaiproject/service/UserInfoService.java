package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.UserInfoMapper;
import com.xiaotianbaiproject.po.Admin;
import com.xiaotianbaiproject.po.UserInfo;
@Service
public class UserInfoService {

	@Resource UserInfoMapper userInfoMapper;
    /*EachPageDisplayRecordNum*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*SaveTotalPages*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*SaveTotalRecords*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*AddUserRecord*/
    public void addUserInfo(UserInfo userInfo) throws Exception {
    	userInfoMapper.addUserInfo(userInfo);
    }

    /*  SearchUserRecord*/
    public ArrayList<UserInfo> queryUserInfo(String paypalAccount,String user_name,String name,String birthDate,String telephone,String city,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!paypalAccount.equals("")) where = where + " and t_userInfo.paypalAccount like '%" + paypalAccount + "%'";
    	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
    	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_userInfo.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
    	if(!city.equals("")) where = where + " and t_userInfo.city like '%" + city + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return userInfoMapper.queryUserInfo(where, startIndex, this.rows);
    }

    /*  SearchAllRecord*/
    public ArrayList<UserInfo> queryUserInfo(String paypalAccount,String user_name,String name,String birthDate,String telephone,String city) throws Exception  { 
     	String where = "where 1=1";
    	if(!paypalAccount.equals("")) where = where + " and t_userInfo.paypalAccount like '%" + paypalAccount + "%'";
    	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
    	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_userInfo.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
    	if(!city.equals("")) where = where + " and t_userInfo.city like '%" + city + "%'";
    	return userInfoMapper.queryUserInfoList(where);
    }

    /*SearchAllUserRecord*/
    public ArrayList<UserInfo> queryAllUserInfo()  throws Exception {
        return userInfoMapper.queryUserInfoList("where 1=1");
    }

    /*GetTotalPagesAndRecordsFromSearch*/
    public void queryTotalPageAndRecordNumber(String paypalAccount,String user_name,String name,String birthDate,String telephone,String city) throws Exception {
     	String where = "where 1=1";
    	if(!paypalAccount.equals("")) where = where + " and t_userInfo.paypalAccount like '%" + paypalAccount + "%'";
    	if(!user_name.equals("")) where = where + " and t_userInfo.user_name like '%" + user_name + "%'";
    	if(!name.equals("")) where = where + " and t_userInfo.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_userInfo.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_userInfo.telephone like '%" + telephone + "%'";
    	if(!city.equals("")) where = where + " and t_userInfo.city like '%" + city + "%'";
        recordNumber = userInfoMapper.queryUserInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*UseKeyGetUserRecord*/
    public UserInfo getUserInfo(String user_name) throws Exception  {
        UserInfo userInfo = userInfoMapper.getUserInfo(user_name);
        return userInfo;
    }

    /*UpdateUserRecord*/
    public void updateUserInfo(UserInfo userInfo) throws Exception {
        userInfoMapper.updateUserInfo(userInfo);
    }

    /*DeleteOneUserRecord*/
    public void deleteUserInfo (String user_name) throws Exception {
        userInfoMapper.deleteUserInfo(user_name);
    }

    /*DeleteMultipleUserInfo*/
    public int deleteUserInfos (String user_names) throws Exception {
    	String _user_names[] = user_names.split(",");
    	for(String _user_name: _user_names) {
    		userInfoMapper.deleteUserInfo(_user_name);
    	}
    	return _user_names.length;
    }
	 
	
	/*Save业务逻辑错误Info字段*/
	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	
	/*ValidateUserLogin*/
	public boolean checkLogin(String userName, String password) throws Exception {
		UserInfo db_user = (UserInfo) userInfoMapper.getUserInfo(userName);
		if(db_user == null) { 
			this.errMessage = " Username Not Found ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_user.getPassword().equals(password)) {
			this.errMessage = " Password Incorrect! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
	
}
