SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's

G_DiscoveryAdd := Gui("AlwaysOnTop", "Discovery add")
G_DiscoveryAdd.Show("W200 H200 X1620 Y50 NA")
G_DiscoveryAdd.SetFont("S50")
G_DiscoveryAdd_TracksAdded := G_DiscoveryAdd.Add("Text", "W200 X0 Y50 Center", "0")

~RButton::
{
   static tracksAdded := 0
   tracksAdded++
   if (tracksAdded < 15)
      G_DiscoveryAdd_TracksAdded.Text := tracksAdded
   else
      ExitApp
}

;Trigger to exit the script by receiving the hotkey key from an another hotkey in an another script
Launch_App2::ExitApp
