/* -*- javascript; set-coding-system: utf-8 -*- */

"use strict";

console.log ("\n\n\n     ***** Violet Volts\n     ***** Game client test/demo\n\n");
console.log ("\n\nStarting Violet Volts: Version " + document.version);

var goatStare = (window.location.hash.indexOf("nogoat") > -1 ? false : true)


var assetPrefix = "./";
console.log ("Asset Prefix: " + assetPrefix);

var canvas = document.getElementById ("canvas");
canvas.width = canvas.clientWidth;
canvas.height = canvas.width * 9/16;
console.log ("Canvas size = " + canvas.width + "✕" + canvas.height);
var startTime = +new Date;

var gameState = { loggedIn: false,
                  playerName: "FrameTestUser",
                  saveAuthToken: true,
                  sidekickBound: false };

document.loaders = {};

function update_loading () {
    var loaded = 0, count = 0;
    for (var key in document.loaders) {
        loaded += document.loaders[ key ];
        ++count;
    }
    var loaderBar = document.getElementById("loader-bar");
    if (0 == count) {
        loaderBar.style.display = "none";
        console.log ("Done loading everything");
    } else {
        loaderBar.style.display = "block";
        loaderBar.setAttribute("loader-value",
                               Math.round(loaded/count * 100));
        console.log ("Loading " + count + " assets, overall status " +
                     Math.round(loaded/count * 100) + "%");
    }
}

function start_loading (key) {
    document.loaders[ key ] = 0;
    console.log ("Started loading asset: " + key);
    update_loading ();
}

function done_loading (key) {
    delete document.loaders[ key ];
    console.log ("Done loading asset: " + key);
    update_loading ();
}

function paperdoll () {
    alert ("Paperdoll function"); // TODO
}

function show_help () {
    alert ("Help goes here."); // TODO
}

function explain_slow () {
    alert (

        "When you see the sad turtle, it means your computer's graphics are\n\
displaying \"slowly.\"\n\
\n\
You might see that characters do not move smoothly, or things appear\n\
to be \"jerky.\"\n\
\n\
This might happen sometimes when you switch to another program, and\n\
then go away after a minute or so.\n\
\n\
If you see it a lot, it could be a problem with your computer\n\
or device.");
    if (confirm ("Would you like to learn more about\n\
how to improve the graphics speed\n\
of your computer/device?")) {
        alert ("I wish I could help. Sorry."); // TODO
    }
}

function log_in () {
    if (document.getElementById("buorgclose")) {
        navigator.probablyBad = true;
    }
    if (navigator.probablyBad) {
        if (confirm ("Your web browser might not\n\
be able to play this game.\n\
\n\
Would you like to download\n\
Firefox first?")) {
            window.open ("http://getfirefox.com/");
            return false;
        }
    }
    if (gameState.loggedIn) {
        return false;
    }
    gameState.playerName  =
        prompt  ("Player name?", gameState.playerName);
    store.enabled && store.set("playerName", gameState.playerName);
    if (gameState.playerName.length > 1) {
        gameState.loggedIn = true;
        document.getElementById ("logIn").style.visibility = "hidden";
        document.getElementById ("addSidekick").style.visibility = "visible";
        document.getElementById ("logOut").style.visibility = "visible";
        console.log ("Logged in as " + gameState.playerName);
        start_render ();
        return true;
    }
    alert ("OK, not logging in then.");
    return false;
}

function add_sidekick () { alert ("Sorry, you can't have a sidekick help you today."); }
function drop_sidekick () { alert ("Right. YOU have a SIDEKICK?"); }

function log_out () {
    if (gameState.loggedIn) {
        gameState.loggedIn = false;
        document.getElementById ("logIn").style.visibility = "visible";
        document.getElementById ("addSidekick").style.visibility = "hidden";
        document.getElementById ("logOut").style.visibility = "hidden";
        alert ("Bye");
        window.location.reload (true);
        return true;
    }
    alert ("You're not logged in.");
    return false;
}

var lookAt=function(origin,point){
    var coord=[origin[0]-point[0],origin[1]-point[1],origin[2]-point[2]];
    var zvec=GLGE.toUnitVec3(coord);
    var xvec=GLGE.toUnitVec3(GLGE.crossVec3([0,1,0],zvec));
    var yvec=GLGE.toUnitVec3(GLGE.crossVec3(zvec,xvec));
    return [xvec[0], yvec[0], zvec[0], 0,
            xvec[1], yvec[1], zvec[1], 0,
            xvec[2], yvec[2], zvec[2], 0,
            0, 0, 0, 1];
}

function check_keys () {
    var keys = new GLGE.KeyInput ();
    if (keys.isKeyPressed (GLGE.KI_ESCAPE)) { paperdoll (); }
    if (keys.isKeyPressed (GLGE.KI_F1)){ show_help (); }
    if (keys.isKeyPressed (GLGE.KI_F3)) { log_in () || log_out (); }
}

var gameScene = null;
var gameRenderer = null;

var cameraPos = [0, 0, 20];

function start_render () {

    gameRenderer = new GLGE.Renderer (canvas);
    var xml = new GLGE.Document ();
    var camera, cameraOffset;
    xml.onLoad = function () {
        gameScene = xml.getElement ("mainscene");
        camera = xml.getElement ("mainCamera");
        cameraOffset = xml.getElement ("cameraOffset");
        var model= xml.getElement ("model");

        /* set the camera rotation */
        camera.setRotMatrix (lookAt ([0, cameraPos [1], 0], [0, 2, -cameraPos [2]]));

        /* load animations after model */
        model.addEventListener ("loaded", function (data) {
            /*
            var anim = document.getElementById ("animations");
            var animations = this.getAnimations ();
            for (var i = 0; i < animations.length; i++) {
                var ele = document.createElement ("div");
                ele.innerHTML = animations[i];
                var that = this;
                ele.onmousedown = function () {
                    that.setMD2Animation (this.innerHTML, true);
                };
                }; */
            
            //draw grid
	    var positions = [];
	    for(var x = -50; x < 50; x++) {
		if (x != 0) {
		    positions.push (x);
                    positions.push (0);
                    positions.push (-50);
		    positions.push (x);
                    positions.push (0);
                    positions.push (50);
		    positions.push (50);
                    positions.push (0);
                    positions.push (x);
		    positions.push (-50);
                    positions.push (0);
                    positions.push (x);
		}
	    }
	    
	    var line = (new GLGE.Object).setDrawType (GLGE.DRAW_LINES);
	    line.setMesh ((new GLGE.Mesh).setPositions (positions));
	    line.setMaterial (xml.getElement ("lines"));
	    gameScene.addObject (line);
            
            var lastFrameTime = 0;
            var accumulatorCount = 0;
            var frameRateAccumulator = 0;
            startTime = parseInt (new Date ().getTime ());

            function render () {
                var now = parseInt (new Date ().getTime ());
                if (Math.round (now - lastFrameTime) % 10 == 0){
                    frameRateAccumulator = Math.round ( ( (frameRateAccumulator * 9) + 1000 / (now - lastFrameTime)) / 10);
                    /* Don't slow down the worst-case by overwriting these
                     * values. Let the faster ones get slowed down a bit,
                     * instead. */
                    var rate = "<big>😦</big> Poor";
                    var rateColour = "#f88";
                    var slow = true;
                    if (frameRateAccumulator >= 60) {
                        rate = "<big>😎</big> Great!";
                        rateColour = "#88f";
                        slow = false;
                    } else if (frameRateAccumulator >= 24) {
                        rate = "<big>😃</big> Good";
                        rateColour = "#8f8";
                        slow = false;
                    } else if (frameRateAccumulator >= 12) {
                        rate = "<big>😶</big> Fair";
                        rateColour = "#ff8";
                        slow = false;
                    }
                    var el = document.getElementById ("framerate");
                    if (accumulatorCount < 50) {
                        ++accumulatorCount;
                        el.innerHTML = "Warming up…";
                        slow = false; /* Probably just warming up the
                                       * accumulator */
                    } else {
                        el.innerHTML = "Graphics: " + rate
                    }
                    el.style.color = rateColour;
                    var turtleIcon = document.getElementById ("webgl_slow");
                    turtleIcon.style.visibility = (slow ? "visible" : "hidden");
                }
                lastFrameTime = now;
                gameRenderer.render ();
            }

            gameRenderer.setScene (gameScene);

            setInterval (render,1);
            setInterval (check_keys,1);

            done_loading ("xml");
            
            var inc = 0.2;

            window.stared_at_goats = function () {
                alert("If you would eMail this report, we would appreciate it.");
                var p = document.createElement ('p');
                var gl = getWebGL();
                var canvas = document.getElementById ("canvas");
                var dur = ((new Date) - startTime);
                var report = "Results of frametest.\n\n"+
                    "(Feel free to leave me a note above this line!)\n\n" +
                    "--------------------\n\nduration=" + dur + 'ms' +
                    "\n\ndemo version=" + document.version +
                    "\n\nplayer name=" + gameState.playerName +
                    "\n\nappCodeName=" + navigator.appCodeName +
                    "\n\nwindow size=" + window.innerWidth + '×' + window.innerHeight +
                    "\n\nscreen size=" + screen.width + '×' + screen.height +
                    "\n\ncanvas size=" + canvas.width + '×' + canvas.height +
                    "\n\nplatform=" + navigator.platform +
                    "\n\nWebGL vendor=" + gl.getParameter(gl.VENDOR) +
                    "\n\nWebGL version=" + gl.getParameter(gl.VERSION) +
                    "\n\nWebGLSL version=" + gl.getParameter(gl.SHADING_LANGUAGE_VERSION) +
                    "\n\nWebGL renderer=" + gl.getParameter(gl.RENDERER) +
                    "\n\nframeRate=" + frameRateAccumulator + " f/s" +
                    "\n\nuser agent string=(" + navigator.userAgent + ")"
                p.innerHTML = "You have stared at imaginary goats for " +
                    Math.round(dur / 1000) + " seconds. " +
                    '<a href="mailto:violetvolts-frametest@star-hope.org?subject=Frametest%20results%20for%20' +
                    encodeURIComponent(navigator.appCodeName +
                                       ' browser on ' + navigator.platform) +
                    '&body=' +
                    encodeURIComponent(report) +
                    '">Click here to eMail your results</a>: <pre>' + report + '</pre>';
                document.getElementById("container").appendChild (p);
            }

            if (goatStare) {
                setTimeout (function () {
                    var button = document.createElement('div');
                    button.innerHTML = '<button onClick="stared_at_goats();">Goats Stared!</button>';
                    document.getElementById("container").appendChild (button);
                }, 60000); }

        })} /* end of onload for xml */
    
    start_loading ("xml");
    xml.parseScript("glge_document");
};

window.onbeforeunload = function (evt) {
    var message = null;
    if (gameState.loggedIn) {
        if (gameState.sidekickBound) {
            message = "If you leave, you and your sidekick will leave Violet Volts.\n\
Are you sure?";
        } else {
            message = "If you leave, you will leave Violet Volts.\n\
Are you sure?";
        }
    }
    var evt = evt || window.event;
    if (message) {
        if (evt) {
            evt.returnValue = message;
        }
        return message;
    }
};


gameState.playerName = store && store.enabled ? store.get("playerName") : "";

console.log ("Done with initial bootstrap");

if (goatStare) {
    alert ("This is a simple framerate test; you won't see much.\n\
\n\
Click \"log in,\" and then wait about a minute.\n\
\n\
Thanks for participating!"); }


