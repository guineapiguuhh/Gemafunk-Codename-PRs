import flixel.text.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;

function create() {
    dropThing = new FlxBackdrop(Paths.image('editors/bgs/charter'));
	dropThing.alpha = 0;
    dropThing.velocity.set(-200, -200);
    dropThing.color = FlxColor.ORANGE;
    add(dropThing);

    g = new FlxText(340, 125, 0, "Agora não amigão!");
    g.setFormat(Paths.font("Comic Sans MS.ttf"), 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    g.borderSize = 5;

    naosei = new FlxText(260, 334, 0, 'Espere até a v1 para ter isso aqui!');
    naosei.setFormat(Paths.font("Comic Sans MS.ttf"), 40, FlxColor.CYAN, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    naosei.borderSize = 4.5;

    naosei2 = new FlxText(70, 384, 0, 'Por agora, só o "Track", "Credits" e a engrenagem funcionam!');
    naosei2.setFormat(Paths.font("Comic Sans MS.ttf"), 40, FlxColor.CYAN, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    naosei2.borderSize = 4.5;

    for (i in [g, naosei, naosei2]) {
        add(i);
        i.alpha = 0;
        i.antialiasing = true;}

    FlxTween.tween(dropThing, {alpha: 0.5}, 0.3, {ease: FlxEase.quartIn});
    for (i in [g, naosei, naosei2]) FlxTween.tween(i, {alpha: 1}, 0.3, {ease: FlxEase.quartIn});
}

function update(elapsed:Float) {
    if (controls.BACK || FlxG.mouse.justPressed) {
        dropThing.velocity.set(0, 0);
        FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {ease: FlxEase.quartOut});
        for (i in [g, naosei, dropThing, naosei2]) FlxTween.tween(i, {alpha: 0}, 0.5, {ease: FlxEase.quartOut}); 
        FlxG.sound.play(Paths.sound('menu/cancel'));
        new FlxTimer().start(0.5, () -> { close(); });
    }
}