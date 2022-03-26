#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetBatchLines, -1

selections := 1

Gui, Show, W200 H200 X1620 Y50 NA
Gui, Font, S50
Gui, Add, Text, W200 X0 Y50 Center vSelected_count, %selections%
Gui, +AlwaysOnTop
return 

~^LButton::
selections++
GuiControl, Text, Selected_count, %selections%
return
Launch_Mail::ExitApp ;triggered by being sent by a hotkey in an another script 
