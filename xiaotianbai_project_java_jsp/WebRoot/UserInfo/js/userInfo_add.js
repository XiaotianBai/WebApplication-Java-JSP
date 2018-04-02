$(function () {
	$("#userInfo_user_name").validatebox({
		required : true, 
		missingMessage : 'Input Username',
	});

	$("#userInfo_password").validatebox({
		required : true, 
		missingMessage : 'Input Password',
	});

	$("#userInfo_name").validatebox({
		required : true, 
		missingMessage : 'Input Name',
	});

	$("#userInfo_gender").validatebox({
		required : true, 
		missingMessage : 'Input Gender',
	});

	$("#userInfo_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#userInfo_telephone").validatebox({
		required : true, 
		missingMessage : 'Input Phone',
	});

	$("#userInfo_city").validatebox({
		required : true, 
		missingMessage : 'Input City',
	});

	$("#userInfo_address").validatebox({
		required : true, 
		missingMessage : 'Input Address',
	});

	$("#userInfo_paypalAccount").validatebox({
		required : true, 
		missingMessage : 'Input PayPalAccount',
	});

	$("#userInfo_createTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击Add按钮
	$("#userInfoAddButton").click(function () {
		//Validate表单 
		if(!$("#userInfoAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#userInfoAddForm").form({
			    url:"UserInfo/add",
			    onSubmit: function(){
					if($("#userInfoAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("Message","SaveSuccessful！");
                        $("#userInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#userInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#userInfoClearButton").click(function () { 
		$("#userInfoAddForm").form("clear"); 
	});
});
