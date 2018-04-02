$(function () {
	$("#itemClass_className").validatebox({
		required : true, 
		missingMessage : 'Input ItemClassName',
	});

	$("#itemClass_classDesc").validatebox({
		required : true, 
		missingMessage : 'Input Class描述',
	});

	//单击Add按钮
	$("#itemClassAddButton").click(function () {
		//Validate表单 
		if(!$("#itemClassAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#itemClassAddForm").form({
			    url:"ItemClass/add",
			    onSubmit: function(){
					if($("#itemClassAddForm").form("validate"))  { 
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
                        $("#itemClassAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#itemClassAddForm").submit();
		}
	});

	//单击清空按钮
	$("#itemClassClearButton").click(function () { 
		$("#itemClassAddForm").form("clear"); 
	});
});
