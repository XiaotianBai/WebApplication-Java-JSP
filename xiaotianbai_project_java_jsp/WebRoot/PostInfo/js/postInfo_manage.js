var postInfo_manage_tool = null; 
$(function () { 
	initPostInfoManageTool(); //建立PostInfoManageObj
	postInfo_manage_tool.init(); //如果需要通过下拉框Search，首先Initialize下拉框的值
	$("#postInfo_manage").datagrid({
		url : 'PostInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "postInfoId",
		sortOrder : "desc",
		toolbar : "#postInfo_manage_tool",
		columns : [[
			{
				field : "postInfoId",
				title : "Postid",
				width : 70,
			},
			{
				field : "pTitle",
				title : "PostTitle",
				width : 140,
			},
			{
				field : "userObj",
				title : "Poster",
				width : 140,
			},
			{
				field : "addTime",
				title : "Post Time",
				width : 140,
			},
			{
				field : "hitNum",
				title : "Views",
				width : 70,
			},
		]],
	});

	$("#postInfoEditDiv").dialog({
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
				if ($("#postInfoEditForm").form("validate")) {
					//Validate表单 
					if(!$("#postInfoEditForm").form("validate")) {
						$.messager.alert("Warning","你Input的Info还有错误！","warning");
					} else {
						$("#postInfoEditForm").form({
						    url:"PostInfo/" + $("#postInfo_postInfoId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("Message","InfoEditSuccessful！");
			                        $("#postInfoEditDiv").dialog("close");
			                        postInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("Message",obj.message);
			                    } 
						    }
						});
						//Upload表单
						$("#postInfoEditForm").submit();
					}
				}
			},
		},{
			text : "Cancel",
			iconCls : "icon-redo",
			handler : function () {
				$("#postInfoEditDiv").dialog("close");
				$("#postInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initPostInfoManageTool() {
	postInfo_manage_tool = {
		init: function() {
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
			$("#postInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#postInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#postInfo_manage").datagrid("options").queryParams;
			queryParams["pTitle"] = $("#pTitle").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#postInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#postInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#postInfoQueryForm").form({
			    url:"PostInfo/OutToExcel",
			});
			//Upload表单
			$("#postInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#postInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("Confirm", "Delete the selected entry?", function (flag) {
					if (flag) {
						var postInfoIds = [];
						for (var i = 0; i < rows.length; i ++) {
							postInfoIds.push(rows[i].postInfoId);
						}
						$.ajax({
							type : "POST",
							url : "PostInfo/deletes",
							data : {
								postInfoIds : postInfoIds.join(","),
							},
							beforeSend : function () {
								$("#postInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#postInfo_manage").datagrid("loaded");
									$("#postInfo_manage").datagrid("load");
									$("#postInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "Tips",
										msg : data.message
									});
								} else {
									$("#postInfo_manage").datagrid("loaded");
									$("#postInfo_manage").datagrid("load");
									$("#postInfo_manage").datagrid("unselectAll");
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
			var rows = $("#postInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("Warning！", "EditRecord只能选定One数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "PostInfo/" + rows[0].postInfoId +  "/update",
					type : "get",
					data : {
						//postInfoId : rows[0].postInfoId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在Get中...",
						});
					},
					success : function (postInfo, response, status) {
						$.messager.progress("close");
						if (postInfo) { 
							$("#postInfoEditDiv").dialog("open");
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
								url:"UserInfo/listAll",
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
			} else if (rows.length == 0) {
				$.messager.alert("Warning！", "Edit One Entry at a Time！", "warning");
			}
		},
	};
}
