package com.xiaotianbaiproject.service;

import javax.annotation.Resource;

 
import org.springframework.stereotype.Service;

import com.xiaotianbaiproject.mapper.AdminMapper;
import com.xiaotianbaiproject.po.Admin;

@Service
public class AdminService {
	@Resource AdminMapper adminMapper;


	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	

	public boolean checkLogin(Admin admin) throws Exception { 
		Admin db_admin = (Admin) adminMapper.findAdminByUserName(admin.getUsername());
		if(db_admin == null) { 
			this.errMessage = " Username Not Found ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_admin.getPassword().equals(admin.getPassword())) {
			this.errMessage = " Password Incorrect! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
	


	public void changePassword(String username, String newPassword) throws Exception {  
		Admin admin = new Admin();
		admin.setUsername(username);
		admin.setPassword(newPassword);
		adminMapper.changePassword(admin);  
	}
	

	public Admin findAdminByUserName(String username) throws Exception {
		Admin db_admin = null;
		db_admin = adminMapper.findAdminByUserName(username);
		return db_admin;
	}
}
