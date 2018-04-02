package com.xiaotianbaiproject.mapper;


import com.xiaotianbaiproject.po.Admin;

public interface AdminMapper {
 
	public Admin findAdminByUserName(String username) throws Exception;
	
	public void changePassword(Admin admin) throws Exception;
	
	
	
}
