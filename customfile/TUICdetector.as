package 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.events.*;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import tw.tuic.TagEvent;
	import flash.text.TextField;
	import tw.tuic.refpoint;

	public class TUICdetector extends Sprite
	{
		private var cEvt:TagEvent;
		private const kArraySize:int = 3;

		private var triangle:Array;

		public var queue:Array = new Array(3);

		private const tolerance = 10;
		private var count:uint;

		private var pt0:Point;
		private var pt1:Point;
		private var pt2:Point;

		public var angle:Number;
		public var DetectArea:Sprite = new Sprite();
		public var Tag_ID:Array = new Array(2);
		public var arrayid:Number;
		public var debugText:TextField = new TextField();
		public var haha:MovieClip = new MovieClip();
		public var debugswitch:Boolean;

		public function TUICdetector(x:Number,y:Number,width:Number,height:Number,debug:Boolean)
		{
			queue = new Array();
			triangle = new Array(3);
			DrawDetectArea(x,y,width,height);
			DebugModeSwitch(debug);
						
		}


		//-----------------------DrawDetectArea----------------------
		public function DrawDetectArea(dx:Number,dy:Number,dwidth:Number,dheight:Number)
		{
			DetectArea.graphics.beginFill(0xff0000,0.1);
			DetectArea.graphics.drawRect(dx,dy,dwidth,dheight);
			DetectArea.graphics.endFill();
			DetectArea.addEventListener(TouchEvent.TOUCH_BEGIN,pushpoint);
				
		}
		
		
		
		public function DebugModeSwitch(i:Boolean){
			if(i)
			{
				debugText.width = 200;
				debugText.height = 100;
				debugText.multiline = true;
				debugText.wordWrap = true;
				debugText.border = true;
				//debugText.embedFonts = true;
				//debugText.visible = true;
				//ref0.alpha = ref1.alpha = ref2.alpha = 100;
				DetectArea.addChild(debugText);
				debugText.visible = false;
				//debugText.text = "Tag ID: \nTag.x:   Tag.y: \nAngle ";
				}
			else
			{
				debugText.visible = false;
			}
				
		}
				
		//----------------------Push point into queue-----------------
		private function pushpoint(event:TouchEvent)
		{
			push(new Point(event.stageX,event.stageY));
		}


		private function push(pt:Point):void
		{
			if (queue.length >= kArraySize)
			{
				queue.shift();
			}
			queue.push(pt);
			if (queue.length == kArraySize)
			{
				recognizeTUIC();
			}

		}//end of push
		//--------------------------Recognize TUIC----------------------
		public function recognizeTUIC()
		{
			pt0 = queue[0];
			pt1 = queue[1];
			pt2 = queue[2];

			Tag_ID[0] = [110,150,110,150,170,195];
			Tag_ID[1] = [70,90,119,135,140,165];
			Tag_ID[2] = [79,90,124,135,124,135];

			var dist0:Number = Point.distance(pt0,pt1);
			var dist1:Number = Point.distance(pt1,pt2);
			var dist2:Number = Point.distance(pt2,pt0);
			triangle[0] = dist0;
			triangle[1] = dist1;
			triangle[2] = dist2;
			triangle.sort(Array.NUMERIC);

			for (arrayid=0; arrayid<Tag_ID.length; arrayid++)
			{
				if (triangle[2] > Tag_ID[arrayid][4] && triangle[2] < Tag_ID[arrayid][5])
				{

					if (triangle[1] > Tag_ID[arrayid][2] && triangle[1] < Tag_ID[arrayid][3])
					{
						if (triangle[0] > Tag_ID[arrayid][0] && triangle[0] < Tag_ID[arrayid][1])
						{
							cEvt = new TagEvent("onTag");
							cEvt.SetID(arrayid);
							RefPt();
							dispatchEvent(cEvt);
							break;
						}
					}
				}
			}
		}//end of recognizeTUIC


		//---------------------AddCustomTag----------------------------
		public function AddCustomTag(e:TouchEvent)
		{

			Tag_ID.push([(triangle[0]-tolerance),(triangle[0]+tolerance),(triangle[1]-tolerance),(triangle[1]+tolerance),(triangle[2]-tolerance),(triangle[2]+tolerance)]);

			//i++;
		}


		//----------------debug mode------------------------------
		private var ref0:refpoint1 = new refpoint1();
		private var ref1:refpoint1 = new refpoint1();
		private var ref2:refpoint1 = new refpoint1();

/*		public function DebugMode(e:TouchEvent)
		{

			if (e.currentTarget.currentFrame == 1)
			{
				e.currentTarget.gotoAndStop(2);
				ref0.alpha = ref1.alpha = ref2.alpha = 100;
			}
			else
			{
				e.currentTarget.gotoAndStop(1);
				ref0.alpha = ref1.alpha = ref2.alpha = 0;
			}


		}*/
		//DetectArea.addEventListener(TagEvent.ON_TAG,TagOn);
		public function RefPt()
		{
			DetectArea.addChild(ref0);
			DetectArea.addChild(ref1);
			DetectArea.addChild(ref2);
			ref0.alpha = ref1.alpha = ref2.alpha = 0;
			ref0.x = pt0.x;
			ref0.y = pt0.y;
			ref1.x = pt1.x;
			ref1.y = pt1.y;
			ref2.x = pt2.x;
			ref2.y = pt2.y;
			ref0.addEventListener(TouchEvent.TOUCH_MOVE,doMove);
			ref1.addEventListener(TouchEvent.TOUCH_MOVE,doMove);
			ref2.addEventListener(TouchEvent.TOUCH_MOVE,doMove);
		}



		//----------------------TagEvent-----------------
		public function doMove(e:TouchEvent)
		{
			e.currentTarget.startTouchDrag(e.touchPointID, true);
			e.currentTarget.addEventListener(TouchEvent.TOUCH_END, doRemove);
			RotateAngle();
			
			cEvt = new TagEvent("moveTag");
			/*
			cEvt.x = (ref0.x + ref1.x + ref2.x) / 3;
			cEvt.y = (ref0.y + ref1.y + ref2.y) / 3;*/
			var i:Number;
			i = (ref0.x*(ref1.y-ref2.y)+ref1.x*(ref2.y-ref0.y)+ref2.x*(ref0.y-ref1.y))*2;
			var A0 = ref0.x * ref0.x + ref0.y * ref0.y;
			var B0 = ref1.x * ref1.x + ref1.y * ref1.y;
			var C0 = ref2.x * ref2.x + ref2.y * ref2.y;
			cEvt.x = (A0*(ref1.y-ref2.y)+B0*(ref2.y-ref0.y)+C0*(ref0.y-ref1.y))/i;
			cEvt.y = (A0*(ref2.x-ref1.x)+B0*(ref0.x-ref2.x)+C0*(ref1.x-ref0.x))/i;
			//cEvt.customMessage = "Tag move ";
			debugText.visible = true;
		if(cEvt.x<=(DetectArea.width/2))
			debugText.x = cEvt.x+150;
		else
			debugText.x = cEvt.x-350;
			
     	debugText.y = cEvt.y;
		debugText.text = "Tag ID: "+arrayid+"\nTag.x: " + cEvt.x + "   Tag.y: " +cEvt.y+ " \nAngle " +angle;
			//DetectArea.addChild(debugText);
			dispatchEvent(cEvt);
		}
		
		//----------------------Rotate------------------
		public function RotateAngle()
		{
			angle = Math.atan2((ref0.y-ref1.y),(ref0.x-ref1.x));
			angle = (angle*180/Math.PI)+180;
		}
		public function doRemove(e:TouchEvent)
		{
			e.target.stopTouchDrag(e.touchPointID);
			queue[0] = null;
			queue[1] = null;
			queue[2] = null;
			cEvt = new TagEvent("offTag");
			debugText.visible = false;
			dispatchEvent(cEvt);
			
			DetectArea.removeChild(DisplayObject(e.currentTarget));
		}

	}//edn of TUICdetector

}//end of package