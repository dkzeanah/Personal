#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
#Hotstring EndChars `t
#WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
SetTitleMatchMode, 2
SetBatchLines, -1
CoordMode, Mouse, Screen
; if not A_IsAdmin
; {
;    Run,*RunAs "%A_ScriptFullPath%"  
;    ExitApp
; }


;SPECIAL
;#########################################################################################

;Long dash
^!-::Send, {ASC 0151}

;Wrong language laugh switches language
:*?:[f[f[::{LWin Down}{Space}{LWin Up} 
:*?:f[f[f::{LWin Down}{Space}{LWin Up} 


;MAIN
;#########################################################################################

;Far side button gestures
XButton2::
MouseGetPos, sectionX, sectionY
right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347) 
Switch
{
   Default:Send, ^v
   Case right:Send, {Media_Next}
   Case left:Send, {Media_Prev}
   Case down:Send, {Delete}
   Case up:return
}
return

;Play pause, but only in spotify
^!s::Send, {Media_Play_Pause}
XButton2 & LButton::Media_Play_Pause

;Skip tracks in spotify, but with the keyboard
^!Right::Send, {Media_Next}
^!Left::Send, {Media_Prev}

;Far side button plus Wheel is volume
XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down 

;Close side button copies
XButton1::Send, ^c