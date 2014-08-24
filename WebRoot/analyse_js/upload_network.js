var upld = null;
function send() {
	var swfu=new SWFUpload({
		file_post_name:"doc",
		upload_url:"imgupload.action",
		/*post_params: {  
            "headname" : headname  
        }, */ 
        use_query_string : true,
		button_placeholder_id:"spanButtonPlaceholder",
		button_width:80,
		button_height:30,
		button_text:"<span class='t'>浏览图片：</span>",
		button_text_style:".t{font-size:16px;color:#3399ff;font-family:'微软雅黑';line-height:30px}",
		button_cursor:SWFUpload.CURSOR.HAND,
		flash_url:spath+"/resources/swfupload/swfupload.swf",
		//button_image_url:spath+"/resources/swfupload/aa.jpg",
		file_upload_limit:10,
		file_size_limit:"10GB",
		file_types:"*.png;*.jpg;*.jpeg",
		file_types_description:"图片类型",
		file_dialog_complete_handler:fileDialogComplete,
		file_queued_handler:fileQueued,
		file_queue_error_handler : fileQueueError,
		upload_success_handler : uploadSuccess
	});
	function fileDialogComplete(numFilesSelected,numFilesQueued,numFilesInQueued)
	{
		$("#f").show();
	}	
	function fileQueued(file)
	{	
		var name=file.name;
		var dsize=(file.size)/1024.0/1024.0;
		var size="("+dsize.toFixed(2)+"MB)";
		var a="<a href='javascript:void();' id='"+ file.id +"' name = '" + name + "'>删除</a>";
		$("#f").html("<div>"+name + size + " " + a+"</div>");
	}
	function fileQueueError(file, errorCode, message) {
		try {
			switch (errorCode) {
			case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
				alert("文件不能包含超过10个附件！");
				break;
			case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
				alert("单个附件不能超过50M！");
				break;
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
				alert("附件不能是空文件！");
				break;
			case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
				alert("附件类型不支持上传！");
				break;
			default:
				if (file !== null) {
					alert("附件上传异常！");
				}
				break;
			}
		} catch (ex) {
	        this.debug(ex);
	    }
	}   	
	function uploadSuccess(file, serverData) {
		var f=serverData.split(",");
		$("#easyDialogBox").remove();
		$("#overlay").remove();
		
		var ur = decodeURI(f[1]);
		ur = ur.substring(ur.indexOf("headimg", 0)+8, ur.length);
		//alert(decodeURI(f[0])+"   "+decodeURI(f[1]));
		callbackF(ur);
	}
	
	$("#button").click(function() {
		upld();
	});
	
	var upld = function(){
		var headname=$("#headname").val();
		swfu.setPostParams({
              'headname': encodeURI(headname)
        });
		swfu.startUpload();
	}
	
	$("#newFiles a").live("click", function() {
		$(this).parent().remove();
		swfu.cancelUpload($(this).attr("id"),false);
	});	
}

