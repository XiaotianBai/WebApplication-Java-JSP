$(function () {
	$.ajax({
		url : "UserFollow/" + $("#userFollow_followId_edit").val() + "/update",
		type : "get",
		data : {
			//followId : $("#userFollow_followId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在Get中...",
			});
		},
		success : function (userFollow, response, status) {
			$.messager.progress("close");
			if (userFollow) { 
				$("#userFollow_followId_edit").val(userFollow.followId);
				$("#userFollow_followId_edit").validatebox({
					required : true,
					missingMessage : "Input Recordid",
					editable: false
				});
				$("#userFollow_userObj1_user_name_edit").combobox({
					url:"../UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#userFollow_userObj1_user_name_edit").combobox("select", userFollow.userObj1Pri);
						//var data = $("#userFollow_userObj1_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#userFollow_userObj1_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#userFollow_userObj2_user_name_edit").combobox({
					url:"../UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#userFollow_userObj2_user_name_edit").combobox("select", userFollow.userObj2Pri);
						//var data = $("#userFollow_userObj2_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#userFollow_userObj2_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#userFollow_followTime_edit").datetimebox({
					value: userFollow.followTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("GetFailed！", "Unkown failure, please retry!", "warning");
			}
		}
	});

	$("#userFollowModifyButton").click(function(){ 
		if ($("#userFollowEditForm").form("validate")) {
			$("#userFollowEditForm").form({
			    url:"UserFollow/" +  $("#userFollow_followId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#userFollowEditForm").form("validate"))  {
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
			$("#userFollowEditForm").submit();
		} else {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		}
	});
});
