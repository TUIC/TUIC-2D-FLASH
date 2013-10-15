Detail
=============
Another spatial approach, called TUIC-2D-Flash, use a layout similar to TUIC-2D. The figure shows a structure of the tag. A TUIC-Flash tag contains 3 reference points which user can design their own tag. The distance between the three reference points are also used to determine the tag ID.


Hardware
=============
We have implemented a TUIC-Flash tag using Lego and conductive material, which contains a 4×4 grid of touch points within a square frame. The figure shows the user design points, T0, T1, and T2 which are used to determine location and rotation of the TUIC-Flash object. User can also design the tangible's appearance by constructing the Lego brick.


Software
=============
When a touch points is detected, we first check to see if waiting mode is true. Then we set the timer as 30ms. In this period, we continue detect if there is any touch point been detected. If no other touch points are detected, we dispatch it as a touch event. Else, we push these points to queue and set the waiting mode as false. Finally, we will check if the queue is full and start to recognize the tag ID.

Licensed by OSI:Apache License 2.0

How to Use it
=============
step1: download the folder "custom" to your project
step2: add the code as follow to your main.as
-----------------------------------------------------
stop();
import flash.display.Sprite;
import flash.events.TouchEvent;
import tw.tuic.TagEvent;
Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
var detector:TUICdetector = new TUICdetector(0,0,768,1024,true);//add the Tag Detect layer
//setup your DetectArea's size and coordinate areaX,areaY,areaW,areaH,debugmode's on & off
//ex: var detector:TUICdetector = new TUICdetector(0,0,768,1024,false);


stage.addChild(detector.DetectArea);
-----------------------------------------------------
step3:add the EventListener you want to use

detector.addEventListener(TagEvent.ON_TAG,TagOn);
detector.addEventListener(TagEvent.MOVE_TAG,TagMove);
detector.addEventListener(TagEvent.OFF_TAG,TagOff);

