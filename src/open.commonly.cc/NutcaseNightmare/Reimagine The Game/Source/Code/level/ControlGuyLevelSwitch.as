﻿package level{	import flash.display.MovieClip;	import gamesys.HUDSwitch;		public class ControlGuyLevelSwitch extends ControlGuyLevel	{		var HUD:HUDSwitch;		var holdon:Array;		override public function initGuy():void{			// Initialize HUD			HUD = new HUDSwitch();			gParent.HUD.addChild(HUD);			HUD.init(gCont);			holdon = new Array(gCont.numChildren);			for( var i:uint = 0; i<gCont.numChildren; i++ ){				holdon[i] = false;			}			HUD.switchTo(0);			//gParent.HUD.addChild(HUD);		}		override public function enterFrame():void		{			for( var gi:uint = 0; gi<gCont.numChildren; gi++ ){				// NumPAD: || keys[gi+97]				if( !holdon[gi] && _root.kCont.keys[gi+49] ){					gCont.control = gi;					cam.changeFollow(gCont.kid(gi));					HUD.switchTo(gi);				}				holdon[gi] = _root.kCont.keys[gi+49];			}			super.enterFrame();		}	}}