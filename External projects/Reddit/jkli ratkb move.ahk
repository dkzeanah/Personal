#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script. 
SetBatchLines, -1
CoordMode, Mouse, Relative

!7::
MouseGetPos, leftX, leftY
MouseMove, leftX-20, leftY
return

!0::
MouseGetPos, downX, downY
MouseMove, downX, downY+20
return

!8::
MouseGetPos, rightX, rightY
MouseMove, rightX+20, rightY
return

!9::
MouseGetPos, upX, upY
MouseMove, upX, upY-20
return 

!-::Click 
!=::Click,, R