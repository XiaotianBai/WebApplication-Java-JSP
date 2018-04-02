$(function () {
	$("#postInfo_pTitle").validatebox({
		required : true, 
		missingMessage : 'Input PostTitle',
	});

	$("#postInfo_content").validatebox({
		required : true, 
		missingMessage : 'Input PostContent',
	});

	$("#postInfo_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#postInfo_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#postInfo_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#postInfo_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#postInfo_hitNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : 'Input Views',
		invalidMessage : 'ViewsInputIncorrect',
	});

	//单击Add按钮
	$("#postInfoAddButton").click(function () {
		//Validate表单 
		if(!$("#postInfoAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#postInfoAddForm").form({
			    url:"PostInfo/add",
			    onSubmit: function(){
					if($("#postInfoAddForm").form("validate"))  { 
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
                        $("#postInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#postInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#postInfoClearButton").click(function () { 
		$("#postInfoAddForm").form("clear"); 
	});
});
