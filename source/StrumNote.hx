package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class StrumNote extends FlxSprite
{
	private var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	private var noteData:Int = 0;
	public var direction:Float = 30;//plan on doing scroll directions soon -bb

	public var mania:Int = 1;

	private var player:Int;

	public function new(x:Float, y:Float, leData:Int, player:Int) {
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		noteData = leData;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		var stat:String = Note.NoteData.getAnimation(Note.NoteData.getKeyMap(PlayState.mania, leData, 1), 0);
		var pres:String = Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, leData, 0));

		var skin:String = 'NOTE_assets';
		if(PlayState.isPixelStage) skin = 'PIXEL_' + skin;
		if(PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;

		frames = Paths.getSparrowAtlas(skin);

		antialiasing = ClientPrefs.globalAntialiasing;
		setGraphicSize(Std.int(width * Note.NoteData.getScale(PlayState.SONG.mania)));

		animation.addByPrefix('static', 'arrow' + stat);
		animation.addByPrefix('pressed', pres + ' press', 24, false);
		animation.addByPrefix('confirm', pres + ' confirm', 24, false);

		updateHitbox();
		scrollFactor.set();
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += (width  * noteData);
		//trace((width * Note.NoteData.getScale(PlayState.SONG.mania)) * noteData);
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;

		x -= Note.NoteData.getRestPosition(PlayState.SONG.mania);

		if (PlayState.SONG.mania == 8 || PlayState.SONG.mania == 7 || PlayState.SONG.mania == 6)
			x -= 25;
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		if(animation.curAnim != null){ //my bad i was upset
			if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
				centerOrigin();
			}
		}

		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		if(animation.curAnim == null || animation.curAnim.name == 'static') {
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		} else {
			colorSwap.hue = ClientPrefs.arrowHSV[noteData % Note.NoteData.getAmmo(PlayState.SONG.mania)][0] / 360;
			colorSwap.saturation = ClientPrefs.arrowHSV[noteData % Note.NoteData.getAmmo(PlayState.SONG.mania)][1] / 100;
			colorSwap.brightness = ClientPrefs.arrowHSV[noteData % Note.NoteData.getAmmo(PlayState.SONG.mania)][2] / 100;

			if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
				centerOrigin();
			}
		}
	}
}
