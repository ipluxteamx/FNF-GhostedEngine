package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GhostedTeamIntroState extends FlxState
{
    var tween:FlxTween;
    
	override public function create()
	{
		bgColor = 0;

		super.create();

        var title = new FlxText(0, 0, FlxG.width, "Ghosted Team", 64);
		title.alignment = CENTER;
		title.screenCenter();
		title.alpha = 0.95;
		add(title);

        FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
        {
            FlxG.switchState(new TitleState());
        });

        if (FlxG.keys.justPressed.ENTER)
            FlxG.switchState(new TitleState());
	}
}
