package tw.tuic
{
     import flash.events.Event;
     public class TagEvent extends Event
     {
          
          public static const ON_TAG:String = "onTag";
          public static const OFF_TAG:String = "offTag";
		  public static const MOVE_TAG:String = "moveTag";
		  public static const ROTATE_TAG:String = "rotateTag";
		
          
		  public var x:int;
		  public var y:int;
		   public var id:int;
		  
		  //rotation
		  
		  public var customMessage:String;
		  
          public function TagEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true,stageX:int = 0, stageY:int = 0,TAG_ID:int=0):void
          {

			super(type, bubbles, cancelable);  
			this.x = stageX;
			this.y = stageY;
			this.id = TAG_ID;
          }
		  public function SetID(apple:int){
			  this.id = apple;
		  }
     }
}
