$(function () {
	$.ajax({
		url : "Item/" + $("#item_itemId_edit").val() + "/update",
		type : "get",
		data : {
			//itemId : $("#item_itemId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在Get中...",
			});
		},
		success : function (item, response, status) {
			$.messager.progress("close");
			if (item) { 
				$("#item_itemId_edit").val(item.itemId);
				$("#item_itemId_edit").validatebox({
					required : true,
					missingMessage : "Input Itemid",
					editable: false
				});
				$("#item_itemClassObj_classId_edit").combobox({
					url:"../ItemClass/listAll",
					valueField:"classId",
					textField:"className",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#item_itemClassObj_classId_edit").combobox("select", item.itemClassObjPri);
						//var data = $("#item_itemClassObj_classId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#item_itemClassObj_classId_edit").combobox("select", data[0].classId);
						//}
					}
				});
				$("#item_pTitle_edit").val(item.pTitle);
				$("#item_pTitle_edit").validatebox({
					required : true,
					missingMessage : "Input Item Title",
				});
				$("#item_itemPhoto").val(item.itemPhoto);
				$("#item_itemPhotoImg").attr("src", "../" +　item.itemPhoto);
				$("#item_itemDesc_edit").val(item.itemDesc);
				$("#item_itemDesc_edit").validatebox({
					required : true,
					missingMessage : "Input ItemDescription",
				});
				$("#item_userObj_user_name_edit").combobox({
					url:"../UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动Input 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#item_userObj_user_name_edit").combobox("select", item.userObjPri);
						//var data = $("#item_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#item_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#item_startPrice_edit").val(item.startPrice);
				$("#item_startPrice_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "Input StartPrice",
					invalidMessage : "StartPriceInputIncorrect",
				});
				$("#item_startTime_edit").datetimebox({
					value: item.startTime,
					required: true,
					showSeconds: true,
				});
				$("#item_endTime_edit").datetimebox({
					value: item.endTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("GetFailed！", "Unkown failure, please retry!", "warning");
			}
		}
	});

	$("#itemModifyButton").click(function(){ 
		if ($("#itemEditForm").form("validate")) {
			$("#itemEditForm").form({
			    url:"Item/" +  $("#item_itemId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#itemEditForm").form("validate"))  {
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
			$("#itemEditForm").submit();
		} else {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		}
	});
});
