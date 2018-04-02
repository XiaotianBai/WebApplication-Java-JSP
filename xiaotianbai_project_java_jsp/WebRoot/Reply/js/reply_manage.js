var reply_manage_tool = null; 
$(function () { 
	initReplyManageTool(); //建立ReplyManageObj
	reply_manage_tool.init(); //如果需要通过下拉框Search，首先Initialize下拉框的值
	$("#reply_manage").datagrid({
		url : 'Reply/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "replyId",
		sortOrder : "desc",
		toolbar : "#reply_manage_tool",
		columns : [[
			{
				field : "replyId",
				title : "Replyid",
				width : 70,
			},
			{
				field : "postInfoObj",
				title : "OriginalPost",
				width : 140,
			},
			{
				field : "content",
				title : "ReplyContent",
				width : 140,
			},
			{
				field : "userObj",
				title : "Replier",
				width : 140,
			},
			{
				field : "replyTime",
				title : "ReplyTime",
				width : 140,
			},
		]],
	});

	$("#replyEditDiv").dialog({
		title : "EditManage",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "Upload",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#replyEditForm").form("validate")) {
					//Validate表单 
					if(!$("#replyEditForm").form("validate")) {
						$.messager.alert("Warning","你Input的Info还有错误！","warning");
					} else {
						$("#replyEditForm").form({
						    url:"Reply/" + $("#reply_replyId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("Message","InfoEditSuccessful！");
			                        $("#replyEditDiv").dialog("close");
			                        reply_manage_tool.reload();
			                    }else{
			                        $.messager.alert("Message",obj.message);
			                    } 
						    }
						});
						//Upload表单
						$("#replyEditForm").submit();
					}
				}
			},
		},{
			text : "Cancel",
			iconCls : "icon-redo",
			handler : function () {
				$("#replyEditDiv").dialog("close");
				$("#replyEditForm").form("reset"); 
			},
		}],
	});
});

function initReplyManageTool() {
	reply_manage_tool = {
		init: function() {
			$.ajax({
				url : "PostInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#postInfoObj_postInfoId_query").combobox({ 
					    valueField:"postInfoId",
					    textField:"pTitle",
					    panelHeight: "200px",
				        editable: false, //不允许手动Input 
					});
					data.splice(0,0,{postInfoId:0,pTitle:"No limits"});
					$("#postInfoObj_postInfoId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动Input 
					});
					data.splice(0,0,{user_name:"",name:"No limits"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#reply_manage").datagrid("reload");
		},
		redo : function () {
			$("#reply_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#reply_manage").datagrid("options").queryParams;
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["replyTime"] = $("#replyTime").datebox("getValue"); 
			queryParams["postInfoObj.postInfoId"] = $("#postInfoObj_postInfoId_query").combobox("getValue");
			$("#reply_manage").datagrid("options").queryParams=queryParams; 
			$("#reply_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#replyQueryForm").form({
			    url:"Reply/OutToExcel",
			});
			//Upload表单
			$("#replyQueryForm").submit();
		},
		remove : function () {
			var rows = $("#reply_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("Confirm", "Delete the selected entry?", function (flag) {
					if (flag) {
						var replyIds = [];
						for (var i = 0; i < rows.length; i ++) {
							replyIds.push(rows[i].replyId);
						}
						$.ajax({
							type : "POST",
							url : "Reply/deletes",
							data : {
								replyIds : replyIds.join(","),
							},
							beforeSend : function () {
								$("#reply_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#reply_manage").datagrid("loaded");
									$("#reply_manage").datagrid("load");
									$("#reply_manage").datagrid("unselectAll");
									$.messager.show({
										title : "Tips",
										msg : data.message
									});
								} else {
									$("#reply_manage").datagrid("loaded");
									$("#reply_manage").datagrid("load");
									$("#reply_manage").datagrid("unselectAll");
									$.messager.alert("Message",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("Tips", "Choose the entry you want to delete！", "info");
			}
		},
		edit : function () {
			var rows = $("#reply_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("Warning！", "EditRecord只能选定One数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Reply/" + rows[0].replyId +  "/update",
					type : "get",
					data : {
						//replyId : rows[0].replyId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在Get中...",
						});
					},
					success : function (reply, response, status) {
						$.messager.progress("close");
						if (reply) { 
							$("#replyEditDiv").dialog("open");
							$("#reply_replyId_edit").val(reply.replyId);
							$("#reply_replyId_edit").validatebox({
								required : true,
								missingMessage : "Input Replyid",
								editable: false
							});
							$("#reply_postInfoObj_postInfoId_edit").combobox({
								url:"PostInfo/listAll",
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
								url:"UserInfo/listAll",
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
			} else if (rows.length == 0) {
				$.messager.alert("Warning！", "Edit One Entry at a Time！", "warning");
			}
		},
	};
}
