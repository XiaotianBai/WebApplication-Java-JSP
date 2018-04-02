package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.ReplyMapper;
import com.xiaotianbaiproject.po.PostInfo;
import com.xiaotianbaiproject.po.Reply;
import com.xiaotianbaiproject.po.UserInfo;
@Service
public class ReplyService {

	@Resource ReplyMapper replyMapper;
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

    /*AddReplyRecord*/
    public void addReply(Reply reply) throws Exception {
    	replyMapper.addReply(reply);
    }

    /*  SearchReplyRecord*/
    public ArrayList<Reply> queryReply(UserInfo userObj,String replyTime,PostInfo postInfoObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_reply.userObj='" + userObj.getUser_name() + "'";
    	if(!replyTime.equals("")) where = where + " and t_reply.replyTime like '%" + replyTime + "%'";
    	if(null != postInfoObj && postInfoObj.getPostInfoId()!= null && postInfoObj.getPostInfoId()!= 0)  where += " and t_reply.postInfoObj=" + postInfoObj.getPostInfoId();
    	int startIndex = (currentPage-1) * this.rows;
    	return replyMapper.queryReply(where, startIndex, this.rows);
    }

    /*  SearchAllRecord*/
    public ArrayList<Reply> queryReply(UserInfo userObj,String replyTime,PostInfo postInfoObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_reply.userObj='" + userObj.getUser_name() + "'";
    	if(!replyTime.equals("")) where = where + " and t_reply.replyTime like '%" + replyTime + "%'";
    	if(null != postInfoObj && postInfoObj.getPostInfoId()!= null && postInfoObj.getPostInfoId()!= 0)  where += " and t_reply.postInfoObj=" + postInfoObj.getPostInfoId();
    	return replyMapper.queryReplyList(where);
    }

    /*SearchAllReplyRecord*/
    public ArrayList<Reply> queryAllReply()  throws Exception {
        return replyMapper.queryReplyList("where 1=1");
    }

    /*GetTotalPagesAndRecordsFromSearch*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj,String replyTime,PostInfo postInfoObj) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_reply.userObj='" + userObj.getUser_name() + "'";
    	if(!replyTime.equals("")) where = where + " and t_reply.replyTime like '%" + replyTime + "%'";
    	if(null != postInfoObj && postInfoObj.getPostInfoId()!= null && postInfoObj.getPostInfoId()!= 0)  where += " and t_reply.postInfoObj=" + postInfoObj.getPostInfoId();
        recordNumber = replyMapper.queryReplyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*UseKeyGetReplyRecord*/
    public Reply getReply(int replyId) throws Exception  {
        Reply reply = replyMapper.getReply(replyId);
        return reply;
    }

    /*UpdateReplyRecord*/
    public void updateReply(Reply reply) throws Exception {
        replyMapper.updateReply(reply);
    }

    /*DeleteOneReplyRecord*/
    public void deleteReply (int replyId) throws Exception {
        replyMapper.deleteReply(replyId);
    }

    /*DeleteMultipleReplyInfo*/
    public int deleteReplys (String replyIds) throws Exception {
    	String _replyIds[] = replyIds.split(",");
    	for(String _replyId: _replyIds) {
    		replyMapper.deleteReply(Integer.parseInt(_replyId));
    	}
    	return _replyIds.length;
    }
}
