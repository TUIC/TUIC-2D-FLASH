package tw.tuic {
	import flash.display.*;
	public class refpoint extends MovieClip{
		public var mc1:MovieClip = new MovieClip();
		public var id:int;
		
		public function refpoint() {
			mc1.graphics.lineStyle(1);
			mc1.graphics.beginFill(0xff0000);
			mc1.graphics.drawCircle(0,0,30);
			this.addChild(mc1);
			mc1.graphics.endFill();
		}

	}
	
}
