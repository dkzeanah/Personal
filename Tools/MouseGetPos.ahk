#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetBatchLines, -1 ;Script takes CPU priority
CoordMode, Mouse, Screen ;Cursor coordinates are always of the screen, not window

MouseGetPos, locX, locY
Gui, Show, W301 H250 Center
Gui, +AlwaysOnTop
Gui, Font, S30
Gui, Add, Text, X0 W300 H250 Center, X = %locX%`nY = %locY%
Gui, Font, S10
Gui, Add, Button, Xp+10 Yp+120 W83 H30 gControlClick vControlClick, Control
Gui, Add, Button, Xp+98 Yp W83 H30 gClick vClick, Click
Gui, Add, Button, Xp+98 Yp W83 H30 gPure vPure, Pure
Gui, Add, Button, X10 Yp+50 W280 H30 gExit vExit, Exit
return

ControlClick:
Clipboard := """X" . locX . " Y" . locY . """"
ExitApp
return

Click:
Clipboard := "`"" . locX . " " . locY . "`""
ExitApp
return

Pure:
Clipboard := locX . " " . locY
ExitApp
return

Exit:
ExitApp
return 