package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.UserFollowMapper;
import com.xiaotianbaiproject.po.UserFollow;
import com.xiaotianbaiproject.po.UserInfo;
@Service
public class UserFollowService {

	@Resource UserFollowMapper userFollowMapper;
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

    /*AddUserFollowerRecord*/
    public void addUserFollow(UserFollow userFollow) throws Exception {
    	userFollowMapper.addUserFollow(userFollow);
    }

    /*  SearchUserFollowerRecord*/
    public ArrayList<UserFollow> queryUserFollow(UserInfo userObj1,UserInfo userObj2,String followTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null  && !userObj1.getUser_name().equals(""))  where += " and t_userFollow.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null  && !userObj2.getUser_name().equals(""))  where += " and t_userFollow.userObj2='" + userObj2.getUser_name() + "'";
    	if(!followTime.equals("")) where = where + " and t_userFollow.followTime like '%" + followTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return userFollowMapper.queryUserFollow(where, startIndex, this.rows);
    }

    /*  SearchAllRecord*/
    public ArrayList<UserFollow> queryUserFollow(UserInfo userObj1,UserInfo userObj2,String followTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null && !userObj1.getUser_name().equals(""))  where += " and t_userFollow.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null && !userObj2.getUser_name().equals(""))  where += " and t_userFollow.userObj2='" + userObj2.getUser_name() + "'";
    	if(!followTime.equals("")) where = where + " and t_userFollow.followTime like '%" + followTime + "%'";
    	return userFollowMapper.queryUserFollowList(where);
    }

    /*SearchAllUserFollowerRecord*/
    public ArrayList<UserFollow> queryAllUserFollow()  throws Exception {
        return userFollowMapper.queryUserFollowList("where 1=1");
    }

    /*GetTotalPagesAndRecordsFromSearch*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj1,UserInfo userObj2,String followTime) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null && !userObj1.getUser_name().equals(""))  where += " and t_userFollow.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null && !userObj2.getUser_name().equals(""))  where += " and t_userFollow.userObj2='" + userObj2.getUser_name() + "'";
    	if(!followTime.equals("")) where = where + " and t_userFollow.followTime like '%" + followTime + "%'";
        recordNumber = userFollowMapper.queryUserFollowCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*UseKeyGetUserFollowerRecord*/
    public UserFollow getUserFollow(int followId) throws Exception  {
        UserFollow userFollow = userFollowMapper.getUserFollow(followId);
        return userFollow;
    }

    /*UpdateUserFollowerRecord*/
    public void updateUserFollow(UserFollow userFollow) throws Exception {
        userFollowMapper.updateUserFollow(userFollow);
    }

    /*DeleteOneUserFollowerRecord*/
    public void deleteUserFollow (int followId) throws Exception {
        userFollowMapper.deleteUserFollow(followId);
    }

    /*DeleteMultipleUserFollowerInfo*/
    public int deleteUserFollows (String followIds) throws Exception {
    	String _followIds[] = followIds.split(",");
    	for(String _followId: _followIds) {
    		userFollowMapper.deleteUserFollow(Integer.parseInt(_followId));
    	}
    	return _followIds.length;
    }
}
