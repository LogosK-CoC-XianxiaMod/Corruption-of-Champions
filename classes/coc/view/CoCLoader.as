/**
 * Coded by aimozg on 23.07.2017.
 */
package coc.view {
import classes.internals.LoggerFactory;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.setTimeout;

import mx.logging.ILogger;

/**
 *
 */
public class CoCLoader {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(CoCLoader);
	public function CoCLoader() {
	}
	// [path:String]=>String
	private static var TEXT_BUNDLE:Object  = {};

	[Embed(source="../../../res/model.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_RES_MODEL_XML:Class;
	bundleText("res/model.xml",BUNDLE_RES_MODEL_XML);

	[Embed(source="../../../content/coc.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_XML:Class;
	bundleText("content/coc.xml", BUNDLE_CONTENT_COC_XML);
	
	[Embed(source="../../../content/coc/appearance.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_APPEARANCE_XML:Class;
	bundleText("content/coc/appearance.xml", BUNDLE_CONTENT_COC_APPEARANCE_XML);

	[Embed(source="../../../content/coc/desert.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_DESERT_XML:Class;
	bundleText("content/coc/desert.xml", BUNDLE_CONTENT_COC_DESERT_XML);

	[Embed(source="../../../content/coc/forest.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_FOREST_XML:Class;
	bundleText("content/coc/forest.xml", BUNDLE_CONTENT_COC_FOREST_XML);
	
	[Embed(source="../../../content/coc/monsters/goblin.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_MONSTERS_GOBLIN_XML:Class;
	bundleText("content/coc/monsters/goblin.xml", BUNDLE_CONTENT_COC_MONSTERS_GOBLIN_XML);
	
	[Embed(source="../../../content/coc/NPC/celess.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_NPC_CELESS_XML:Class;
	bundleText("content/coc/NPC/celess.xml", BUNDLE_CONTENT_COC_NPC_CELESS_XML);

	[Embed(source="../../../content/coc/NPC/diva.xml",mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_NPC_DIVA_XML:Class;
	bundleText("content/coc/NPC/diva.xml",BUNDLE_CONTENT_COC_NPC_DIVA_XML);

    [Embed(source="../../../content/coc/NPC/teladreshops.xml", mimeType="application/octet-stream")]
    public static var BUNDLE_CONTENT_COC_NPC_TELADRESHOPS_XML:Class;
    bundleText("content/coc/NPC/teladreshops.xml", BUNDLE_CONTENT_COC_NPC_TELADRESHOPS_XML);
	
	public static function bundleText(key:String,c:Class):void {
		if (c) TEXT_BUNDLE[key] = new c();
	}

	// [path:String]=>BitmapData
	private static var IMAGE_BUNDLE:Object = {};
//
// [Embed(source="../../../res/char1.png", mimeType="image/png")]
//	public static var BUNDLE_RES_CHAR1_PNG:Class;
//	ldbmp("res/char1.png",BUNDLE_RES_CHAR1_PNG);

	[Embed(source="../../../res/charview/alraune.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_ALRAUNE_PNG:Class;
	bundleImage("res/charview/alraune.png",BUNDLE_RES_CHARVIEW_ALRAUNE_PNG);

	[Embed(source="../../../res/charview/basic.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_BASIC_PNG:Class;
	bundleImage("res/charview/basic.png",BUNDLE_RES_CHARVIEW_BASIC_PNG);

	[Embed(source="../../../res/charview/beasts.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_BEASTS_PNG:Class;
	bundleImage("res/charview/beasts.png",BUNDLE_RES_CHARVIEW_BEASTS_PNG);

	[Embed(source="../../../res/charview/chitin.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_CHITIN_PNG:Class;
	bundleImage("res/charview/chitin.png",BUNDLE_RES_CHARVIEW_CHITIN_PNG);

	[Embed(source="../../../res/charview/hinezumi.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_HINEZUMI_PNG:Class;
	bundleImage("res/charview/hinezumi.png",BUNDLE_RES_CHARVIEW_HINEZUMI_PNG);

	[Embed(source="../../../res/charview/kitsune.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_KITSUNE_PNG:Class;
	bundleImage("res/charview/kitsune.png",BUNDLE_RES_CHARVIEW_KITSUNE_PNG);

	[Embed(source="../../../res/charview/manticore.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_MANTICORE_PNG:Class;
	bundleImage("res/charview/manticore.png",BUNDLE_RES_CHARVIEW_MANTICORE_PNG);

	[Embed(source="../../../res/charview/orca.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_ORCA_PNG:Class;
	bundleImage("res/charview/orca.png", BUNDLE_RES_CHARVIEW_ORCA_PNG);

	[Embed(source="../../../res/charview/scales.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_SCALES_PNG:Class;
	bundleImage("res/charview/scales.png",BUNDLE_RES_CHARVIEW_SCALES_PNG);

	public static function bundleImage(key:String, c:Class):void {
		var o:BitmapData = c ? ((new c() as Bitmap).bitmapData) : null;
		if (o) IMAGE_BUNDLE[key] = o;
	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:*,event:Event):*
	 * where result is String or Error
	 * @param location "external", "internal"
	 */
	public static function loadText(path:String, callback:Function, location:String = "external"):void {
		function orLocal(e:Event):void {
			if (path in TEXT_BUNDLE) {
				setTimeout(callback, 0,true, TEXT_BUNDLE[path], new Event("complete"));
			} else {
				setTimeout(callback, 0,false, null, e);
			}
		}
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				orLocal(new ErrorEvent("error", false, false,
						"Internal resource " + path + "not found"));
				break;
			case "external":
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function (e:Event):void {
					try {
						LOGGER.info("Loaded external "+path);
						TEXT_BUNDLE[path] = loader.data;
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
						return;
					}
					callback(true, loader.data, e);
				});
				var req:URLRequest = new URLRequest(path);
				loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					LOGGER.warn(e.type+" loading external "+path+": "+e.toString());
					orLocal(e);
				});
				try {
					loader.load(req);
				} catch (e:Error) {
					LOGGER.warn(e.name+" loading external "+path+": "+e.message);
					orLocal(new ErrorEvent("error",false,false,e.message));
				}
				break;
			default:
				throw new Error("Incorrect location " + location);
		}

	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:BitmapData, e:Event):*
	 * @param location "external", "internal"
	 */
	public static function loadImage(path:String, callback:Function, location:String = "external"):void {
		function orLocal(e:Event):void {
			if (path in IMAGE_BUNDLE) {
				setTimeout(callback, 0,true, IMAGE_BUNDLE[path], new Event("complete"));
			} else {
				setTimeout(callback, 0,false, null, e);
			}
		}
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				orLocal(new ErrorEvent("error", false, false,
						"Internal resource " + path + "not found"));
				break;
			case "external":
				var loader:Loader = new Loader();
				var cli:LoaderInfo = loader.contentLoaderInfo;
				cli.addEventListener(Event.COMPLETE, function (e:Event):void {
					var bmp:Bitmap = null;
					try {
						bmp = cli.content as Bitmap;
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
						return;
					}
					if (bmp) {
						LOGGER.info("Loaded external "+path);
						IMAGE_BUNDLE[path] = bmp.bitmapData;
						callback(true, bmp.bitmapData, e);
					} else {
						LOGGER.warn("Not found external "+path);
						callback(false, null, e);
					}
				});
				cli.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					LOGGER.warn(e.type+" loading external "+path+": "+e.toString());
					orLocal(e);
				});
				try {
					loader.load(new URLRequest(path));
				} catch (e:Error) {
					LOGGER.warn(e.name+" loading external "+path+": "+e.message);
					orLocal(new ErrorEvent("error",false,false,e.message));
				}
				break;
			default:
				throw new Error("Incorrect location " + location);
		}

	}
}
}
