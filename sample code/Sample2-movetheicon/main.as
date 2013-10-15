import flash.display.Sprite;
import flash.events.TouchEvent;
import tw.tuic.TagEvent;
stop();

Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
var detector:TUICdetector = new TUICdetector(0,0,768,1024,false);
//setup your DetectArea's size and coordinate areaX,areaY,areaW,areaH,debugmode's on & off
//ex:  var detector:TUICdetector = new TUICdetector(0,0,768,1024,false);
stage.addChild(detector.DetectArea);




var drag0:circle = new circle();
drag0.visible = false;

function onTouchBegin(e:TouchEvent)
{
	
}
function onTouchMove(e:TouchEvent)
{
	e.currentTarget.startTouchDrag(e.touchPointID,true);
}
function onTouchEnd(e:TouchEvent)
{
	
}

detector.addEventListener(TagEvent.ON_TAG,TagOn);
detector.addEventListener(TagEvent.MOVE_TAG,TagMove);
detector.addEventListener(TagEvent.OFF_TAG,TagOff);


function TagOn(e:TagEvent)
{
	detector.DetectArea.addChild(drag0);
	var detectvalue:int = 0;
	for(var i=0;i<=e.id;i++){
		detectvalue++;
	}
	
	drag0.gotoAndStop(detectvalue);
	drag0.visible = true;
	drag0.addEventListener(TouchEvent.TOUCH_BEGIN,itemDown);
	function itemDown(e:TouchEvent)
	{
		var targetClass:Class = e.currentTarget.constructor;
		var obj:MovieClip = new targetClass();
		obj.gotoAndStop(detectvalue);
		stage.addChild(obj);
		obj.x = e.currentTarget.x;
		obj.y = e.currentTarget.y;
		obj.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
		obj.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		obj.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
	}

}
function TagMove(e:TagEvent)
{
	if (e.x <= stage.stageWidth/2)
	{
		drag0.x = e.x + 180;
	}
	else
	{
		drag0.x = e.x - 250;

	}
	drag0.y = e.y;
}


function TagOff(e:TagEvent)
{
	detector.DetectArea.removeChild(drag0);
}