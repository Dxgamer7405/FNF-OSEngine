package;

#if android
import android.Hardware;
import android.Permissions;
import android.os.Build;
import android.os.Environment;
#end
import flash.system.System;
import flixel.FlxG;
import flixel.util.FlxStringUtil;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author: Saw (M.A. Jigsaw)
 */
class SUtil
{
	/**
	 * A simple check function
	 */
	public static function check()
	{
		#if android
		if (!Permissions.getGrantedPermissions().contains(Permissions.WRITE_EXTERNAL_STORAGE)
			&& !Permissions.getGrantedPermissions().contains(Permissions.READ_EXTERNAL_STORAGE))
		{
			if (VERSION.SDK_INT > 23 || VERSION.SDK_INT == 23)
			{
				Permissions.requestPermissions([Permissions.WRITE_EXTERNAL_STORAGE, Permissions.READ_EXTERNAL_STORAGE]);

				/**
				 * Basically for now i can't force the app to stop while its requesting a android permission, so this makes the app to stop while its requesting the specific permission
				 */
				Application.current.window.alert('Type What You Want!' + "\nType What You Want."
					+ 'Type What You Want.',
					'Permission?');
			}
			else
			{
				Application.current.window.alert('Type What You Want.' + '\nType What You Want.', 'Permission?');
				System.exit(1);
			}
		}

		if (Permissions.getGrantedPermissions().contains(Permissions.WRITE_EXTERNAL_STORAGE)
			&& Permissions.getGrantedPermissions().contains(Permissions.READ_EXTERNAL_STORAGE))
		{
			if (!FileSystem.exists(SUtil.getPath()))
				FileSystem.createDirectory(SUtil.getPath());

			if (!FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.exists(SUtil.getPath() + 'mods'))
			{
				Application.current.window.alert("Type What You Want.",
					'Error!');
				FlxG.openURL('https://youtu.be/-0I7hYfQxgA');
				System.exit(1);
			}
			else if ((FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.isDirectory(SUtil.getPath() + 'assets'))
				&& (FileSystem.exists(SUtil.getPath() + 'mods') && !FileSystem.isDirectory(SUtil.getPath() + 'mods')))
			{
				Application.current.window.alert("Type What You Want...",
					'Error!');
				System.exit(1);
			}
			else
			{
				if (!FileSystem.exists(SUtil.getPath() + 'assets'))
				{
					Application.current.window.alert("Type What You Want.",
						'Error!');
					FlxG.openURL('https://youtu.be/-0I7hYfQxgA');
					System.exit(1);
				}
				else if (FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.isDirectory(SUtil.getPath() + 'assets'))
				{
					Application.current.window.alert("Type What You Want...",
						'Error!');
					System.exit(1);
				}

				if (!FileSystem.exists(SUtil.getPath() + 'mods'))
				{
					Application.current.window.alert("Type What You Want.",
						'Error!');
					FlxG.openURL('https://youtu.be/-0I7hYfQxgA');
					System.exit(1);
				}
				else if (FileSystem.exists(SUtil.getPath() + 'mods') && !FileSystem.isDirectory(SUtil.getPath() + 'mods'))
				{
					Application.current.window.alert("Type What You Want...",
						'Error!');
					System.exit(1);
				}
			}
		}
		#end
	}

	/**
	 * This returns the external storage path that the game will use
	 */
	public static function getPath():String
	{
		#if android return Environment.getExternalStorageDirectory() + '/' + '.' + Application.current.meta.get('file') + '/'; #else return ''; #end
	}

	/**
	 * Uncaught error handler, original made by: sqirra-rng
	 */
	public static function uncaughtErrorHandler()
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, function(u:UncaughtErrorEvent)
		{
			var callStack:Array<StackItem> = CallStack.exceptionStack(true);
			var errMsg:String = '';

			for (stackItem in callStack)
			{
				switch (stackItem)
				{
					case FilePos(s, file, line, column):
						errMsg += file + ' (line ' + line + ')\n';
					default:
						Sys.println(stackItem);
				}
			}

			errMsg += u.error;

			Sys.println(errMsg);
			Application.current.window.alert(errMsg, 'Error!');

			try
			{
				if (!FileSystem.exists(SUtil.getPath() + 'crash'))
					FileSystem.createDirectory(SUtil.getPath() + 'crash');

				File.saveContent(SUtil.getPath() + 'crash/' + Application.current.meta.get('file') + '_'
					+ FlxStringUtil.formatTime(Date.now().getTime(), true) + '.log',
					errMsg + "\n");
			}
			catch (e:Dynamic)
				#if android
				Hardware.toast("Error!\nType What You Want:\n" + e, 2);
				#end

			System.exit(1);
		});
	}

	#if android
	public static function saveContent(fileName:String = 'file', fileExtension:String = '.json', fileData:String = 'you forgot to add something in your code')
	{
		try
		{
			if (!FileSystem.exists(SUtil.getPath() + 'saves'))
				FileSystem.createDirectory(SUtil.getPath() + 'saves');

			File.saveContent(SUtil.getPath() + 'saves/' + fileName + fileExtension, fileData);
			#if android
			Hardware.toast("Type What You Want: Test.", 2);
			#end
		}
		catch (e:Dynamic)
			Hardware.toast("Error!\nType What You Want:\n" + e, 2);
	}

	public static function copyContent(copyPath:String, savePath:String)
	{
		try
		{
			if (!FileSystem.exists(savePath))
				File.saveBytes(savePath, OpenFlAssets.getBytes(copyPath));
		}
		catch (e:Dynamic)
			Hardware.toast("Greska!\nSB Engine Nemoze Da Kopira Ime Dadoteke Za Kopiranje:\n" + e, 2);
	}
	#end
}
