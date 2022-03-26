#NoEnv ;Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ;Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir% ;Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetBatchLines, -1 ;Script takes CPU priority

tracksAdded := 0
Gui, Show, W200 H200 X1620 Y50 NA
Gui, Font, S50
Gui, Add, Text, W200 X0 Y50 Center vTrAd_Count, %tracksAdded%
Gui, +AlwaysOnTop
return

~RButton::
tracksAdded++
if (tracksAdded < 15)
   GuiControl, Text, TrAd_Count, %tracksAdded%
else
   ExitApp
return 

;Trigger to exit the script by receiving the hotkey key from an another hotkey in an another script
Launch_App2::ExitApp
