package;

import openfl.Lib;
import Controls.Control;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class ChooseSubState extends MusicBeatSubstate
{

	var curSelected:Int = 1;	
	var selectorImage:FlxSprite;
	var arrowThing:FlxSprite;

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		selectorImage = new FlxSprite(600, 430).loadGraphic(Paths.image('bigChungus'));
		selectorImage.antialiasing = true;
		selectorImage.alpha = 0;
		selectorImage.scrollFactor.set();
		selectorImage.screenCenter();
		add(selectorImage);

		arrowThing = new FlxSprite(600, 430).loadGraphic(Paths.image('arrowLmao'));
		arrowThing.x = selectorImage.x;
		arrowThing.y = selectorImage.y + 196;

		FlxTween.tween(bg, {alpha: 0.8}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(selectorImage, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		var leftP = controls.LEFT_P;
		var rightP = controls.RIGHT_P;
		var accepted = controls.ACCEPT;

		if (leftP && curSelected >= 2)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			curSelected -= 1;
			
		}else if (rightP && curSelected <= 1)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			curSelected += 1;
		}
		if(curSelected == 1)
			arrowThing.x = selectorImage.x - 100;
		else if (curSelected == 2)
			arrowThing.x = selectorImage.x + 100;
			
		if (controls.BACK)
		{
			close();
			LoadingState.loadAndSwitchState(new TitleState());
		}
		if (accepted)
		{
			if(curSelected == 1)
				LoadingState.loadAndSwitchState(new FreeplayState());
			if(curSelected == 2)
				LoadingState.loadAndSwitchState(new FreeplayState());
		}
	}
}