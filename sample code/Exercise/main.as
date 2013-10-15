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
detector.addEventListener(TagEvent.OFF_TAG,TagOff);



	
	var h1:Horse = new Horse();
	h1.visible = false;
	h1.x = 300;
	h1.y = 300;

	stage.addChild(h1);
	
	
function TagOn(e:TagEvent)
{
	//tagone.visible = true;
	if(e.id == 1 )
		h1.visible = true;
		
}
function TagOff(e:TagEvent)
{
	h1.visible = false;
}