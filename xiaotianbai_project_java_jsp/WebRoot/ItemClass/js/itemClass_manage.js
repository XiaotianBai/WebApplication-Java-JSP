var itemClass_manage_tool = null; 
$(function () { 
	initItemClassManageTool(); //建立ItemClassManageObj
	itemClass_manage_tool.init(); //如果需要通过下拉框Search，首先Initialize下拉框的值
	$("#itemClass_manage").datagrid({
		url : 'ItemClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "classId",
		sortOrder : "desc",
		toolbar : "#itemClass_manage_tool",
		columns : [[
			{
				field : "classId",
				title : "ItemClassid",
				width : 70,
			},
			{
				field : "className",
				title : "ItemClassName",
				width : 140,
			},
		]],
	});

	$("#itemClassEditDiv").dialog({
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
				if ($("#itemClassEditForm").form("validate")) {
					//Validate表单 
					if(!$("#itemClassEditForm").form("validate")) {
						$.messager.alert("Warning","你Input的Info还有错误！","warning");
					} else {
						$("#itemClassEditForm").form({
						    url:"ItemClass/" + $("#itemClass_classId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#itemClassEditForm").form("validate"))  {
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
			                        $("#itemClassEditDiv").dialog("close");
			                        itemClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("Message",obj.message);
			                    } 
						    }
						});
						//Upload表单
						$("#itemClassEditForm").submit();
					}
				}
			},
		},{
			text : "Cancel",
			iconCls : "icon-redo",
			handler : function () {
				$("#itemClassEditDiv").dialog("close");
				$("#itemClassEditForm").form("reset"); 
			},
		}],
	});
});

function initItemClassManageTool() {
	itemClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#itemClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#itemClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#itemClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#itemClassQueryForm").form({
			    url:"ItemClass/OutToExcel",
			});
			//Upload表单
			$("#itemClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#itemClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("Confirm", "Delete the selected entry?", function (flag) {
					if (flag) {
						var classIds = [];
						for (var i = 0; i < rows.length; i ++) {
							classIds.push(rows[i].classId);
						}
						$.ajax({
							type : "POST",
							url : "ItemClass/deletes",
							data : {
								classIds : classIds.join(","),
							},
							beforeSend : function () {
								$("#itemClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#itemClass_manage").datagrid("loaded");
									$("#itemClass_manage").datagrid("load");
									$("#itemClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "Tips",
										msg : data.message
									});
								} else {
									$("#itemClass_manage").datagrid("loaded");
									$("#itemClass_manage").datagrid("load");
									$("#itemClass_manage").datagrid("unselectAll");
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
			var rows = $("#itemClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("Warning！", "EditRecord只能选定One数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ItemClass/" + rows[0].classId +  "/update",
					type : "get",
					data : {
						//classId : rows[0].classId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在Get中...",
						});
					},
					success : function (itemClass, response, status) {
						$.messager.progress("close");
						if (itemClass) { 
							$("#itemClassEditDiv").dialog("open");
							$("#itemClass_classId_edit").val(itemClass.classId);
							$("#itemClass_classId_edit").validatebox({
								required : true,
								missingMessage : "Input ItemClassid",
								editable: false
							});
							$("#itemClass_className_edit").val(itemClass.className);
							$("#itemClass_className_edit").validatebox({
								required : true,
								missingMessage : "Input ItemClassName",
							});
							$("#itemClass_classDesc_edit").val(itemClass.classDesc);
							$("#itemClass_classDesc_edit").validatebox({
								required : true,
								missingMessage : "Input Class描述",
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
