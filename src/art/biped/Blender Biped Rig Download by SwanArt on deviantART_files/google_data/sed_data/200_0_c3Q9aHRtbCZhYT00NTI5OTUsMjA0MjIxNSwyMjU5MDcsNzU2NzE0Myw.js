document.write('<!-- Copyright 2008 DoubleClick, a division of Google Inc. All rights reserved. -->\r\n<!-- Code auto-generated on Thu Feb 23 22:04:55 EST 2012 -->\r\n<script src=\"http://s0.2mdn.net/879366/flashwrite_1_2.js\"><\/script>');document.write('\r\n');

function DCFlash(id,pVM){
var swf = "http://s0.2mdn.net/3349269/blurb_taj_300x250.swf";
var gif = "http://s0.2mdn.net/3349269/taj_300x250.gif";
var minV = 10;
var FWH = ' width="300" height="250" ';
var url = escape("http://ad.doubleclick.net/click%3Bh%3Dv8/3ea3/7/e6/%2a/k%3B255565378%3B3-0%3B0%3B98024972%3B4307-300/250%3B46743854/46760327/1%3B%3B%7Esscs%3D%3fhttp://a.rfihub.com/acs/200_0_c3Q9aHRtbCZhYT00NTI5OTUsMjA0MjIxNSwyMjU5MDcsNzU2NzE0MywxNzcyNSwyMDgyNDcsMzkwOTU2NGQwMDAwMGUwNDAwMDAwMTQyODMxZDljNmYscCwxMTg1LDU2NTIxLDIxMTgzNjksNDE4ODEsNzU2NTMmbXQ9MSZyYj0zNDUmcmU9MjA3ODcmZGk9JmFwcD0whttp://lp.blurb.com/taj1?ce=us_display_mi&utm_source=Q22012&utm_medium=display&utm_campaign=msmith_media");
var fscUrl = url;
var fscUrlClickTagFound = false;
var wmode = "opaque";
var bg = "";
var dcallowscriptaccess = "never";

var openWindow = "false";
var winW = 0;
var winH = 0;
var winL = 0;
var winT = 0;

var moviePath=swf.substring(0,swf.lastIndexOf("/"));
var sm=new Array();


var defaultCtVal = escape("http://ad.doubleclick.net/click%3Bh%3Dv8/3ea3/7/e6/%2a/k%3B255565378%3B3-0%3B0%3B98024972%3B4307-300/250%3B46743854/46760327/1%3B%3B%7Esscs%3D%3fhttp://a.rfihub.com/acs/200_0_c3Q9aHRtbCZhYT00NTI5OTUsMjA0MjIxNSwyMjU5MDcsNzU2NzE0MywxNzcyNSwyMDgyNDcsMzkwOTU2NGQwMDAwMGUwNDAwMDAwMTQyODMxZDljNmYscCwxMTg1LDU2NTIxLDIxMTgzNjksNDE4ODEsNzU2NTMmbXQ9MSZyYj0zNDUmcmU9MjA3ODcmZGk9JmFwcD0whttp://lp.blurb.com/taj1?ce=us_display_mi&utm_source=Q22012&utm_medium=display&utm_campaign=msmith_media");
var ctp=new Array();
var ctv=new Array();
ctp[0] = "clickTag";
ctv[0] = "";


var fv='"moviePath='+moviePath+'/'+'&moviepath='+moviePath+'/';
for(i=1;i<sm.length;i++){if(sm[i]!=""){fv+="&submovie"+i+"="+escape(sm[i]);}}
for(var ctIndex = 0; ctIndex < ctp.length; ctIndex++) {
  var ctParam = ctp[ctIndex];
  var ctVal = ctv[ctIndex];
  if(ctVal != null && typeof(ctVal) == 'string') {
    if(ctVal == "") {
      ctVal = defaultCtVal;
    }
    else {
      ctVal = escape("http://ad.doubleclick.net/click%3Bh%3Dv8/3ea3/7/e6/%2a/k%3B255565378%3B3-0%3B0%3B98024972%3B4307-300/250%3B46743854/46760327/1%3B%3B%7Esscs%3D%3fhttp://a.rfihub.com/acs/200_0_c3Q9aHRtbCZhYT00NTI5OTUsMjA0MjIxNSwyMjU5MDcsNzU2NzE0MywxNzcyNSwyMDgyNDcsMzkwOTU2NGQwMDAwMGUwNDAwMDAwMTQyODMxZDljNmYscCwxMTg1LDU2NTIxLDIxMTgzNjksNDE4ODEsNzU2NTMmbXQ9MSZyYj0zNDUmcmU9MjA3ODcmZGk9JmFwcD0w" + ctVal);
    }
    if(ctParam.toLowerCase() == "clicktag") {
      fscUrl = ctVal;
      fscUrlClickTagFound = true;
    }
    else if(!fscUrlClickTagFound) {
      fscUrl = ctVal;
    }
    fv += "&" + ctParam + "=" + ctVal;
  }
}
fv+='"';
var bgo=(bg=="")?"":'<param name="bgcolor" value="#'+bg+'">';
var bge=(bg=="")?"":' bgcolor="#'+bg+'"';
function FSWin(){if((openWindow=="false")&&(id=="DCF0"))alert('openWindow is wrong.');
var dcw = 800;
var dch = 600;
// IE
if(!window.innerWidth)
{
  // strict mode
  if(!(document.documentElement.clientWidth == 0))
  {
    dcw = document.documentElement.clientWidth;
    dch = document.documentElement.clientHeight;
  }
  // quirks mode
  else if(document.body)
  {
    dcw = document.body.clientWidth;
    dch = document.body.clientHeight;
  }
}
// w3c
else
{
  dcw = window.innerWidth;
  dch = window.innerHeight;
}
if(openWindow=="center"){winL=Math.floor((dcw-winW)/2);winT=Math.floor((dch-winH)/2);}window.open(unescape(fscUrl),id,"width="+winW+",height="+winH+",top="+winT+",left="+winL+",status=no,toolbar=no,menubar=no,location=no");}this.FSWin = FSWin;
ua=navigator.userAgent;
if(minV<=pVM&&(openWindow=="false"||(ua.indexOf("Mac")<0&&ua.indexOf("Opera")<0))){
	var adcode='<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="'+id+'"'+FWH+'>'+
		'<param name="movie" value="'+swf+'"><param name="flashvars" value='+fv+'><param name="quality" value="high"><param name="wmode" value="'+wmode+'"><param name="base" value="'+swf.substring(0,swf.lastIndexOf("/"))+'"><PARAM NAME="AllowScriptAccess" VALUE="'+dcallowscriptaccess+'">'+bgo+
		'<embed src="'+swf+'" flashvars='+fv+bge+FWH+' type="application/x-shockwave-flash" quality="high" swliveconnect="true" wmode="'+wmode+'" name="'+id+'" base="'+swf.substring(0,swf.lastIndexOf("/"))+'" AllowScriptAccess="'+dcallowscriptaccess+'"></embed></object>';
  if(('j'!="j")&&(typeof dclkFlashWrite!="undefined")){dclkFlashWrite(adcode);}else{document.write(adcode);}
}else{
	document.write('<a target="_blank" href="'+unescape(url)+'"><img src="'+gif+'"'+FWH+'border="0" alt="Advertisement" galleryimg="no"></a>');
}}
var pVM=0;var DCid=(isNaN("255565378"))?"DCF2":"DCF255565378";
if(navigator.plugins && navigator.mimeTypes.length){
  var x=navigator.plugins["Shockwave Flash"];if(x && x.description){var pVF=x.description;var y=pVF.indexOf("Flash ")+6;pVM=pVF.substring(y,pVF.indexOf(".",y));}}
else if (window.ActiveXObject && window.execScript){
  window.execScript('on error resume next\npVM=2\ndo\npVM=pVM+1\nset swControl = CreateObject("ShockwaveFlash.ShockwaveFlash."&pVM)\nloop while Err = 0\nOn Error Resume Next\npVM=pVM-1\nSub '+DCid+'_FSCommand(ByVal command, ByVal args)\nCall '+DCid+'_DoFSCommand(command, args)\nEnd Sub\n',"VBScript");}
eval("function "+DCid+"_DoFSCommand(c,a){if(c=='openWindow')o"+DCid+".FSWin();}o"+DCid+"=new DCFlash('"+DCid+"',pVM);");
//-->

document.write('\r\n<noscript><a target=\"_blank\" href=\"http://ad.doubleclick.net/click%3Bh%3Dv8/3ea3/7/e6/%2a/k%3B255565378%3B3-0%3B0%3B98024972%3B4307-300/250%3B46743854/46760327/1%3B%3B%7Esscs%3D%3fhttp://a.rfihub.com/acs/200_0_c3Q9aHRtbCZhYT00NTI5OTUsMjA0MjIxNSwyMjU5MDcsNzU2NzE0MywxNzcyNSwyMDgyNDcsMzkwOTU2NGQwMDAwMGUwNDAwMDAwMTQyODMxZDljNmYscCwxMTg1LDU2NTIxLDIxMTgzNjksNDE4ODEsNzU2NTMmbXQ9MSZyYj0zNDUmcmU9MjA3ODcmZGk9JmFwcD0whttp://lp.blurb.com/taj1?ce=us_display_mi&utm_source=Q22012&utm_medium=display&utm_campaign=msmith_media\"><img src=\"http://s0.2mdn.net/3349269/taj_300x250.gif\" width=\"300\" height=\"250\" border=\"0\" alt=\"Advertisement\" galleryimg=\"no\"></a></noscript>\r\n');
