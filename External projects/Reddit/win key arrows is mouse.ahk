#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetBatchLines, -1
CoordMode, Mouse, Relative


#Right::
MouseGetPos, initX, initY
MouseMove, initX+20, initY
return

#Left::
MouseGetPos, initX, initY
MouseMove, initX-20, initY
return

#Up::
MouseGetPos, initX, initY
MouseMove, initX, initY-20
return

#Down::
MouseGetPos, initX, initY
MouseMove, initX, initY+20
return

#Space::Click
#Alt::Click,, R