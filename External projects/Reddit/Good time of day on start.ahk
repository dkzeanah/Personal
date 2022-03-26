#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
; #Hotstring EndChars -()[]{}:;'"/\?!`n `t
; #WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
; SetTitleMatchMode, 2
SetBatchLines, -1
; CoordMode, Mouse, Relative
; if not A_IsAdmin
; {
;    Run,*RunAs "%A_ScriptFullPath%"  
;    ExitApp
; }

if (A_Hour < 12 AND A_Hour >= 5)
{
    MsgBox,,, Good Morning`, Pooptronic, 3.5
}
else if (A_Hour == 20 AND A_Min <= 29)
{
    MsgBox,,, Good Afternoon`, Pooptonic, 3.5
}
else if (A_Hour >= 12 AND A_Hour <= 19)
{
    MsgBox,,, Good Afternoon`, Pooptronic, 3.5
}
else if (A_Hour == 20 AND A_Min >= 30)
{
    MsgBox,,, Good Night`, Pooptronic, 3.5
}
else if (A_Hour >= 21 OR A_Hour < 5)
{
    MsgBox,,, Good Night`, Pooptronic, 3.5
}
else 
{
    MsgBox,,, Good time of day`, Pooptronic, 3.5
}