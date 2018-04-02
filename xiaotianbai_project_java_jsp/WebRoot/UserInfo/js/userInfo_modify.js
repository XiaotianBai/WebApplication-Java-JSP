$(function () {
	$.ajax({
		url : "UserInfo/" + $("#userInfo_user_name_edit").val() + "/update",
		type : "get",
		data : {
			//user_name : $("#userInfo_user_name_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在Get中...",
			});
		},
		success : function (userInfo, response, status) {
			$.messager.progress("close");
			if (userInfo) { 
				$("#userInfo_user_name_edit").val(userInfo.user_name);
				$("#userInfo_user_name_edit").validatebox({
					required : true,
					missingMessage : "Input Username",
					editable: false
				});
				$("#userInfo_password_edit").val(userInfo.password);
				$("#userInfo_password_edit").validatebox({
					required : true,
					missingMessage : "Input Password",
				});
				$("#userInfo_name_edit").val(userInfo.name);
				$("#userInfo_name_edit").validatebox({
					required : true,
					missingMessage : "Input Name",
				});
				$("#userInfo_gender_edit").val(userInfo.gender);
				$("#userInfo_gender_edit").validatebox({
					required : true,
					missingMessage : "Input Gender",
				});
				$("#userInfo_birthDate_edit").datebox({
					value: userInfo.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#userInfo_userImage").val(userInfo.userImage);
				$("#userInfo_userImageImg").attr("src", "../" +　userInfo.userImage);
				$("#userInfo_telephone_edit").val(userInfo.telephone);
				$("#userInfo_telephone_edit").validatebox({
					required : true,
					missingMessage : "Input Phone",
				});
				$("#userInfo_city_edit").val(userInfo.city);
				$("#userInfo_city_edit").validatebox({
					required : true,
					missingMessage : "Input City",
				});
				$("#userInfo_address_edit").val(userInfo.address);
				$("#userInfo_address_edit").validatebox({
					required : true,
					missingMessage : "Input Address",
				});
				$("#userInfo_email_edit").val(userInfo.email);
				$("#userInfo_paypalAccount_edit").val(userInfo.paypalAccount);
				$("#userInfo_paypalAccount_edit").validatebox({
					required : true,
					missingMessage : "Input PayPalAccount",
				});
				$("#userInfo_createTime_edit").datetimebox({
					value: userInfo.createTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("GetFailed！", "Unkown failure, please retry!", "warning");
			}
		}
	});

	$("#userInfoModifyButton").click(function(){ 
		if ($("#userInfoEditForm").form("validate")) {
			$("#userInfoEditForm").form({
			    url:"UserInfo/" +  $("#userInfo_user_name_edit").val() + "/update",
			    onSubmit: function(){
					if($("#userInfoEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "Uploading...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("Message","InfoEditSuccessful！");
                        location.href="frontlist";
                    }else{
                        $.messager.alert("Message",obj.message);
                    } 
			    }
			});
			//Upload表单
			$("#userInfoEditForm").submit();
		} else {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		}
	});
});
