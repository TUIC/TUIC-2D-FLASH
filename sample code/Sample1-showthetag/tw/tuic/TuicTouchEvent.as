package tw.tuic
{
	import flash.events.Event;
	//import flash.events.TouchEvent;
	import flash.display.Stage;
	public class TuicTouchEvent extends Event
	{
		  public static const TUIC_TOUCH_BEGIN:String = "TTBegin";
          public static const TUIC_TOUCH_MOVE:String = "TTMove";
		  public static const TUIC_TOUCH_END:String = "TTEnd";
		  public static const TUIC_TOUCH_TAP:String = "TTTap";
		  public var x:Number;
		  public var y:Number;

		
		public function TuicTouchEvent(type:String,bubbles:Boolean=true, cancelable:Boolean=false,stageX:Number=NaN,stageY:Number=NaN) {
			
			super(type, bubbles, cancelable);  
			this.x = stageX;
			this.y = stageY;
		}

	}
	
}
