SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#InputLevel 2 ;Makes sure hotkeys can't activate themselves (effectively $ on every hotkey)
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds
#Include "%A_ScriptDir%\..\..Libraries\8. Script.ah2"
#Include "%A_ScriptDir%\..\..Libraries\3. Press.ah2"
SoundPlay "*-1"

#HotIf WinActive("YouTube ahk_exe chrome.exe")
RButton:: {
   static i := 0
   Switch i {
      Case 0:
         ;Opens the ... menu
         MouseGetPos(&locX, &locY)
         , ControlClick("X" . locX . " Y" . locY)
         , i := 1
      Case 1:
         ;Selects "Add to playlist"
         ControlClick("X" . locX-156 . " Y" . locY+184)
         , i := 2
      Case 2:
         ;Choose last playlist
         ControlClick("X852 Y670")
         , i := 3
      Case 3:
         ;Exit the playlist selecter
         ControlClick("X" . locX . " Y" . locY)
         , i := 0
   }
   static locX := locX
   static locY := locY
}
#HotIf 

;Exits the script if it's not being used for over a minute concurrently
SetTimer atp_isNotUsed, 1000
atp_isNotUsed() {
   static l
   (!WinActive("YouTube") 
      ? (l += 1)
      : (l := 0))
   , ((l >= 60) ? Script.scr_ExitApp() : "")
}

Esc:: {
   ((Hold.hld_Bool("Esc"))
      ? Script.scr_ExitApp()
      : Script.scr_Reload())
}
