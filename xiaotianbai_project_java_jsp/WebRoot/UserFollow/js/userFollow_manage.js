var userFollow_manage_tool = null; 
$(function () { 
	initUserFollowManageTool(); //建立UserFollowManageObj
	userFollow_manage_tool.init(); //如果需要通过下拉框Search，首先Initialize下拉框的值
	$("#userFollow_manage").datagrid({
		url : 'UserFollow/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "followId",
		sortOrder : "desc",
		toolbar : "#userFollow_manage_tool",
		columns : [[
			{
				field : "followId",
				title : "Recordid",
				width : 70,
			},
			{
				field : "userObj1",
				title : "Followed",
				width : 140,
			},
			{
				field : "userObj2",
				title : "Follower",
				width : 140,
			},
			{
				field : "followTime",
				title : "FollowTime",
				width : 140,
			},
		]],
	});

	$("#userFollowEditDiv").dialog({
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
				if ($("#userFollowEditForm").form("validate")) {
					//Validate表单 
					if(!$("#userFollowEditForm").form("validate")) {
						$.messager.alert("Warning","你Input的Info还有错误！","warning");
					} else {
						$("#userFollowEditForm").form({
						    url:"UserFollow/" + $("#userFollow_followId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("Message","InfoEditSuccessful！");
			                        $("#userFollowEditDiv").dialog("close");
			                        userFollow_manage_tool.reload();
			                    }else{
			                        $.messager.alert("Message",obj.message);
			                    } 
						    }
						});
						//Upload表单
						$("#userFollowEditForm").submit();
					}
				}
			},
		},{
			text : "Cancel",
			iconCls : "icon-redo",
			handler : function () {
				$("#userFollowEditDiv").dialog("close");
				$("#userFollowEditForm").form("reset"); 
			},
		}],
	});
});

function initUserFollowManageTool() {
	userFollow_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj1_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动Input 
					});
					data.splice(0,0,{user_name:"",name:"No limits"});
					$("#userObj1_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj2_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动Input 
					});
					data.splice(0,0,{user_name:"",name:"No limits"});
					$("#userObj2_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#userFollow_manage").datagrid("reload");
		},
		redo : function () {
			$("#userFollow_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#userFollow_manage").datagrid("options").queryParams;
			queryParams["userObj1.user_name"] = $("#userObj1_user_name_query").combobox("getValue");
			queryParams["userObj2.user_name"] = $("#userObj2_user_name_query").combobox("getValue");
			queryParams["followTime"] = $("#followTime").datebox("getValue"); 
			$("#userFollow_manage").datagrid("options").queryParams=queryParams; 
			$("#userFollow_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#userFollowQueryForm").form({
			    url:"UserFollow/OutToExcel",
			});
			//Upload表单
			$("#userFollowQueryForm").submit();
		},
		remove : function () {
			var rows = $("#userFollow_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("Confirm", "Delete the selected entry?", function (flag) {
					if (flag) {
						var followIds = [];
						for (var i = 0; i < rows.length; i ++) {
							followIds.push(rows[i].followId);
						}
						$.ajax({
							type : "POST",
							url : "UserFollow/deletes",
							data : {
								followIds : followIds.join(","),
							},
							beforeSend : function () {
								$("#userFollow_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#userFollow_manage").datagrid("loaded");
									$("#userFollow_manage").datagrid("load");
									$("#userFollow_manage").datagrid("unselectAll");
									$.messager.show({
										title : "Tips",
										msg : data.message
									});
								} else {
									$("#userFollow_manage").datagrid("loaded");
									$("#userFollow_manage").datagrid("load");
									$("#userFollow_manage").datagrid("unselectAll");
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
			var rows = $("#userFollow_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("Warning！", "EditRecord只能选定One数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "UserFollow/" + rows[0].followId +  "/update",
					type : "get",
					data : {
						//followId : rows[0].followId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在Get中...",
						});
					},
					success : function (userFollow, response, status) {
						$.messager.progress("close");
						if (userFollow) { 
							$("#userFollowEditDiv").dialog("open");
							$("#userFollow_followId_edit").val(userFollow.followId);
							$("#userFollow_followId_edit").validatebox({
								required : true,
								missingMessage : "Input Recordid",
								editable: false
							});
							$("#userFollow_userObj1_user_name_edit").combobox({
								url:"UserInfo/listAll",
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
								url:"UserInfo/listAll",
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
			} else if (rows.length == 0) {
				$.messager.alert("Warning！", "Edit One Entry at a Time！", "warning");
			}
		},
	};
}
