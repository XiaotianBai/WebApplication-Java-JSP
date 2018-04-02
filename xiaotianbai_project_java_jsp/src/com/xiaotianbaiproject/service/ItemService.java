package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.ItemMapper;
import com.xiaotianbaiproject.po.Item;
import com.xiaotianbaiproject.po.ItemClass;
import com.xiaotianbaiproject.po.UserInfo;
@Service
public class ItemService {

	@Resource ItemMapper itemMapper;
    /*Each Page Display Record Num*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*Total Pages*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*Record Number*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*Add Item Record*/
    public void addItem(Item item) throws Exception {
    	itemMapper.addItem(item);
    }

    /*Search Item Record in a Page*/
    public ArrayList<Item> queryItem(ItemClass itemClassObj,String pTitle,UserInfo userObj,String startTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != itemClassObj && itemClassObj.getClassId()!= null && itemClassObj.getClassId()!= 0)  where += " and t_item.itemClassObj=" + itemClassObj.getClassId();
    	if(!pTitle.equals("")) where = where + " and t_item.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_item.userObj='" + userObj.getUser_name() + "'";
    	if(!startTime.equals("")) where = where + " and t_item.startTime like '%" + startTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return itemMapper.queryItem(where, startIndex, this.rows);
    }

    /* Search Item*/
    public ArrayList<Item> queryItem(ItemClass itemClassObj,String pTitle,UserInfo userObj,String startTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != itemClassObj && itemClassObj.getClassId()!= null && itemClassObj.getClassId()!= 0)  where += " and t_item.itemClassObj=" + itemClassObj.getClassId();
    	if(!pTitle.equals("")) where = where + " and t_item.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_item.userObj='" + userObj.getUser_name() + "'";
    	if(!startTime.equals("")) where = where + " and t_item.startTime like '%" + startTime + "%'";
    	return itemMapper.queryItemList(where);
    }

    /*Search All Item Records*/
    public ArrayList<Item> queryAllItem()  throws Exception {
        return itemMapper.queryItemList("where 1=1");
    }

    /*Get Total Pages and Records*/
    public void queryTotalPageAndRecordNumber(ItemClass itemClassObj,String pTitle,UserInfo userObj,String startTime) throws Exception {
     	String where = "where 1=1";
    	if(null != itemClassObj && itemClassObj.getClassId()!= null && itemClassObj.getClassId()!= 0)  where += " and t_item.itemClassObj=" + itemClassObj.getClassId();
    	if(!pTitle.equals("")) where = where + " and t_item.pTitle like '%" + pTitle + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_item.userObj='" + userObj.getUser_name() + "'";
    	if(!startTime.equals("")) where = where + " and t_item.startTime like '%" + startTime + "%'";
        recordNumber = itemMapper.queryItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*UseKeyGetItemRecord*/
    public Item getItem(int itemId) throws Exception  {
        Item item = itemMapper.getItem(itemId);
        return item;
    }

    /*UpdateItemRecord*/
    public void updateItem(Item item) throws Exception {
        itemMapper.updateItem(item);
    }

    /*DeleteOneItemRecord*/
    public void deleteItem (int itemId) throws Exception {
        itemMapper.deleteItem(itemId);
    }

    /*DeleteMultipleItemInfo*/
    public int deleteItems (String itemIds) throws Exception {
    	String _itemIds[] = itemIds.split(",");
    	for(String _itemId: _itemIds) {
    		itemMapper.deleteItem(Integer.parseInt(_itemId));
    	}
    	return _itemIds.length;
    }
}
