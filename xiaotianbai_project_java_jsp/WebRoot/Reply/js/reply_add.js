$(function () {
	$("#reply_postInfoObj_postInfoId").combobox({
	    url:'PostInfo/listAll',
	    valueField: "postInfoId",
	    textField: "pTitle",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#reply_postInfoObj_postInfoId").combobox("getData"); 
            if (data.length > 0) {
                $("#reply_postInfoObj_postInfoId").combobox("select", data[0].postInfoId);
            }
        }
	});
	$("#reply_content").validatebox({
		required : true, 
		missingMessage : 'Input ReplyContent',
	});

	$("#reply_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#reply_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#reply_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#reply_replyTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击Add按钮
	$("#replyAddButton").click(function () {
		//Validate表单 
		if(!$("#replyAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#replyAddForm").form({
			    url:"Reply/add",
			    onSubmit: function(){
					if($("#replyAddForm").form("validate"))  { 
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
                        $("#replyAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#replyAddForm").submit();
		}
	});

	//单击清空按钮
	$("#replyClearButton").click(function () { 
		$("#replyAddForm").form("clear"); 
	});
});
