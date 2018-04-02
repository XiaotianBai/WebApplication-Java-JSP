package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.PostInfoMapper;
import com.xiaotianbaiproject.po.PostInfo;
import com.xiaotianbaiproject.po.UserInfo;
@Service
public class PostInfoService {

	@Resource PostInfoMapper postInfoMapper;
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

    /*AddPostRecord*/
    public void addPostInfo(PostInfo postInfo) throws Exception {
    	postInfoMapper.addPostInfo(postInfo);
    }

    /*  SearchPostRecord*/
    public ArrayList<PostInfo> queryPostInfo(String pTitle,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!pTitle.equals("")) where = where + " and t_postInfo.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_postInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_postInfo.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return postInfoMapper.queryPostInfo(where, startIndex, this.rows);
    }

    /*  SearchAllRecord*/
    public ArrayList<PostInfo> queryPostInfo(String pTitle,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!pTitle.equals("")) where = where + " and t_postInfo.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_postInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_postInfo.addTime like '%" + addTime + "%'";
    	return postInfoMapper.queryPostInfoList(where);
    }

    /*SearchAllPostRecord*/
    public ArrayList<PostInfo> queryAllPostInfo()  throws Exception {
        return postInfoMapper.queryPostInfoList("where 1=1");
    }

    /*GetTotalPagesAndRecordsFromSearch*/
    public void queryTotalPageAndRecordNumber(String pTitle,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!pTitle.equals("")) where = where + " and t_postInfo.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_postInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_postInfo.addTime like '%" + addTime + "%'";
        recordNumber = postInfoMapper.queryPostInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*UseKeyGetPostRecord*/
    public PostInfo getPostInfo(int postInfoId) throws Exception  {
        PostInfo postInfo = postInfoMapper.getPostInfo(postInfoId);
        return postInfo;
    }

    /*UpdatePostRecord*/
    public void updatePostInfo(PostInfo postInfo) throws Exception {
        postInfoMapper.updatePostInfo(postInfo);
    }

    /*DeleteOnePostRecord*/
    public void deletePostInfo (int postInfoId) throws Exception {
        postInfoMapper.deletePostInfo(postInfoId);
    }

    /*DeleteMultiplePostInfo*/
    public int deletePostInfos (String postInfoIds) throws Exception {
    	String _postInfoIds[] = postInfoIds.split(",");
    	for(String _postInfoId: _postInfoIds) {
    		postInfoMapper.deletePostInfo(Integer.parseInt(_postInfoId));
    	}
    	return _postInfoIds.length;
    }
}
