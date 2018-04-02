package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.Item;

public interface ItemMapper {
	/*Add Item Record*/
	public void addItem(Item item) throws Exception;

	/* Search Item Record With Limits*/
	public ArrayList<Item> queryItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/* Search All Item Records*/
	public ArrayList<Item> queryItemList(@Param("where") String where) throws Exception;

	/*Get Item Count*/
	public int queryItemCount(@Param("where") String where) throws Exception; 

	/*Fetch Some Item Record*/
	public Item getItem(int itemId) throws Exception;

	/*Update Item Record*/
	public void updateItem(Item item) throws Exception;

	/*Delete Item Record*/
	public void deleteItem(int itemId) throws Exception;

}
