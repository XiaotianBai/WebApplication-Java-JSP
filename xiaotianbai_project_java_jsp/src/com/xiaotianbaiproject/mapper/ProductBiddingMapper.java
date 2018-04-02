package com.xiaotianbaiproject.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.xiaotianbaiproject.po.ProductBidding;

public interface ProductBiddingMapper {
	/*AddBiddingInfo*/
	public void addProductBidding(ProductBidding productBidding) throws Exception;

	/*  SearchBiddingRecord*/
	public ArrayList<ProductBidding> queryProductBidding(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*  SearchAllBiddingRecord*/
	public ArrayList<ProductBidding> queryProductBiddingList(@Param("where") String where) throws Exception;

	/*  的BiddingRecord*/
	public int queryProductBiddingCount(@Param("where") String where) throws Exception; 

	/*UseKeySearchSomeBiddingRecord*/
	public ProductBidding getProductBidding(int biddingId) throws Exception;

	/*UpdateBiddingRecord*/
	public void updateProductBidding(ProductBidding productBidding) throws Exception;

	/*DeleteBiddingRecord*/
	public void deleteProductBidding(int biddingId) throws Exception;

}
