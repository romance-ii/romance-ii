/* Check browser support */

function surfTo (url) {
    if (surfLayer && surfLayer.surfThere) {
        surfLayer.style.top = "2em";
        surfLayer.style.left = "1em";
        surfLayer.style.right = "2em";
        surfLayer.style.bottom = "1em";
        surfLayer.style.position = 'fixed';
        surfLayer.surfThere.width = '100%';
        surfLayer.surfThere.height = '100%';
        surfLayer.surfThere.src = url;
    }
    window.open(url);
}

function getWebGL () {
    var gl = null;
    try { gl = canvas.getContext("webgl"); }
    catch (x) { gl = null; }
    if (null == gl) {
        try { gl = canvas.getContext("experimental-webgl"); experimental = true; }
        catch (x) { gl = null; }
    }
    return gl;
}

var gl = getWebGL ();

if (null == gl) {
    navigator.probablyBad = true;
    if (confirm ("You cannot play this game\n\
on this computer (or device)\n\
because it does not have WebGL\n\
graphics capabilities right now.\n\
Would you like to learn how\n\
to enable WebGL?"))
    {
        if (navigator.userAgent.indexOf ("Opera") > -1 &&
            (navigator.userAgent.indexOf ("Linux") > -1 ||
             navigator.userAgent.indexOf ("Win32") > -1 ||
             navigator.userAgent.indexOf ("Win64") > -1 ||
             navigator.userAgent.indexOf ("MacOS") > -1)) {
            window.location = "./help/Opera_enableWebGL.html";
        }
        if (navigator.userAgent.indexOf ("MSIE") > -1 &&
            (navigator.userAgent.indexOf ("Win32") > -1 ||
             navigator.userAgent.indexOf ("Win64") > -1)) {
            window.location = "./help/MSIE_IEWebGL_Plugin.html";
        }
        var surfLayer = document.getElementById("surfLayer");
        if (surfLayer) { surfLayer.style.display = "block"; }
        var url = "http://whatbrowser.org/";
        if ( (navigator.appName == "Netscape" && navigator.userAgent.indexOf("Firefox") > -1)
             || (navigator.appName == "Chrome") ) {
            url = "http://get.webgl.org/";
        }
        surfTo(url);
    }
}

if (navigator.userAgent.indexOf("MSIE") == -1
    && navigator.userAgent.indexOf("Trident") == -1) {
    document.getElementById("getfirefox").style.display = "none";
}


