package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import djFlixel.*;
import djFlixel.gfx.TextBouncer;
import djFlixel.gfx.pal.Pal_CPCBoy;
import flixel.util.FlxTimer;

class GhostedTeamIntroState extends FlxState
{
	override public function create()
	{
		bgColor = 0;

		super.create();

        var lb = new TextBouncer("Ghosted Team", 100, 100, 
		    {f:'assets/fonts/vcr.ttf', s:16, bc:Pal_CPCBoy.COL[2]}, 
		    {time:2, timeL:0.5});
	    add(lb);
        D.align.screen(lb);	// Tip you can aligh this, because the letters are there, with alpha=0
        lb.start(()->{
            trace("Bounce complete");
            FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
            {
                FlxG.switchState(new TitleState());
            });
        });


        var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

        if (pressedEnter)
            FlxG.switchState(new TitleState());
	}
}
