package arcade;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUITabMenu;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;

class LevelEditor extends PlatformerEngine
{
	private var camMenu:FlxCamera;
	var UI_box:FlxUITabMenu;
    var tabs = [
        {name: 'Tools', label: 'Tools'},
    ];
	public var camGame:FlxCamera;
    var cursorBox:FlxSprite;
	override function create()
        {
            camGame = new FlxCamera();
            FlxG.cameras.reset(camGame);
            FlxCamera.defaultCameras = [camGame];
            FlxG.mouse.visible = true;
            FlxG.sound.music.stop();
            PlatformerEngine.inEditor = true;
            FlxG.sound.playMusic(Paths.music('editorThemes/editorTheme'+FlxG.random.int(1,3), 'arcade'), 1, false);

            camFollow = new FlxObject(0, 0, 2, 2);
            camFollow.screenCenter();
            add(camFollow);
		    FlxG.camera.follow(camFollow);
            
		    camMenu = new FlxCamera();
		    camMenu.bgColor.alpha = 0;
		    FlxG.cameras.add(camMenu);
		    UI_box = new FlxUITabMenu(null, tabs, true);
		    UI_box.cameras = [camMenu];
		    UI_box.resize(250, 225);
		    UI_box.x = FlxG.width - 275;
		    UI_box.y = 25;
		    UI_box.scrollFactor.set();
		    add(UI_box);

            addTabUI();

		    cursorBox = new FlxSprite().makeGraphic(PlatformerEngine.GRID_SIZE, PlatformerEngine.GRID_SIZE, FlxColor.WHITE);
		    add(cursorBox);
            
            super.create();
        }
    
        var currentTilesetStepper:FlxUINumericStepper;

    var editingObj:Array<String> = ['Player','Landscape','Item','Enemy'];
    var itemtype:Int = 0;
    var tilestype:Int = 1;
    function addTabUI() // EACH OBJECT ON THE UI IS 25 PX APART
        {
            var tab_group = new FlxUI(null, UI_box);
            tab_group.name = "Tools";

            var objtypeDropDown = new FlxUIDropDownMenu(10, 10, FlxUIDropDownMenu.makeStrIdLabelArray(editingObj, true), function(character:String)
            {
                itemtype = Std.parseInt(character);

                currentTilesetStepper.visible = false;

                switch (editingObj[itemtype])
                {
                    case 'Player':
                    case 'Landscape':
                        currentTilesetStepper.visible = true;
                    case 'Item':
                    case 'Enemy':
                }
            });
            objtypeDropDown.selectedLabel = editingObj[itemtype];

            // LANDSCAPING UI
		    currentTilesetStepper = new FlxUINumericStepper(15, 25, 1, 1, 1, 3, 1);

            tab_group.add(objtypeDropDown);
            tab_group.add(currentTilesetStepper);
            UI_box.addGroup(tab_group);
        }

        function refreshUIVals()
            {
                tilestype = Std.int(currentTilesetStepper.value);
            }

        var ramLastEditObj:String = 'LOAD THE PLAYER SHIT';
        var unselectedAlpha:Float = 0.2;
        var onlyfuckonce:Bool;
        override function update(elapsed:Float)
        {
            cameraZooming(elapsed);
            cameraMobility();
            //cursorUpdate(elapsed);
            editableGame();
            refreshUIVals();
            if (FlxG.keys.justPressed.TAB)
                {
                    itemtype++;
                    if (itemtype > 3)
                        itemtype = 0;
                }
            if (ramLastEditObj != editingObj[itemtype])
                {
                    PlatformerEngine.player.alpha = unselectedAlpha;
                    PlatformerEngine.tiles.alpha = unselectedAlpha;
                    PlatformerEngine.tiles2.alpha = unselectedAlpha;
                    PlatformerEngine.tiles3.alpha = unselectedAlpha;
                    PlatformerEngine.coin.alpha = unselectedAlpha;
                    
                    PlatformerEngine.editableTiles = false;
                    PlatformerEngine.editableTiles2 = false;
                    PlatformerEngine.editableTiles3 = false;
                    switch (ramLastEditObj = editingObj[itemtype])
                    {
                        case 'Player':
                            PlatformerEngine.player.alpha = 1;
                        case 'Landscape':
                            PlatformerEngine.tiles.alpha = 1;
                            PlatformerEngine.tiles2.alpha = 1;
                            PlatformerEngine.tiles3.alpha = 1;
                        case 'Item':
                            PlatformerEngine.coin.alpha = 1;
                        case 'Enemy':
                            
                    }
                }

            if (!FlxG.sound.music.playing)
            {
                FlxG.sound.playMusic(Paths.music('editorThemes/editorTheme'+FlxG.random.int(1,3), 'arcade'), 1, false);
            }
            super.update(elapsed);
        }

        function editableGame()
            {
                switch (editingObj[itemtype])
                {
                    case 'Player':
                        if (FlxG.mouse.overlaps(PlatformerEngine.player) && FlxG.mouse.pressed && !onlyfuckonce)
                            {
                                if (FlxG.keys.pressed.SHIFT)
                                    {
                                        PlatformerEngine.player.x = Math.floor(FlxG.mouse.x / PlatformerEngine.GRID_SIZE);
                                        PlatformerEngine.player.y = Math.floor(FlxG.mouse.y / PlatformerEngine.GRID_SIZE);
                                    }
                                    onlyfuckonce = true;
                            }    
                        else if (FlxG.mouse.pressed)
                            {
                                if (FlxG.keys.pressed.SHIFT)
                                    {
                                        PlatformerEngine.player.x = Math.floor(FlxG.mouse.x / PlatformerEngine.GRID_SIZE);
                                        PlatformerEngine.player.y = Math.floor(FlxG.mouse.y / PlatformerEngine.GRID_SIZE);
                                    }
                            }
                            else
                                {
                                    onlyfuckonce = false;
                                }
                    case 'Landscape':
                        switch (tilestype)
                        {
                            case 1:
                                PlatformerEngine.editableTiles = true;
                            case 2:
                                PlatformerEngine.editableTiles2 = true;
                            case 3:
                                PlatformerEngine.editableTiles3 = true;
                        }
                    case 'Item':
                    case 'Enemy':
                        
                }
            }

        var colorSine:Float = 0;
        function cursorUpdate(elapsed:Float)
            {
                cursorBox.x = Math.floor(FlxG.mouse.x / PlatformerEngine.GRID_SIZE);
                cursorBox.y = Math.floor(FlxG.mouse.y / PlatformerEngine.GRID_SIZE);
                colorSine += 180 * elapsed;
                var colorVal:Float = 0.7 + Math.sin((Math.PI * colorSine) / 180) * 0.3;
                cursorBox.color.lightness = colorVal;
                cursorBox.alpha = 0.5;
            }

        function cameraZooming(elapsed:Float)
            {
	    		if (FlxG.keys.pressed.E && FlxG.camera.zoom < 3) {
	    			FlxG.camera.zoom += elapsed * FlxG.camera.zoom;
	    			if(FlxG.camera.zoom > 3) FlxG.camera.zoom = 3;
	    		}
	    		if (FlxG.keys.pressed.Q && FlxG.camera.zoom > 0.1) {
	    			FlxG.camera.zoom -= elapsed * FlxG.camera.zoom;
	    			if(FlxG.camera.zoom < 0.1) FlxG.camera.zoom = 0.1;
	    		}
            }
        function cameraMobility()
            {
	    		if (FlxG.keys.pressed.W || FlxG.keys.pressed.A || FlxG.keys.pressed.S || FlxG.keys.pressed.D)
                    {
                        var shiftMult:Int = 4;
                        if (FlxG.keys.pressed.SHIFT)
                            shiftMult = 8;
                    
                        if (FlxG.keys.pressed.W)
                            camFollow.velocity.y = -90 * shiftMult;
                        else if (FlxG.keys.pressed.S)
                            camFollow.velocity.y = 90 * shiftMult;
                        else
                            camFollow.velocity.y = 0;
                    
                        if (FlxG.keys.pressed.A)
                            camFollow.velocity.x = -90 * shiftMult;
                        else if (FlxG.keys.pressed.D)
                            camFollow.velocity.x = 90 * shiftMult;
                        else
                            camFollow.velocity.x = 0;
                    }
                    else
                    {
                        camFollow.velocity.set();
                    }
            }
}