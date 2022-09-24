package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.utils.Assets;

class CreditsState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];
	private var grpControls:FlxTypedGroup<Alphabet>;

	var bg:FlxSprite;

	override function create()
	{
		controlsStrings = CoolUtil.coolStringFile('THATONE PICHU - IDEA' + "\n" + "EVIL BANDITES - CODING" + "\n" + 'DRAKER - COMPOSER' + "\n" + 'COSMIX - CHARTING');
		
		trace(controlsStrings);

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (controls.BACK)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
	

			if (controls.ACCEPT)
			{
				switch(curSelected)
				{
					case 0:
						#if linux
						Sys.command('/usr/bin/xdg-open', ["https://www.youtube.com/channel/UCcwRhYP-ZPgCTAvZZMgouIg", "&"]);
						#else
						FlxG.openURL('https://www.youtube.com/channel/UCcwRhYP-ZPgCTAvZZMgouIg');
						#end
						
					case 1:
						#if linux
						Sys.command('/usr/bin/xdg-open', ["https://www.youtube.com/channel/UCCxBgiE43P1FufiZODI0_uw", "&"]);
						#else
						FlxG.openURL('https://www.youtube.com/channel/UCCxBgiE43P1FufiZODI0_uw');
						#end
					case 2:
						#if linux
						Sys.command('/usr/bin/xdg-open', ["https://www.youtube.com/channel/UCCHzhLksM03P4ge18Qe78Ag", "&"]);
						#else
						FlxG.openURL('https://www.youtube.com/channel/UCCHzhLksM03P4ge18Qe78Ag');
						#end
					case 3:
						#if linux
						Sys.command('/usr/bin/xdg-open', ["https://gamebanana.com/members/1966553", "&"]);
						#else
						FlxG.openURL('https://gamebanana.com/members/1966553');
						#end
				}
			}
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
