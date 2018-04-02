package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.ItemClassMapper;
import com.xiaotianbaiproject.po.ItemClass;
@Service
public class ItemClassService {

	@Resource ItemClassMapper itemClassMapper;
    /*item num per page*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*total num of pages*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*total record num*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*add item class*/
    public void addItemClass(ItemClass itemClass) throws Exception {
    	itemClassMapper.addItemClass(itemClass);
    }

    /*query itemclass in current page*/
    public ArrayList<ItemClass> queryItemClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return itemClassMapper.queryItemClass(where, startIndex, this.rows);
    }

    /*query itemclass*/
    public ArrayList<ItemClass> queryItemClass() throws Exception  { 
     	String where = "where 1=1";
    	return itemClassMapper.queryItemClassList(where);
    }

    /*query all itemclass*/
    public ArrayList<ItemClass> queryAllItemClass()  throws Exception {
        return itemClassMapper.queryItemClassList("where 1=1");
    }

    /*get num of pages and records*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = itemClassMapper.queryItemClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*get itemclass by classid*/
    public ItemClass getItemClass(int classId) throws Exception  {
        ItemClass itemClass = itemClassMapper.getItemClass(classId);
        return itemClass;
    }

    /*update*/
    public void updateItemClass(ItemClass itemClass) throws Exception {
        itemClassMapper.updateItemClass(itemClass);
    }

    /*delete*/
    public void deleteItemClass (int classId) throws Exception {
        itemClassMapper.deleteItemClass(classId);
    }

    /*delete multiple class*/
    public int deleteItemClasss (String classIds) throws Exception {
    	String _classIds[] = classIds.split(",");
    	for(String _classId: _classIds) {
    		itemClassMapper.deleteItemClass(Integer.parseInt(_classId));
    	}
    	return _classIds.length;
    }
}
