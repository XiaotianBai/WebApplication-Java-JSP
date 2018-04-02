$(function () {
	$("#productBidding_itemObj_itemId").combobox({
	    url:'Item/listAll',
	    valueField: "itemId",
	    textField: "pTitle",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#productBidding_itemObj_itemId").combobox("getData"); 
            if (data.length > 0) {
                $("#productBidding_itemObj_itemId").combobox("select", data[0].itemId);
            }
        }
	});
	$("#productBidding_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动Input
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#productBidding_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#productBidding_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#productBidding_biddingTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#productBidding_biddingPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : 'Input BiddingPrice',
		invalidMessage : 'BiddingPriceInputIncorrect',
	});

	//单击Add按钮
	$("#productBiddingAddButton").click(function () {
		//Validate表单 
		if(!$("#productBiddingAddForm").form("validate")) {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		} else {
			$("#productBiddingAddForm").form({
			    url:"ProductBidding/add",
			    onSubmit: function(){
					if($("#productBiddingAddForm").form("validate"))  { 
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
                        $("#productBiddingAddForm").form("clear");
                    }else{
                        $.messager.alert("Message",obj.message);
                    }
			    }
			});
			//Upload表单
			$("#productBiddingAddForm").submit();
		}
	});

	//单击清空按钮
	$("#productBiddingClearButton").click(function () { 
		$("#productBiddingAddForm").form("clear"); 
	});
});
