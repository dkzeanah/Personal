#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
#Hotstring EndChars `t ;The only character that completes a hotstring is Tab
#WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
; #Persistent ;Keeps the script running even if otherwise it'd exit
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 2 ;Title *consists of* instead of precise title
SetBatchLines, -1 ;Script takes CPU priority
CoordMode, Mouse, Screen ;Cursor coordinates are always of the screen, not window
; if !A_IsAdmin ;Runs the script as admin
; {
;    Run,*RunAs "%A_ScriptFullPath%"
;    ExitApp
; }

;Gets current cursor's position into your clipboard with formatting for Controlclick, 
+!g::
MouseGetPos, locX, locY
Clipboard := % "X" locX " Y" locY 
return 

;Toggle ping in Discord
#IfWinActive Discord
!e::
MouseGetPos, locX, locY 
Click, 1525, 903
MouseMove, locX, locY
return
#IfWinActive

#IfWinActive Minecraft
XButton2::Send, {Click 20}
#IfWinActive

;Play pause
^+Space::Media_Play_Pause

;Remapping
XButton2::XButton2