package com.xiaotianbaiproject.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.ProductBiddingMapper;
import com.xiaotianbaiproject.po.Item;
import com.xiaotianbaiproject.po.ProductBidding;
import com.xiaotianbaiproject.po.UserInfo;
@Service
public class ProductBiddingService {

	@Resource ProductBiddingMapper productBiddingMapper;
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

    /*AddBiddingRecord*/
    public void addProductBidding(ProductBidding productBidding) throws Exception {
    	productBiddingMapper.addProductBidding(productBidding);
    }

    /*  SearchBiddingRecord*/
    public ArrayList<ProductBidding> queryProductBidding(Item itemObj,UserInfo userObj,String biddingTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != itemObj && itemObj.getItemId()!= null && itemObj.getItemId()!= 0)  where += " and t_productBidding.itemObj=" + itemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_productBidding.userObj='" + userObj.getUser_name() + "'";
    	if(!biddingTime.equals("")) where = where + " and t_productBidding.biddingTime like '%" + biddingTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return productBiddingMapper.queryProductBidding(where, startIndex, this.rows);
    }

    /*  SearchAllRecord*/
    public ArrayList<ProductBidding> queryProductBidding(Item itemObj,UserInfo userObj,String biddingTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != itemObj && itemObj.getItemId()!= null && itemObj.getItemId()!= 0)  where += " and t_productBidding.itemObj=" + itemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_productBidding.userObj='" + userObj.getUser_name() + "'";
    	if(!biddingTime.equals("")) where = where + " and t_productBidding.biddingTime like '%" + biddingTime + "%'";
    	return productBiddingMapper.queryProductBiddingList(where);
    }

    /*SearchAllBiddingRecord*/
    public ArrayList<ProductBidding> queryAllProductBidding()  throws Exception {
        return productBiddingMapper.queryProductBiddingList("where 1=1");
    }

    /*GetTotalPagesAndRecordsFromSearch*/
    public void queryTotalPageAndRecordNumber(Item itemObj,UserInfo userObj,String biddingTime) throws Exception {
     	String where = "where 1=1";
    	if(null != itemObj && itemObj.getItemId()!= null && itemObj.getItemId()!= 0)  where += " and t_productBidding.itemObj=" + itemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_productBidding.userObj='" + userObj.getUser_name() + "'";
    	if(!biddingTime.equals("")) where = where + " and t_productBidding.biddingTime like '%" + biddingTime + "%'";
        recordNumber = productBiddingMapper.queryProductBiddingCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*UseKeyGetBiddingRecord*/
    public ProductBidding getProductBidding(int biddingId) throws Exception  {
        ProductBidding productBidding = productBiddingMapper.getProductBidding(biddingId);
        return productBidding;
    }

    /*UpdateBiddingRecord*/
    public void updateProductBidding(ProductBidding productBidding) throws Exception {
        productBiddingMapper.updateProductBidding(productBidding);
    }

    /*DeleteOneBiddingRecord*/
    public void deleteProductBidding (int biddingId) throws Exception {
        productBiddingMapper.deleteProductBidding(biddingId);
    }

    /*DeleteMultipleBiddingInfo*/
    public int deleteProductBiddings (String biddingIds) throws Exception {
    	String _biddingIds[] = biddingIds.split(",");
    	for(String _biddingId: _biddingIds) {
    		productBiddingMapper.deleteProductBidding(Integer.parseInt(_biddingId));
    	}
    	return _biddingIds.length;
    }
}
