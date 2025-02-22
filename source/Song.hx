package;

import sys.io.File;
import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var player3:String;
	var stage:String;
	var noteskin:String;
	var validScore:Bool;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var bpm:Int;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var player3:String = 'gf';

	public var stage:String = 'stage';
	public var noteskin:String = 'default';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
		{
			var rawJson = Assets.getText(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase())).trim();
	
			while (!rawJson.endsWith("}"))
			{
				rawJson = rawJson.substr(0, rawJson.length - 1);
			}
	
			return parseJSONshit(rawJson);
		}
	
		public static function loadFromModJson(jsonInput:String, ?folder:String, mod:String = ''):SwagSong
			{
				// load a json from a mod folder (not the main folder)
				//var rawJson = File.getContent("mods/data/" + folder.toLowerCase() + '/' + jsonInput.toLowerCase() + '.json').trim();

				if (mod == '')
					mod = SLModding.curLoaded;

				var rawJson = SLModding.getContent(SLModding.generatePath(mod, "data") + folder.toLowerCase() + '/' + jsonInput.toLowerCase() + '.json').trim();

				while (!rawJson.endsWith("}"))
				{
					rawJson = rawJson.substr(0, rawJson.length - 1);
				}
		
				return parseJSONshit(rawJson);
			}
	
		public static function parseJSONshit(rawJson:String):SwagSong
		{
			var swagShit:SwagSong = cast Json.parse(rawJson).song;
			swagShit.validScore = true;
			return swagShit;
		}
	}
