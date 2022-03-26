#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
#Hotstring EndChars -()[]{}:;'"/\?!`n `t
#WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
SetTitleMatchMode, 2
SetBatchLines, -1
CoordMode, Mouse, Relative
; if not A_IsAdmin
; {
;    Run,*RunAs "%A_ScriptFullPath%"  
;    ExitApp
; }

!+g::
MouseGetPos, initX, initY
Clipboard := % "X" initX " Y" initY