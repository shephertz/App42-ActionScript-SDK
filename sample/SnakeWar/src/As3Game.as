package
{
	import Screens.Menu;
	
	import starling.display.Sprite;
	
	public class As3Game extends Sprite
	{
		public function As3Game()
		{
			super();
			
			var menu:Sprite = new Menu();
			this.addChild(menu);
		}
	}
}