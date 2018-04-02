package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.ItemClass;

public interface ItemClassMapper {
	/*AddItemClassInfo*/
	public void addItemClass(ItemClass itemClass) throws Exception;

	/*  SearchItemClassRecord*/
	public ArrayList<ItemClass> queryItemClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/* SearchAllItemClassRecord*/
	public ArrayList<ItemClass> queryItemClassList(@Param("where") String where) throws Exception;

	/* AllItemClassRecord*/
	public int queryItemClassCount(@Param("where") String where) throws Exception; 

	/*UseKeySearchSomeItemClassRecord*/
	public ItemClass getItemClass(int classId) throws Exception;

	/*UpdateItemClassRecord*/
	public void updateItemClass(ItemClass itemClass) throws Exception;

	/*DeleteItemClassRecord*/
	public void deleteItemClass(int classId) throws Exception;

}
