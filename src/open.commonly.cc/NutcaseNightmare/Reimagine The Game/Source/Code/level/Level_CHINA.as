﻿package level{	import flash.display.MovieClip;	import guy.Guy;	import gamesys.CameraController;	import container.ControlGuyContainer;	public class Level_CHINA extends ControlGuyLevel	{		override public function init():void		{			stop();						super.init();						// Camera			cam = new CameraController(gCont.kid(0),this);			cam.insert( "follow", new Array( 0,0,800,450 ), new Array( 2,0,false,0,70 ) );			// Enterframe			enterFrame();		}				override public function initGuy():void{			gCont = new ControlGuyContainer(guyz);			gCont.add(new Guy("Normal",guy1,this));		}				override public function enterFrame():void		{			super.enterFrame();		}			}}