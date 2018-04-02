package com.xiaotianbaiproject.po;

 
import org.hibernate.validator.constraints.NotEmpty;

 
public class Admin {
	/*Username*/
	@NotEmpty(message="Username cannot be empty")  
	private String username;
	/*Password*/
	@NotEmpty(message="Password cannot be empty") 
	private String password;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}
