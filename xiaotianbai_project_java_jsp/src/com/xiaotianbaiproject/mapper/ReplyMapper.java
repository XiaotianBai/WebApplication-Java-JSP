package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.Reply;

public interface ReplyMapper {
	/*AddReplyInfo*/
	public void addReply(Reply reply) throws Exception;

	/*  SearchReplyRecord*/
	public ArrayList<Reply> queryReply(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*  SearchAllReplyRecord*/
	public ArrayList<Reply> queryReplyList(@Param("where") String where) throws Exception;

	/*  的ReplyRecord*/
	public int queryReplyCount(@Param("where") String where) throws Exception; 

	/*UseKeySearchSomeReplyRecord*/
	public Reply getReply(int replyId) throws Exception;

	/*UpdateReplyRecord*/
	public void updateReply(Reply reply) throws Exception;

	/*DeleteReplyRecord*/
	public void deleteReply(int replyId) throws Exception;

}
