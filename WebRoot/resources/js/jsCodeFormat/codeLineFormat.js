
var editor = null;

var cvtToCode = function(){
   $(".CodeMirror").remove();
   editor = CodeMirror.fromTextArea(document.getElementById("code"),{ lineNumbers: true });
   editor.setOption("theme", 'monokai');
}

var getCodeData = function(){
  (new Function(editor.doc.getValue()))();
  if(option==undefined || option== null){
	  alert("并未提取任何可用数据！");
	  throw "并未提取任何可用数据！";
  }
  else{
	  //var jstring = JsonUti.convertToString(option);
	  return option;
  }
}

$(document).ready(function(){
	cvtToCode();
});