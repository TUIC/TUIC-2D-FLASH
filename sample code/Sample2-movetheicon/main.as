stop();
import flash.display.Sprite;
import flash.events.TouchEvent;
import tw.tuic.TagEvent;
import tw.tuic.TuicTouchEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.display.Stage;


Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
var detector:TUICdetector = new TUICdetector(0,0,768,1024,false);
//setup your DetectArea's size and coordinate areaX,areaY,areaW,areaH,debugmode's on & off
//ex:  var detector:TUICdetector = new TUICdetector(0,0,768,1024,false);
stage.addChild(detector.DetectArea);


detector.addEventListener(TagEvent.ON_TAG,TagOn);

var idol0:CIRCLE_0 = new CIRCLE_0();
var idol1:CIRCLE_1 = new CIRCLE_1();
var idol2:CIRCLE_2 = new CIRCLE_2();

var ArrIdol:Array = [idol0,idol1,idol2];

const positionshiftY:Number = -230 ;

function TagOn(e:TagEvent){

	ArrIdol[e.id].x = e.x;
	ArrIdol[e.id].y = e.y+positionshiftY;
	ArrIdol[e.id].visible = false;
	stage.addChild(ArrIdol[e.id]);
	
	detector.addEventListener(TagEvent.MOVE_TAG,TagMove);
	detector.addEventListener(TagEvent.OFF_TAG,TagOff);
	ArrIdol[e.id].addEventListener(TouchEvent.TOUCH_BEGIN,dragItem);
	ArrIdol[e.id].addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
}

function dragItem(e:TouchEvent)
{	
		var targetClass:Class = e.currentTarget.constructor;
		var obj:MovieClip = new targetClass();
		
		obj.x = e.currentTarget.x;
		obj.y = e.currentTarget.y;
		stage.addChild(obj);
		e.currentTarget.visible = false;
		obj.addEventListener(TouchEvent.TOUCH_BEGIN, dragItem);
		obj.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
}	

function onTouchMove(e:TouchEvent)
{	
	e.currentTarget.startTouchDrag(e.touchPointID,true);
	e.currentTarget.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
	
}

function onTouchEnd(e:TouchEvent)
{	
	e.currentTarget.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
	e.target.stopTouchDrag(e.touchPointID);
	
}	

function TagMove(e:TagEvent){
	ArrIdol[e.id].visible = true;
	
	if(e.id ==0){
	ArrIdol[0].x = e.x;
	ArrIdol[0].y = e.y+positionshiftY;
	}
	else if (e.id ==1){
	ArrIdol[1].x = e.x;
	ArrIdol[1].y = e.y+positionshiftY;
	}
	else if (e.id ==2){
	ArrIdol[2].x = e.x;
	ArrIdol[2].y = e.y+positionshiftY;
	}
}
function TagOff(e:TagEvent){
	stage.removeChild(ArrIdol[e.id]);

}
