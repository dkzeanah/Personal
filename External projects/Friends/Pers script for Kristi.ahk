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




;FUNCTIONS
;#########################################################################################

;Get the path to the exe of your active window
Get_Active_Window_Info()
{
   WinGet, windowExe, ProcessPath, A
   Clipboard := windowExe
}

;Mousegetpos but msgbox
Mouse_Get_Pos_MsgBox()
{
   MouseGetPos, mgp_X, mgp_Y
   MsgBox, 4096,, %mgp_X%`n%mgp_Y%
} 

;Show gesture box
Gesture_Box(right, left, down, up)
{
   MouseMove, %right%, %up%
   Sleep, 20
   MouseMove, %right%, %down%
   Sleep, 20
   MouseMove, %left%, %down%
   Sleep, 20
   MouseMove, %left%, %up% 
}


;TOOLS
;#########################################################################################

;Get the position of the cursor
^!F1::Mouse_Get_Pos_MsgBox()  
;Get the path to the exe of the active window
^!F2::Get_Active_Window_Info()
;Move the cursor to all the corners of the gesture sections
^!F3::Gesture_Box("1368", "568", "747", "347")


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
MouseGetPos, locX, locY
right := (locX > 1368), left := (locX < 568), down := (locY > 747), up := (locY < 347) 
if right ;Skip track in spotify
   ControlClick, X1019 Y963, ahk_exe Spotify.exe
else if left ;Skip track in spotify but backwards
   ControlClick, X919 Y963, ahk_exe Spotify.exe
else if down
   Send, {Delete}
else if up
   return
else 
   Send, ^v 
return

;Play pause, but only in spotify
^!s::ControlClick, X970 Y963, ahk_exe Spotify.exe
XButton2 & LButton::ControlClick, X970 Y961, ahk_exe Spotify.exe

;Skip tracks in spotify, but with the keyboard
^!Right::ControlClick, X1019 Y963, ahk_exe Spotify.exe
^!Left::ControlClick, X919 Y963, ahk_exe Spotify.exe

;Far side button plus Wheel is volume
XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down 

;Close side button copies
XButton1::Send, ^c