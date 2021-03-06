package Screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends Sprite
	{
		private var score:int;
		public function GameOver(s:int)
		{
			super();
			score = s;
			new App42LeaderBoard().saveUserScore(score);
			var bg:Image = new Image(Assets.getTextue("bg"));
			this.addChild(bg);
			
			var logo:Image = new Image(Assets.getTextue("logo"));
			logo.x = 85;
			logo.y = 50;
			this.addChild(logo);
			
			var gameover:Image = new Image(Assets.getTextue("gameover"));
			gameover.x = 320;
			gameover.y = 300;
			this.addChild(gameover);
			
			var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 440;
			this.addChild(msg);
			
			var btn:Button = new Button(Assets.getTextue("menubtn"));
			btn.x = 345;
			btn.y = 330;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, menuBtn_Click);
		}
		
		public function menuBtn_Click(event:Event):void
		{
			var screen:Sprite = new Menu;
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
	}
}