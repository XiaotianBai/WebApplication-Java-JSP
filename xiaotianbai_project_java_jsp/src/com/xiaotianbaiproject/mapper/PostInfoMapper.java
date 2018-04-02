package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.PostInfo;

public interface PostInfoMapper {
	/*AddPostInfo*/
	public void addPostInfo(PostInfo postInfo) throws Exception;

	/*  SearchPostRecord*/
	public ArrayList<PostInfo> queryPostInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*  SearchAllPostRecord*/
	public ArrayList<PostInfo> queryPostInfoList(@Param("where") String where) throws Exception;

	/*  PostRecord*/
	public int queryPostInfoCount(@Param("where") String where) throws Exception; 

	/*UseKeySearchSomePostRecord*/
	public PostInfo getPostInfo(int postInfoId) throws Exception;

	/*UpdatePostRecord*/
	public void updatePostInfo(PostInfo postInfo) throws Exception;

	/*DeletePostRecord*/
	public void deletePostInfo(int postInfoId) throws Exception;

}
