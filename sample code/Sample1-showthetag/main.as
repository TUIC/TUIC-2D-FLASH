stop();
import flash.display.Sprite;
import flash.events.TouchEvent;
import tw.tuic.TagEvent;
Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
var detector:TUICdetector = new TUICdetector(0,0,768,1024,true);
//setup your DetectArea's size and coordinate areaX,areaY,areaW,areaH,debugmode's on & off
//ex:  var detector:TUICdetector = new TUICdetector(0,0,768,1024,false);

stage.addChild(detector.DetectArea);


detector.addEventListener(TagEvent.ON_TAG,TagOn);
detector.addEventListener(TagEvent.MOVE_TAG,TagMove);
detector.addEventListener(TagEvent.OFF_TAG,TagOff);

function  TagMove(e:TagEvent)
{

}

function TagOn(e:TagEvent)
{
				
}
function TagOff(e:TagEvent)
{
	
}