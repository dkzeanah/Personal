SetWorkingDir "C:\Files\Programming" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
; Persistent True ;Make the script not autoquit if it doesn't have hotkeys

Run(A_WorkingDir . "\Personal\Main\Keys.ah2")