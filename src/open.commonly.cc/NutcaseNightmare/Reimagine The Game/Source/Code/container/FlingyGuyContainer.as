﻿package container{	import flash.display.MovieClip;	import guy.Guy;	public class FlingyGuyContainer extends GuyContainer	{		public function FlingyGuyContainer(mc:MovieClip):void		{			super(mc);		}		override public function enterFrame(mc:MovieClip):void		{			for (var i:uint=0; i < numChildren; i++) {			 	var g:Guy = Guy(getChildAt(i));				mc.setGravity(g.x,g.y,g.acc);				with(g){					handleMove();					handleGround();				}			}		}	}}