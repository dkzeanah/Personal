#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
#Hotstring EndChars `t ;The only character that completes a hotstring is Tab
#WinActivateForce 
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 2 ;Title *consists of* instead of precise title
SetBatchLines, -1 ;Script takes CPU priority
CoordMode, Mouse, Screen ;Cursor coordinates are always of the screen, not window
^t::
FormatTime, TimeString
MsgBox Hey there sexy, it's %TimeString%

