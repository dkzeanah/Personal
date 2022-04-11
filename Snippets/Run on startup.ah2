SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should

^j::
{
   selectedFile := FileSelect()
   FileCreateShortcut selectedFile, A_AppData . "\Microsoft\Windows\Start Menu\Programs\Startup\Test File.lnk"
}
