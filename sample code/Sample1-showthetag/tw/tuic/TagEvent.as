package tw.tuic
{
    import flash.events.Event;
    public class TagEvent extends Event
    {
          public static const ON_TAG:String = "onTag";
          public static const OFF_TAG:String = "offTag";
		  public static const MOVE_TAG:String = "moveTag";
		  public static const ROTATE_TAG:String = "rotateTag";
		
          
		  public var x:Number;
		  public var y:Number;
		  public var id:Number;
		  //public function TagEvent(type:String, Tag_ID:int,stageX:int, stageY:int,bubbles:Boolean=true, cancelable:Boolean=false):void
			public function TagEvent(type:String,Tag_ID:Number = NaN,stageX:Number=NaN, stageY:Number=NaN,bubbles:Boolean=true, cancelable:Boolean=false):void
		 	{

			super(type, bubbles, cancelable);  
			this.x = stageX;
			this.y = stageY;
			this.id = Tag_ID;
         	}

     }
}
