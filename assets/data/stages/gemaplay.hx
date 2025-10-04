import openfl.display.BlendMode;
import flixel.addons.display.FlxBackdrop;

var path:String = "stages/quartoGema/";
var colorShader = new CustomShader("adjustColor");
var zoomTween:FlxTween;
var zoomTween2:FlxTween;

function create() {
	defaultCamZoom = 0.8;
}
function postCreate() {
    trace("dad X " + dad.x, "dad Y " + dad.y, "\nbf X " + boyfriend.x, "bf Y " + boyfriend.y, "\n gf X e Y," + gf.x + gf.y);
    colorShader.hue = -40;
	colorShader.saturation = 5;
	colorShader.brightness = -70;

    bg = new FlxSprite(-800, -260).loadGraphic(Paths.image(path + "back"));
    bg.antialiasing = true;
    bg.scale.set(1.1,1.1);

	fg = new FlxSprite(-800, -150).loadGraphic(Paths.image(path + "fore"));
	fg.scrollFactor.set(0.8,0.8);
    fg.scale.set(0.7,0.7);

    estrelas = new FlxBackdrop(Paths.image(path + "estrelas"));
    estrelas.blend = BlendMode.ADD;
	estrelas.scale.set(2, 2);
    estrelas.visible = false;
    estrelas.velocity.set(-200, -200);

    bernardo = new FunkinSprite(boyfriend.x+100, boyfriend.y+330, Paths.image("gemasfunks"));
    bernardo.addAnim('BER IDLE', 'BER IDLE', 24, true);
    bernardo.playAnim('BER IDLE');
    add(bernardo);
bernardo.antialiasing = true;
    bernardo.scale.set(1.5,1.5);

    gema = new FunkinSprite(dad.x-100, dad.y+200, Paths.image("gemasfunks"));
    gema.addAnim('GEMA idle', 'GEMA idle', 24, true);
    gema.playAnim('GEMA idle');
    add(gema);
    gema.antialiasing = true;
    gema.scale.set(1.6,1.6);

    add(fg);
    insert(0, estrelas);
    insert(0, bg);

    dad.alpha = boyfriend.alpha = 0;
}

function stepHit(curStep) {
    switch(curStep) {
        case 413, 1267: zoomTween = FlxTween.tween(camGame, {zoom: 1}, 3, {ease: FlxEase.backinOut});
        case 427, 1280:
            estrelas.visible = true;
            FlxTween.cancelTweensOf(zoomTween);
            for (i in [camGame, camHUD]) {
                zoomTween2 = FlxTween.tween(i, {zoom: 1.2}, 22, {ease: FlxEase.backinOut});
            }
            for (i in [bg, fg]) i.shader = colorShader;
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) elements.visible = false;
        case 640, 1494:
            estrelas.visible = false;
            FlxTween.cancelTweensOf(zoomTween2);
            for (i in [bg, fg]) i.shader = null;
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) elements.visible = true;

    }
}