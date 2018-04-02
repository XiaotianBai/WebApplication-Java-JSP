$(function () {
	$.ajax({
		url : "ItemClass/" + $("#itemClass_classId_edit").val() + "/update",
		type : "get",
		data : {
			//classId : $("#itemClass_classId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在Get中...",
			});
		},
		success : function (itemClass, response, status) {
			$.messager.progress("close");
			if (itemClass) { 
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

	$("#itemClassModifyButton").click(function(){ 
		if ($("#itemClassEditForm").form("validate")) {
			$("#itemClassEditForm").form({
			    url:"ItemClass/" +  $("#itemClass_classId_edit").val() + "/update",
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
			$("#itemClassEditForm").submit();
		} else {
			$.messager.alert("Warning","你Input的Info还有错误！","warning");
		}
	});
});
