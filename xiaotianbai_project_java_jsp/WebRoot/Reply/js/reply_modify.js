$(function () {
	$.ajax({
		url : "Reply/" + $("#reply_replyId_edit").val() + "/update",
		type : "get",
		data : {
			//replyId : $("#reply_replyId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在Get中...",
			});
		},
		success : function (reply, response, status) {
			$.messager.progress("close");
			if (reply) { 
				$("#reply_replyId_edit").val(reply.replyId);
				$("#reply_replyId_edit").validatebox({
					required : true,
					missingMessage : "Input Replyid",
					editable: false
				});
				$("#reply_postInfoObj_postInfoId_edit").combobox({
					url:"../PostInfo/listAll",
					valueField:"postInfoId",
					textField:"pTitle",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#reply_postInfoObj_postInfoId_edit").combobox("select", reply.postInfoObjPri);
						//var data = $("#reply_postInfoObj_postInfoId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#reply_postInfoObj_postInfoId_edit").combobox("select", data[0].postInfoId);
						//}
					}
				});
				$("#reply_content_edit").val(reply.content);
				$("#reply_content_edit").validatebox({
					required : true,
					missingMessage : "Input ReplyContent",
				});
				$("#reply_userObj_user_name_edit").combobox({
					url:"../UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#reply_userObj_user_name_edit").combobox("select", reply.userObjPri);
						//var data = $("#reply_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#reply_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#reply_replyTime_edit").datetimebox({
					value: reply.replyTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("GetFailed！", "Unkown failure, please retry!", "warning");
			}
		}
	});

	$("#replyModifyButton").click(function(){ 
		if ($("#replyEditForm").form("validate")) {
			$("#replyEditForm").form({
			    url:"Reply/" +  $("#reply_replyId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#replyEditForm").form("validate"))  {
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
			$("#replyEditForm").submit();
		} else {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		}
	});
});
