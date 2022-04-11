#NoEnv ;Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ;Enable warnings to assist with detecting common errors.
#SingleInstance, Force ;Only launch 1 instance of this script.
SetBatchLines, -1 ;Script takes CPU priority

^j::
FileSelectFile, selectedFile, S
SplitPath, selectedFile, fileName
FileCreateShortcut, %selectedFile%, %A_AppData%\Microsoft\Windows\Start Menu\Programs\Startup\%fileName%.lnk

