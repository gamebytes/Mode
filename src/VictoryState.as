package
{
	import org.flixel.*;

	public class VictoryState extends FlxState
	{
		[Embed(source="data/spawner_gibs.png")] private var ImgGibs:Class;
		[Embed(source="data/menu_hit_2.mp3")] private var SndMenu:Class;
		
		private var _timer:Number;
		private var _fading:Boolean;

		override public function create():void
		{
			_timer = 0;
			_fading = false;
			FlxG.flash(0xffd8eba2);
			
			//Gibs emitted upon death
			var gibs:FlxEmitter = new FlxEmitter(0,-50);
			gibs.setSize(FlxG.width,0);
			gibs.setXSpeed();
			gibs.setYSpeed(0,100);
			gibs.setRotation(-360,360);
			gibs.gravity = 80;
			gibs.makeParticles(ImgGibs,800,32,true,0);
			add(gibs);
			gibs.start(false,0,0.005);
			
			var text:FlxText = new FlxText(0,FlxG.height/2-35,FlxG.width,"VICTORY\n\nSCORE: "+FlxG.score);
			text.setFormat(null,16,0xd8eba2,"center");
			add(text);
		}

		override public function update():void
		{
			super.update();
			if(!_fading)
			{
				_timer += FlxG.elapsed;
				if((_timer > 0.35) && ((_timer > 10) || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C")))
				{
					_fading = true;
					FlxG.play(SndMenu);
					FlxG.fade(0xff131c1b,2,onPlay);
				}
			}
		}
		
		private function onPlay():void 
		{
			FlxG.switchState(new PlayState());
		}
	}
}