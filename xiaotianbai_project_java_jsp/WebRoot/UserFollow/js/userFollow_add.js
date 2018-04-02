$(function () {
	$("#userFollow_userObj1_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#userFollow_userObj1_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#userFollow_userObj1_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#userFollow_userObj2_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#userFollow_userObj2_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#userFollow_userObj2_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#userFollow_followTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击Add按钮
	$("#userFollowAddButton").click(function () {
		//Validate表单 
		if(!$("#userFollowAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#userFollowAddForm").form({
			    url:"UserFollow/add",
			    onSubmit: function(){
					if($("#userFollowAddForm").form("validate"))  { 
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
                        $("#userFollowAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#userFollowAddForm").submit();
		}
	});

	//单击清空按钮
	$("#userFollowClearButton").click(function () { 
		$("#userFollowAddForm").form("clear"); 
	});
});
