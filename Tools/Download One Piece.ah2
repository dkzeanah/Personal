SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#InputLevel 5 ;Makes sure hotkeys can't activate themselves (effectively $ on every hotkey)
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
SetControlDelay -1 ;Even faster ControlClick/Send
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds
#Include "%A_ScriptDir%\..\..Libraries\8. Script.ah2"
#Include "%A_ScriptDir%\..\..Libraries\1. Base.ah2"
#Include "%A_ScriptDir%\..\..\Other\Libraries v2\ClipSend.ah2"
#Include "%A_ScriptDir%\..\..Libraries\3. Press.ah2"

onp_OnePiece(action) {
   static l := 0
   ((action == "paste")
      ? (ClipSend(l, ""), l++)
   : (action == "define") 
      ? (l := InputBox().Value) : "")
}

#HotIf WinActive("Save As ahk_exe chrome.exe")
CapsLock::onp_OnePiece("paste")
+CapsLock::onp_OnePiece("define")
#HotIf WinActive("Google Chrome ahk_exe chrome.exe")
CapsLock::Base.bsd_CloseTab()
#HotIf 

Esc::Script.scr_ExitApp()