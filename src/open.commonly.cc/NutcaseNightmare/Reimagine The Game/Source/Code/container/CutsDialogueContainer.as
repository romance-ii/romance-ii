﻿package container{	import flash.display.MovieClip;	import math.Rect;	import gamesys.Dialogue;		public class CutsDialogueContainer extends Container	{		public function CutsDialogueContainer(mc:MovieClip):void		{			super(mc);		}		public function enterFrame():void		{			var tmp:MovieClip;			for( var i:uint = 0; i<numChildren; i++ ){				tmp = MovieClip(getChildAt(i));				tmp.enterFrame();				if(tmp.killMe){					removeChild(tmp);				}			}		}		public function say(say:String, lifeTime:int, gMC:MovieClip, gH:int=0):void		{			addChild(new Dialogue(say,lifeTime,gMC,gH));		}		}}