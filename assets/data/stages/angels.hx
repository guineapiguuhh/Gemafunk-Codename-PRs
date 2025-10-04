import openfl.display.BlendMode;
import flixel.addons.display.FlxBackdrop;

var path:String = "stages/angels/";

function create() {
	defaultCamZoom = 0.8;
}
function postCreate() {
    bg = new FlxSprite(-800, -260).loadGraphic(Paths.image(path + "bg"));
    bg.antialiasing = true;
    bg.scale.set(0.8,0.8);
    insert(0, bg);
}
