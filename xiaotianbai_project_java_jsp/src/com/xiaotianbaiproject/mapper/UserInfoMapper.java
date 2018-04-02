package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.UserInfo;

public interface UserInfoMapper {
	/*AddUserInfo*/
	public void addUserInfo(UserInfo userInfo) throws Exception;

	/*  SearchUserRecord*/
	public ArrayList<UserInfo> queryUserInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*  SearchAllUserRecord*/
	public ArrayList<UserInfo> queryUserInfoList(@Param("where") String where) throws Exception;

	/*  的UserRecord*/
	public int queryUserInfoCount(@Param("where") String where) throws Exception; 

	/*UseKeySearchSomeUserRecord*/
	public UserInfo getUserInfo(String user_name) throws Exception;

	/*UpdateUserRecord*/
	public void updateUserInfo(UserInfo userInfo) throws Exception;

	/*DeleteUserRecord*/
	public void deleteUserInfo(String user_name) throws Exception;

}
