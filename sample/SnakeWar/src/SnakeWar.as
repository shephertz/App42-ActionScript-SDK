package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60" , width="800", height="480")]
	
	public class SnakeWar extends Sprite
	{
		private var mystarling:Starling;
		
		public function SnakeWar()
		{
			mystarling = new Starling(As3Game, stage);
			mystarling.antiAliasing = 2;
			mystarling.start();
		}
	}
}