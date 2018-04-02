package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.UserFollow;

public interface UserFollowMapper {
	/*AddUserFollowerInfo*/
	public void addUserFollow(UserFollow userFollow) throws Exception;

	/*  SearchUserFollowerRecord*/
	public ArrayList<UserFollow> queryUserFollow(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*  SearchAllUserFollowerRecord*/
	public ArrayList<UserFollow> queryUserFollowList(@Param("where") String where) throws Exception;

	/*  的UserFollowerRecord*/
	public int queryUserFollowCount(@Param("where") String where) throws Exception; 

	/*UseKeySearchSomeUserFollowerRecord*/
	public UserFollow getUserFollow(int followId) throws Exception;

	/*UpdateUserFollowerRecord*/
	public void updateUserFollow(UserFollow userFollow) throws Exception;

	/*DeleteUserFollowerRecord*/
	public void deleteUserFollow(int followId) throws Exception;

}
