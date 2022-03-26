#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetBatchLines, -1
; #Hotstring EndChars -()[]{}:;'"/\?!`n `t
; #WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
#Persistent
; SetTitleMatchMode, 2
; CoordMode, Mouse, Relative
if not A_IsAdmin
{
   Run,*RunAs "%A_ScriptFullPath%"  
   ExitApp
} 

BlockInput, On
Sleep, 60000
; Run, https://www.youtube.com/watch?v=5T5BY1j2MkE&ab_channel=RoastedCurry
ExitApp