#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetTitleMatchMode, 2
SetBatchLines, -1

;Gets the x and y location of your cursor and pastes the value into your clipboard so you can easily paste it into your code
Mouse_Get_Pos()
{
  MouseGetPos, LocX, LocY
  result := % "X" . LocX . " Y" . LocY
  Clipboard := result
}

;The hotkey for the above function. It's ctrl alt F
+!g::Mouse_Get_Pos()

;Press shift alt M to deafen / undeafen yourself
;This works on a smarter mouse click, so first go into discord, move your mouse on the deafen button and press shift alt F to get the position of your mouse and then paste it after the first comma in the hotkey on the next line. Don't remove the letters. I *think* they are important lol
+!m::ControlClick, X323 Y1054, Discord