SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
SetControlDelay -1 ;Even faster ControlClick/Send
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds


#InputLevel 6 

;This will affect the main script
Numpad1::PrintScreen
Numpad2::ScrollLock
Numpad3::SC045
Numpad4::Delete
Numpad5::End
Numpad6::PgDn
Numpad7::Insert
Numpad8::Home
Numpad9::PgUp
AppsKey::LCtrl


#InputLevel 5 

;You can still send these keys with them working, but if you press them, they won't do anything
;Commented if it actually needs to be pressed

Launch_Media::    return        ;F1
Media_Play_Pause::return        ;F2
Media_Stop::      return        ;F3
Media_Prev::      return        ;F4
Media_Next::      return        ;F5
Volume_Mute::     return        ;F6
Volume_Up::       return        ;F7
; Volume_Down::     return        ;F8
Launch_App1::     return        ;F9
Launch_Mail::     return        ;F10
Launch_App2::     return        ;F11
Browser_Home::    return        ;F12

*NumpadMult:: return
*NumpadDiv::  return
*NumpadAdd::  return
*NumpadSub::  return
*NumLock::    return
*Numpad0::    return
*NumpadDot::  return
*NumpadEnter::return
