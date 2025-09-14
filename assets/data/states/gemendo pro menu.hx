import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.CoolUtil;
import flixel.text.FlxTextBorderStyle;
#if mobile //putas na minha cama
import funkin.mobile.controls.FlxDPadMode;
import funkin.mobile.controls.FlxActionMode;
#end

var optionShit:Array<String> = ["storymode", "tracks", "credits", "options", "gallery"];

var menuItems:FlxTypedGroup<FlxSprite>;
var curSelected:Int = 0;
var canSelect:Bool = false;
var canSelectOptions:Bool = false;
public var canAccessDebugMenus:Bool = true;
var camMouse:FlxCamera = new FlxCamera();
var mouse:FunkinSprite;

FlxG.mouseControls = true;
FlxG.mouse.enabled = true;
FlxG.mouse.visible = false;

function create() {
    Conductor.changeBPM(115);
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    FlxG.sound.playMusic(Paths.music("freakyMenu"), 0, true);

    FlxG.cameras.add(camMouse, false);
    camMouse.bgColor = 0x0;


   // FlxG.camera.zoom = 0.3;
    bg = new FlxBackdrop(Paths.image('menus/mainmenu/fundo'));
    bg.velocity.set(-50, 50);
    bg.antialiasing = true;
    bg.scale.set(0.5,0.5);
    add(bg);

    gradiente = new FlxSprite(-320,-400).loadGraphic(Paths.image('menus/mainmenu/gradiente'));
    gradiente.antialiasing = true;
    gradiente.scale.set(0.5,0.5);
	gradiente.scrollFactor.set(3, 3);
    add(gradiente);

    vito = new FlxSprite(600, 29);
    vito.frames = Paths.getSparrowAtlas('menus/mainmenu/vitomenu');
    vito.animation.addByPrefix('idle', 'vito menu', 24, true);
    vito.animation.play('idle'); 
    vito.scrollFactor.set(2, 2);
    vito.antialiasing = true;
    add(vito);

    preto = new FlxSprite(-450,-400).loadGraphic(Paths.image('menus/mainmenu/preto'));
    preto.antialiasing = true;
    preto.scale.set(0.7,0.6);
    add(preto);
    
    menuItems = new FlxTypedGroup();
    add(menuItems);
    for (i in 0...optionShit.length) {
        var menuItem = new FlxSprite(20, 30 + (i * 170));
        menuItem.frames = Paths.getFrames('menus/mainmenu/menushit');
        menuItem.animation.addByPrefix("idle", optionShit[i] + " idle", 24, false);
        menuItem.animation.addByPrefix("selected", optionShit[i] + " selected", 24, false);
        menuItem.animation.play("idle");
        menuItem.ID = i;

        menuItem.scale.set(0.35,0.35);

        menuItems.add(menuItem);
        menuItem.antialiasing = true;
        menuItem.updateHitbox();
    }

    menuItems.members[3].scale.set(0.17,0.17);
    menuItems.members[3].x = -50;
    menuItems.members[3].y = 478;
    menuItems.members[4].scale.set(0.17,0.17);
    menuItems.members[4].x = 140;
    menuItems.members[4].y = 500;

    changeItem();

    mouse = new FunkinSprite(0, 0);
    mouse.frames = Paths.getSparrowAtlas("menus/freeplay/Mouse");
    mouse.animation.addByPrefix("idle", "Idle");
    mouse.animation.addByPrefix("click", "Click", 24, false);
    mouse.playAnim("idle");
    mouse.camera = camMouse;
    mouse.scrollFactor.set();
    add(mouse);
}


function update(elapsed:Float) {
    if (controls.BACK) FlxG.switchState(new TitleState());

    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.028, (1/30)*240*elapsed);
	FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.028, (1/30)*240*elapsed);

    if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * elapsed;


	if (!canSelect) {
        if (mouse.getAnimName() == "click")
            {
                mouse.x = FlxG.mouse.screenX - 10;
                mouse.y = FlxG.mouse.screenY - 8;
            }
            else 
            {
                mouse.x = FlxG.mouse.screenX;
                mouse.y = FlxG.mouse.screenY;
            }
        if (canAccessDebugMenus) {
            if (FlxG.keys.justPressed.SEVEN #if mobile || vPad.buttonY.justPressed #end) {
                persistentUpdate = false;
                persistentDraw = true; 
                openSubState(new EditorPicker());
            }
        }
        if (controls.SWITCHMOD  #if mobile || vPad.buttonX.justPressed #end) {
            openSubState(new ModSwitchMenu());
            persistentUpdate = false;
            persistentDraw = true;
        }

		for (i in menuItems.members) {
			if (FlxG.mouse.overlaps(i)) {
                if (FlxG.mouse.justPressed) selectItem();
				curSelected = menuItems.members.indexOf(i);
				changeItem();
			}
		}
    }
}

function selectItem() {
    mouse.playAnim("click", true);
    canSelect = true;

	FlxG.sound.play(Paths.sound('menu/confirm'));
    FlxTween.tween(FlxG.camera, {zoom: 1.1}, 2, {ease: FlxEase.expoOut});
    FlxG.camera.flash(FlxColor.WHITE, 1);

    new FlxTimer().start(1, () -> {
        var daChoice:String = optionShit[curSelected];

        var event = event("onSelectItem", EventManager.get(NameEvent).recycle(daChoice));
        if (event.cancelled) return;
        switch (daChoice)   {
            case 'storymode': 
                 openSubState(new ModSubState("substate irado"));
                 canSelect = persistentUpdate = false;
                 persistentDraw = true;
            case 'tracks': 
                 FlxG.switchState(new FreeplayState());
            case 'credits': 
                 FlxG.switchState(new ModState("GemaFunkCredits"));
            case 'options': 
                 FlxG.switchState(new OptionsMenu());
            case 'gallery': 
                 openSubState(new ModSubState("substate irado"));
                 canSelect = persistentUpdate = false;
                 persistentDraw = true;
     }});
}

public function changeItem(huh:Int = 0) {
    var event = event("onChangeItem", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + huh, 0, menuItems.length-1), huh, huh != 0));
    if (event.cancelled) return;

    curSelected = event.value;

    menuItems.forEach(function(spr:FlxSprite) { 
        spr.animation.play('idle');
        if (spr.ID == curSelected) { spr.animation.play('selected'); }
    });
}
