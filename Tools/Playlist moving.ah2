SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's

G_PlaylistMoving := Gui("AlwaysOnTop", "Playlist moving")
G_PlaylistMoving.Show("W200 H200 X1620 Y50 NA")
G_PlaylistMoving.SetFont("S50")
G_PlaylistMoving_Selections := G_PlaylistMoving.Add("Text", "W200 X0 Y50 Center", 1)

~^LButton::
{
   static selections := 1
   selections++
   G_PlaylistMoving_Selections.Text := selections
}

Launch_Mail::ExitApp ;triggered by being sent by a hotkey in an another script 
