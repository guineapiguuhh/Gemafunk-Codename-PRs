import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;

function postCreate() {
    bg.color = 0xFFFFA419;
    bg.loadGraphic(Paths.image('menus/menuDesat'));

        FlxG.state.forEachOfType(FlxText, text -> text.font = Paths.font("Comic Sans MS.ttf"));

}