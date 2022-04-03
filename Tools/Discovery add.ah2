SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's

Discovery_Add := Gui("AlwaysOnTop", "Discovery add")
Discovery_Add.Show("W200 H200 X1620 Y50 NA")
Discovery_Add.SetFont("S50")
Discovery_Add__Tracks_Added := Discovery_Add.Add("Text", "W200 X0 Y50 Center", "0")

~RButton::
{
   static tracksAdded := 0
   tracksAdded++
   if (tracksAdded < 15)
      Discovery_Add__Tracks_Added.Text := tracksAdded
   else
      ExitApp
}

;Trigger to exit the script by receiving the hotkey key from an another hotkey in an another script
Launch_App2::ExitApp
