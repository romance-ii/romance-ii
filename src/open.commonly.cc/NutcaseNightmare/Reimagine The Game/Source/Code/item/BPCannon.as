﻿package item{	import flash.display.MovieClip;	import flash.geom.Point;	import particle.Projectile;		public class BPCannon extends Cannon	{		public function BPCannon(mClip:MovieClip,g:MovieClip,str:Number=3):void		{			super(new Level_BP_Cannon(),mClip,g,str);		}		override public function enterFrame():void		{			mc.nextFrame();			if(mc.currentFrame>10){				checkGuy();				checkOil();			}		}		public function fireUp():void{			mc.gotoAndStop("Shoot");		}				var o:Projectile;		protected function checkOil():void		{			for (var gi:int = 0; gi < gameRoot.oCont.numChildren; gi++) {				o = Projectile(gameRoot.oCont.getChildAt(gi));				stagePoint = gameRoot.localToGlobal(new Point(o.x,o.y));				if( mc.fire.hitTestPoint(stagePoint.x,stagePoint.y,true) )				{					forceDir.set(o.x-x,o.y-y);					forceDir.mult(strength/forceDir.mag);					with(o){						vel.add(forceDir.x,forceDir.y);					}				}			}		}	}}