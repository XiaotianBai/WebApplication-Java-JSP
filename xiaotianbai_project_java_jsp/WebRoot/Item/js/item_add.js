$(function () {
	$("#item_itemClassObj_classId").combobox({
	    url:'ItemClass/listAll',
	    valueField: "classId",
	    textField: "className",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#item_itemClassObj_classId").combobox("getData"); 
            if (data.length > 0) {
                $("#item_itemClassObj_classId").combobox("select", data[0].classId);
            }
        }
	});
	$("#item_pTitle").validatebox({
		required : true, 
		missingMessage : 'Input Item Title',
	});

	$("#item_itemDesc").validatebox({
		required : true, 
		missingMessage : 'Input ItemDescription',
	});

	$("#item_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#item_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#item_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#item_startPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : 'Input StartPrice',
		invalidMessage : 'StartPriceInputIncorrect',
	});

	$("#item_startTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#item_endTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击Add按钮
	$("#itemAddButton").click(function () {
		//Validate表单 
		if(!$("#itemAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#itemAddForm").form({
			    url:"Item/add",
			    onSubmit: function(){
					if($("#itemAddForm").form("validate"))  { 
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
                        $("#itemAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#itemAddForm").submit();
		}
	});

	//单击清空按钮
	$("#itemClearButton").click(function () { 
		$("#itemAddForm").form("clear"); 
	});
});
