import flash.events.TouchEvent;
import custom.TagEvent;
Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;//set MutiltouchInputMode
var detector:TUICdetector = new TUICdetector();
stage.addChild(detector.DetectArea);//add the Tag Detect layer