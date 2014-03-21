package 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import tw.tuic.TagEvent;
	import tw.tuic.TuicTouchEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import tw.tuic.refpoint;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.display.Stage;
	
	public class TUICdetector extends Sprite
	{
		//private var cEvt:TagEvent;
		private const kArraySize:int = 3;
		private var triangle:Array;
		public var queue:Array = new Array;
		private const tolerance = 10;
		private var count:uint;
		private var pt0:Point;
		private var pt1:Point;
		private var pt2:Point;
		public var angle:Number;
		public var DetectArea:Sprite = new Sprite();
		public var Tag_ID:Array = new Array(3);
		public var arrayid:Number;
		public var debugswitch:Boolean;
		public var clock:Timer = new Timer(50,1);
		private var ball:Sprite = new Sprite();
		private var tuicevt:TuicTouchEvent;
				
		public function TUICdetector(x:Number,y:Number,width:Number,height:Number,debug:Boolean)
		{
			
			triangle = new Array(3);
			DrawDetectArea(x,y,width,height);
			debugswitch = debug;
			clock.addEventListener(TimerEvent.TIMER,clockclock);
			
		}//end of TUICdetector
		
		//-----------------------DrawDetectArea----------------------
		public function DrawDetectArea(dx:Number,dy:Number,dwidth:Number,dheight:Number)
		{
			DetectArea.graphics.beginFill(0xff0000,0.2);
			DetectArea.graphics.drawRect(dx,dy,dwidth,dheight);
			DetectArea.graphics.endFill();
			DetectArea.addEventListener(TouchEvent.TOUCH_BEGIN,pushpoint);
/*			ball.graphics.beginFill(0xff0000);
			ball.graphics.drawCircle(0,0,30);
			ball.graphics.endFill();
			*/
		}//end of DrawDetectArea    

		private function fingerTouch(tuicpt:Point){

				tuicevt = new TuicTouchEvent("TTBegin",true);
				this.dispatchEvent(tuicevt);
				dispatchEvent(tuicevt);
				DetectArea.dispatchEvent(tuicevt);
				
				
		}//fingerTouch
		private function fingerMove(e:TouchEvent){
			//debugText1.text = "fingerTouch"+e.stageX;
			e.currentTarget.startTouchDrag(e.touchPointID, true);
			tuicevt = new TuicTouchEvent("TTMove",true); 
			dispatchEvent(tuicevt);
			e.currentTarget.addEventListener(TouchEvent.TOUCH_END,fingerRemove);
		}

		private function fingerRemove(e:TouchEvent){
			e.currentTarget.stopTouchDrag(e.touchPointID, true);
			tuicevt = new TuicTouchEvent("TTEnd",true); 
			dispatchEvent(tuicevt);
			queue.lenght = 0;
		}

		public function clockclock (e:TimerEvent){

					fingerTouch(queue[0]);
					queue.shift();
					queue.shift();
					queue.shift();
			
		}//clockclock
					
		
		//----------------------Push point into queue-----------------
			
		private function pushpoint(e:TouchEvent)
		{	
			clock.reset();
			clock.start();
			push(new Point(e.stageX,e.stageY));
			function push(pt:Point):void
			{	

				if (queue.length >= kArraySize)
				{	
					//clock.reset();
					queue.shift();
				}
				queue.push(pt);
				if (queue.length == kArraySize)
				{	
					clock.reset();
					recognizeTUIC();
					queue.shift();
					queue.shift();
					queue.shift();
				}
				
				//}//end of push
				//--------------------------Recognize TUIC----------------------
				 function recognizeTUIC()
					{	var cEvt:TagEvent;
						pt0 = queue[0];
						pt1 = queue[1];
						pt2 = queue[2];

						Tag_ID[0] = [110,150,110,150,170,195];
						Tag_ID[1] = [70,90,119,135,140,165];
						Tag_ID[2] = [79,90,124,135,124,135];
						var idnumber:int;
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
										cEvt = new TagEvent("onTag",arrayid);
										idnumber = arrayid;
										
										RefPt();
										dispatchEvent(cEvt);
									
										break;
									}
								}
							}
						}
			

					function RefPt()
					{
						var ref0:refpoint = new refpoint();
						var ref1:refpoint = new refpoint();
						var ref2:refpoint = new refpoint();
						var debugText:TextField = new TextField();
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
						if(arrayid ==0)
							ref0.id = 0;
						else if(arrayid ==1)
							ref0.id = 1;
						else
							ref0.id = 2;
							
						ref0.addEventListener(TouchEvent.TOUCH_MOVE,doMove);
						ref1.addEventListener(TouchEvent.TOUCH_MOVE,doMove);
						ref2.addEventListener(TouchEvent.TOUCH_MOVE,doMove);

						//----------------------TagEvent-----------------
						function doMove(e:TouchEvent)
						{
							e.currentTarget.startTouchDrag(e.touchPointID, true);
							e.currentTarget.addEventListener(TouchEvent.TOUCH_END, doRemove);
							
							rotateAngle();

							var i:Number;
							i = (ref0.x*(ref1.y-ref2.y)+ref1.x*(ref2.y-ref0.y)+ref2.x*(ref0.y-ref1.y))*2;
							var A0 = ref0.x * ref0.x + ref0.y * ref0.y;
							var B0 = ref1.x * ref1.x + ref1.y * ref1.y;
							var C0 = ref2.x * ref2.x + ref2.y * ref2.y;
							cEvt.x = (A0*(ref1.y-ref2.y)+B0*(ref2.y-ref0.y)+C0*(ref0.y-ref1.y))/i;
							cEvt.y = (A0*(ref2.x-ref1.x)+B0*(ref0.x-ref2.x)+C0*(ref1.x-ref0.x))/i;
							cEvt = new TagEvent("moveTag",ref0.id,cEvt.x,cEvt.y);

							if(debugswitch){
							debugText.width = 200;
							debugText.height = 100;
							debugText.multiline = true;
							debugText.wordWrap = true;
							debugText.border = true;

							DetectArea.addChild(debugText);
							debugText.visible = false;

							if (cEvt.x<=(DetectArea.width/2))
							{
								debugText.x = cEvt.x + 150;
								debugText.visible = true;
							}
							else
							{
								debugText.x = cEvt.x - 350;
								debugText.visible = true;
							}
							debugText.y = cEvt.y;
							debugText.text = "Tag ID: " + idnumber + "\nTag.x: " + cEvt.x + "\nTag.y: " + cEvt.y + " \nAngle " + angle;
							//DetectArea.addChild(debugText);
							
							}
							dispatchEvent(cEvt);

						}//end of doMove

						//----------------------Rotate------------------
						function rotateAngle()
						{
							angle = Math.atan2((ref0.y-ref1.y),(ref0.x-ref1.x));
							angle = (angle*180/Math.PI)+180;
						}
						function doRemove(e:TouchEvent)
						{
							e.target.stopTouchDrag(e.touchPointID);
							DetectArea.removeChild(ref0);
							DetectArea.removeChild(ref1);
							DetectArea.removeChild(ref2);
							
							cEvt = new TagEvent("offTag",ref0.id);
							dispatchEvent(cEvt);
							DetectArea.removeChild(debugText);
						}
					}//RefPt
		  		}//end of recognizeTUIC
			}//end of push
		}//end  of pushpoint

		//---------------------AddCustomTag----------------------------
		public function AddCustomTag(e:TouchEvent)
		{
			Tag_ID.push([(triangle[0]-tolerance),(triangle[0]+tolerance),(triangle[1]-tolerance),(triangle[1]+tolerance),(triangle[2]-tolerance),(triangle[2]+tolerance)]);
			//i++;
		}//end of AddCustomTag
	}//edn of TUICdetector

}//end of package
