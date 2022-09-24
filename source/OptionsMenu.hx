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
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;
	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGMagenta'));
		controlsStrings = CoolUtil.coolStringFile((FlxG.save.data.dfjk ? 'DFJK scheme on' : 'DFJK scheme off') + "\n" + (FlxG.save.data.qwop ? 'QWOP scheme on' : 'QWOP scheme off') + "\n" + (FlxG.save.data.ghkl ? 'GHKL scheme on' : 'GHKL scheme off') + "\n" + (FlxG.save.data.asdf ? 'ASDF scheme on' : 'ASDF scheme off') + "\n" + (FlxG.save.data.InputSystem ? "New input on" : "New input off") + "\n" + (FlxG.save.data.downscroll ? 'Downscroll on' : 'Downscroll off') + "\nFlipped Arrows " + (FlxG.save.data.flipped ? "on" : "off") + "\nAlt Arrows " + (FlxG.save.data.notes2 ? "on" : "off") + "\nInfo System " + (FlxG.save.data.info ? "modding plus" : "new") + "\nMII MODE " + (FlxG.save.data.mii ? "on" : "off"));
		
		trace(controlsStrings);

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


		versionShit = new FlxText(5, FlxG.height - 18, 0, "Offset (Left, Right): " + FlxG.save.data.offset, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

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
			
			if (controls.RIGHT_R)
			{
				FlxG.save.data.offset++;
				versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;
			}

			if (controls.LEFT_R)
				{
					FlxG.save.data.offset--;
					versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;
				}
	

			if (controls.ACCEPT)
			{
				grpControls.remove(grpControls.members[curSelected]);
				switch(curSelected)
				{
					case 0:
						FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.dfjk ? 'DFJK scheme on' : 'DFJK scheme off'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected;
						grpControls.add(ctrl);
						if (FlxG.save.data.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else if (FlxG.save.data.qwop)
							controls.setKeyboardScheme(KeyboardScheme.qwop, true);
						else if (FlxG.save.data.ghkl)
							controls.setKeyboardScheme(KeyboardScheme.ghkl, true);
						else if (FlxG.save.data.asdf)
							controls.setKeyboardScheme(KeyboardScheme.asdf, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

					case 1:
						FlxG.save.data.qwop = !FlxG.save.data.qwop;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.qwop ? 'QWOP scheme on' : 'QWOP scheme off'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 1;
						grpControls.add(ctrl);
						if (FlxG.save.data.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else if (FlxG.save.data.qwop)
							controls.setKeyboardScheme(KeyboardScheme.qwop, true);
						else if (FlxG.save.data.ghkl)
							controls.setKeyboardScheme(KeyboardScheme.ghkl, true);
						else if (FlxG.save.data.asdf)
							controls.setKeyboardScheme(KeyboardScheme.asdf, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

					case 2:
						FlxG.save.data.ghkl = !FlxG.save.data.ghkl;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.ghkl ? 'GHKL scheme on' : 'GHKL scheme off'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 2;
						grpControls.add(ctrl);
						if (FlxG.save.data.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else if (FlxG.save.data.qwop)
							controls.setKeyboardScheme(KeyboardScheme.qwop, true);
						else if (FlxG.save.data.ghkl)
							controls.setKeyboardScheme(KeyboardScheme.ghkl, true);
						else if (FlxG.save.data.asdf)
							controls.setKeyboardScheme(KeyboardScheme.asdf, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

					case 3:
						FlxG.save.data.asdf = !FlxG.save.data.asdf;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.asdf ? 'ASDF scheme on' : 'ASDF scheme off'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						if (FlxG.save.data.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else if (FlxG.save.data.qwop)
							controls.setKeyboardScheme(KeyboardScheme.qwop, true);
						else if (FlxG.save.data.ghkl)
							controls.setKeyboardScheme(KeyboardScheme.ghkl, true);
						else if (FlxG.save.data.asdf)
							controls.setKeyboardScheme(KeyboardScheme.asdf, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);
						
					case 4:
						FlxG.save.data.InputSystem = !FlxG.save.data.InputSystem;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.InputSystem ? "New input on" : "New input off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 4;
						grpControls.add(ctrl);
					case 5:
						FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.downscroll ? 'Downscroll on' : 'Downscroll off'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 5;
						grpControls.add(ctrl);
					case 6:
						FlxG.save.data.flipped = !FlxG.save.data.flipped;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Flipped Arrows " + (FlxG.save.data.flipped ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 6;
						grpControls.add(ctrl);
					case 7:
						FlxG.save.data.notes2 = !FlxG.save.data.notes2;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Alt Arrows " + (FlxG.save.data.notes2 ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 7;
						grpControls.add(ctrl);
					case 8:
						FlxG.save.data.info = !FlxG.save.data.info;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Info System " + (FlxG.save.data.info ? "modding plus" : "new"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 8;
						grpControls.add(ctrl);
					case 9:
						FlxG.save.data.mii = !FlxG.save.data.mii;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "MII MODE " + (FlxG.save.data.mii ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 9;
						grpControls.add(ctrl);
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
