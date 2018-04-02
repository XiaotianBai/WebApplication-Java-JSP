$(function () {
	$.ajax({
		url : "PostInfo/" + $("#postInfo_postInfoId_edit").val() + "/update",
		type : "get",
		data : {
			//postInfoId : $("#postInfo_postInfoId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在Get中...",
			});
		},
		success : function (postInfo, response, status) {
			$.messager.progress("close");
			if (postInfo) { 
				$("#postInfo_postInfoId_edit").val(postInfo.postInfoId);
				$("#postInfo_postInfoId_edit").validatebox({
					required : true,
					missingMessage : "Input Postid",
					editable: false
				});
				$("#postInfo_pTitle_edit").val(postInfo.pTitle);
				$("#postInfo_pTitle_edit").validatebox({
					required : true,
					missingMessage : "Input PostTitle",
				});
				$("#postInfo_content_edit").val(postInfo.content);
				$("#postInfo_content_edit").validatebox({
					required : true,
					missingMessage : "Input PostContent",
				});
				$("#postInfo_userObj_user_name_edit").combobox({
					url:"../UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#postInfo_userObj_user_name_edit").combobox("select", postInfo.userObjPri);
						//var data = $("#postInfo_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#postInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#postInfo_addTime_edit").datetimebox({
					value: postInfo.addTime,
					required: true,
					showSeconds: true,
				});
				$("#postInfo_hitNum_edit").val(postInfo.hitNum);
				$("#postInfo_hitNum_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "Input Views",
					invalidMessage : "ViewsInputIncorrect",
				});
			} else {
				$.messager.alert("GetFailed！", "Unkown failure, please retry!", "warning");
			}
		}
	});

	$("#postInfoModifyButton").click(function(){ 
		if ($("#postInfoEditForm").form("validate")) {
			$("#postInfoEditForm").form({
			    url:"PostInfo/" +  $("#postInfo_postInfoId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#postInfoEditForm").form("validate"))  {
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
			$("#postInfoEditForm").submit();
		} else {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		}
	});
});
