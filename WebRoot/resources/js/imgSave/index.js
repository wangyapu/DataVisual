;$(document).ready(function(){
	$('.capture').click(function(){
		var target = $(this).attr('cmd');
		var st = $(document).scrollTop();
		console.log(st);
		$('#'+target).html2canvas({},function(imgData,w,h){
			//if(target != 'all'){
			//	$('#'+target).find('.captureResult img').attr('src',imgData).ready(function(){
			//		$(document).scrollTop(st);
			//		console.log(imgData);
			//	}).removeClass('hidden');
			//}else{
				window.open(imgData);
			//}
		});
		return false;
	});
});