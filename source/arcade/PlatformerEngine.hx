package arcade;

import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.FlxCamera;

class PlatformerEngine extends MusicBeatState
{
	public static var leftState:Bool = false;

	private var colorRotation:Int = 1;
	private var speed:Float = 0.8;
	private var gravity:Float = 1;
	public var pixelnum:Int = 1;
	public static var player:FlxSprite;
	private var enemy:FlxSprite;
	private var placebox:FlxSprite;
	public static var tiles:FlxTilemap;
	public static var tiles2:FlxTilemap;
	public static var tiles3:FlxTilemap;
	public static var inEditor:Bool = false;
    public static var GRID_SIZE:Int = 40;
	var canJump:Bool = false;
	var hasLoaded:Bool = false;
	var camFollow:FlxObject;
    var loadingtxt:FlxText;
    var loadingbg:FlxSprite;
	var bgcubes:FlxBackdrop;
	public static var coin:Coin;
    var cointxt:FlxText;
	public static var coinsamt:Int = 0;
	////var camOther:FlxCamera;

	override function create()
	{
		super.create();
		////camOther = new FlxCamera();
		////FlxG.cameras.add(camOther);

		coinsamt = 0;
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xFF1c81fc);
		bg.screenCenter();
		bg.setGraphicSize(Std.int(bg.width * 2));
		bg.updateHitbox();
		bg.screenCenter();
		//bg.antialiasing = true;
		add(bg);
		bgcubes = new FlxBackdrop(Paths.image('Menu New/newGrid', 'ridzak'), 0.15, 0.15, true, true);
		add(bgcubes);

		// [6,3,3,3,2,3,0,3,3,3,1,3,3,3,3,3] -SET 1
		// [10,15,12,12,8,12,7,11,11,14,8,8,9,10,8,10] -SET 2
		// [21,21,21,21,20,21,16,21,21,21,21,21,19,21,21,21] -SET 3
		tiles = new FlxTilemap();
		tiles.loadMapFromCSV(Paths.level('level'+pixelnum, 'arcade'), Paths.image('tilesetall', 'arcade'), GRID_SIZE, GRID_SIZE, OFF, -1);
		add(tiles);
		tiles2 = new FlxTilemap();
		//tiles2.loadMapFromCSV(Paths.level('level'+pixelnum+'_2', 'arcade'), Paths.image('tileset2', 'arcade'), GRID_SIZE, GRID_SIZE, AUTO);
		add(tiles2);
		tiles2.visible = false;
		tiles3 = new FlxTilemap();
		//tiles3.loadMapFromCSV(Paths.level('level'+pixelnum+'_3', 'arcade'), Paths.image('tileset3', 'arcade'), GRID_SIZE, GRID_SIZE, AUTO);
		add(tiles3);
		tiles3.visible = false;

		player = new FlxSprite().loadGraphic(Paths.image('RIDZAK', 'arcade'), true, 30, 38);
		player.drag.x = 640;
		player.acceleration.y = 200;
		player.maxVelocity.set(120, 200);
		player.animation.add("idleLEFT", [0, 1, 2, 3, 4], 12);
		player.animation.add("jumpLEFT", [5, 6, 7, 8], 12);
		player.animation.add("jumpLoopLEFT", [7, 8], 12);
		player.animation.add("landingLEFT", [9, 10, 11], 12);
		player.animation.add("runLEFT", [12, 13, 14, 0], 12);
		player.animation.add("idle", [15, 16, 17, 18, 19], 12);
		player.animation.add("jump", [20,21], 12);
		player.animation.add("jumpLoop", [22,23], 12);
		player.animation.add("landing", [24,25,26], 12);
		player.animation.add("run", [27,28,29,15], 12);
		add(player);
		player.screenCenter();

		var coinsthing:Array<String> = ['724.65,254','724.65,254','178,718','1339,870','1779,760','2138,725','2491,800','2356,1000','2461,1120','3179,894','3555,560','2982,560'];

		for (i in 0...coinsthing.length)
			{
				coin = new Coin(Std.parseFloat(coinsthing[i].split(',')[0]),Std.parseFloat(coinsthing[i].split(',')[1]));
				add(coin);
			}
		/*placebox = new FlxSprite(0, 0);
		placebox.makeGraphic(16, 16, FlxColor.PURPLE);
		//FlxSpriteUtil.drawRect(placebox, 0, 0, TILE_WIDTH - 1, TILE_HEIGHT - 1, FlxColor.TRANSPARENT, {thickness: 1, color: FlxColor.RED});
		add(placebox);

		enemy = new FlxSprite(320, 0).loadGraphic(Paths.image('Syntech/pixel/bombThing', 'shared'), true, 26);
		enemy.drag.x = 640;
		enemy.maxVelocity.set(120, 200);
		enemy.animation.add("idle", [0, 1, 2, 3, 4, 5, 6], 30, true);
		enemy.animation.play("idle");
		add(enemy);

		/*for (i in tiles)
			{
				if (i.tile == 2)
					{
						enemy = new FlxSprite(320, 0).loadGraphic(Paths.image('Syntech/pixel/bombThing', 'shared'), true, 26);
						enemy.drag.x = 640;
						enemy.acceleration.y = 420;
						enemy.maxVelocity.set(120, 200);
						enemy.animation.add("idle", [0, 1, 2, 3, 4, 5, 6], 30, true);
						add(enemy);
						tiles.setTile(i.x, i.y, 0);
					}
			}*/
			var smallinf:Array<String> = CoolUtil.coolTextFile('assets/arcade/data/rushedShit.txt');
            cointxt = new FlxText(80, 100, FlxG.width, 'Coins: 0/10', 24);
            cointxt.setFormat(Paths.font("arcade.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            cointxt.borderSize = 1;
			cointxt.scrollFactor.x = 0;
			cointxt.scrollFactor.y = 0;
			cointxt.screenCenter();
			cointxt.x -= Std.parseFloat(smallinf[0]);
			cointxt.y -= Std.parseFloat(smallinf[1]);
            add(cointxt);
			camFollow = new FlxObject(0, 0, 1, 1);
			add(camFollow);
			FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

			FlxG.worldBounds.width = 99999;
			FlxG.worldBounds.height = 9999;
			player.setPosition(1200,1000);
	}

	var pntRack:Int = 0;
	var isGround:Bool = false;
	var landSnd:Bool = true;
	public static var editableTiles:Bool = false;
	public static var editableTiles2:Bool = false;
	public static var editableTiles3:Bool = false;
	var extAnim:String = '';
	var isLeft:Bool = false; 
	override function update(elapsed:Float)
	{
		bgcubes.x += 0.50;
		bgcubes.y += 0.20;
		isGround = false;
		if (cointxt.text != 'Coins: ${coinsamt}/10')
			{
				cointxt.text = 'Coins: ${coinsamt}/10';
			}
			
		if (isLeft)
			{
				extAnim = 'LEFT';
			}
		else
			{
				extAnim = '';
			}

		if (coinsamt > 9)
			{
				leftState = true;
				FlxG.sound.music.stop();
				////CustomFadeTransition.nextCamera = camOther;
				FlxG.worldBounds.width = TitleState.defBoundsx;
				FlxG.worldBounds.height = TitleState.defBoundsy;
				FlxG.save.data.ricochetFree = true;
				PixelMenu.info = ['Ricochet Unlocked!','Code Room','Freeplay'];
				LoadingState.loadAndSwitchState(new PixelMenu());
			}

		FlxG.collide(player, tiles, function(Obj:FlxSprite, Obj2:FlxSprite):Void{
				isGround = true;
			});

		if (controls.UI_UP && canJump && !inEditor)
		{
			pntRack = 0;
			canJump = false; //arcade
			player.y -= 10;
			player.velocity.y = -1200;
			player.animation.play("jump"+extAnim);
			FlxG.sound.play(Paths.sound('jump', 'arcade'), 0.9);
			landSnd = true;
		}
		/*if (controls.DOWN)
			{
				player.y += speed;
			}*/
			if (controls.UI_RIGHT && !inEditor)
				{
					isLeft = false;
					player.x += speed;
					player.velocity.x = speed*10;
				}
			if (controls.UI_LEFT && !inEditor)
					{
						isLeft = true;
						//player.flipX = true;
						player.x -= speed;
						player.velocity.x = -speed*10;
					}
			if (FlxG.keys.justPressed.C) // traces player location to help with placement and triggers
					{
						trace('${player.x},${player.y}');
					}
			if ((controls.RESET || 1150 < player.y) && !inEditor)
				{
					leftState = true;
					FlxG.sound.music.stop();
					////CustomFadeTransition.nextCamera = camOther;
					FlxG.worldBounds.width = TitleState.defBoundsx;
					FlxG.worldBounds.height = TitleState.defBoundsy;
					FlxG.switchState(new arcade.GameOver());
				}
			if (FlxG.keys.justPressed.SEVEN && !inEditor)
				{
					//leftState = true;
					//FlxG.sound.music.stop();
					////CustomFadeTransition.nextCamera = camOther;
					//FlxG.switchState(new arcade.LevelEditor());
				}
			if (controls.BACK && inEditor)
				{
					leftState = true;
					FlxG.sound.music.stop();
					////CustomFadeTransition.nextCamera = camOther;
					FlxG.worldBounds.width = TitleState.defBoundsx;
					FlxG.worldBounds.height = TitleState.defBoundsy;
					FlxG.switchState(new arcade.PixelState());
				}
		if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.S && inEditor)
			{
				//saveLevel();
			}
		if (controls.BACK && !inEditor)
		{
			leftState = true;
			FlxG.worldBounds.width = TitleState.defBoundsx;
			FlxG.worldBounds.height = TitleState.defBoundsy;
			FlxG.switchState(new CodeShit());
		}

		if (player.velocity.y != 0 && !canJump)
		{
			player.animation.play("jumpLoop"+extAnim);
		}
		else if (player.velocity.y == 0 && !canJump)
		{
			if (landSnd)
				{
					FlxG.sound.play(Paths.sound('land', 'arcade'), 0.9);
					landSnd = false;
				}
			player.animation.play("landing"+extAnim);
			pntRack++;
			if (pntRack == 50) // frames it has to play before you can jump
			canJump = true;
		}
		else if (player.velocity.x == 0 && isGround)
		{
			player.animation.play("idle"+extAnim);
		}
		else if (isGround)
		{
			player.animation.play("run"+extAnim);
		}
		else if (!isGround)
		{
			player.animation.play("jumpLoop"+extAnim);
		}
			camFollow.x = player.x;
			camFollow.y = player.y;
		
		if (inEditor && player.acceleration.y != 0)
			player.acceleration.y = 0;
		super.update(elapsed);
	}

	private function saveLevel()
	{
		//tiles.loadMapFromCSV()
	}
}

class Coin extends FlxSprite
{
	public function new(x:Float, y:Float)
		{
            super(x, y);
            this.loadGraphic(Paths.image('Coin', 'arcade'), true, 40);
			this.animation.add("idle", [0, 1, 2], 12);
			this.animation.play('idle');
		}
	override function update(elapsed:Float)
		{
			FlxG.collide(PlatformerEngine.player, this, function(Obj:FlxSprite, Obj2:FlxSprite):Void{
					this.kill();
					FlxG.sound.play(Paths.sound('collect', 'arcade'), 0.9);
					PlatformerEngine.coinsamt++;
				});
			super.update(elapsed);
		}
}
