SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's

G_ClickCounter := Gui("AlwaysOnTop", "Click counter")
G_ClickCounter.Show("W200 H200 X1620 Y50 NA")
G_ClickCounter.SetFont("S50")
G_ClickCounter_Clicks := G_ClickCounter.Add("Text", "W200 X0 Y50 Center", "0")
G_ClickCounter_Clicks.OnEvent("Click", Gb_ExitApp)

Gb_ExitApp(*) {
   ExitApp
}

~LButton::
{
   static clicks := 0
   clicks++
   G_ClickCounter_Clicks.Text := clicks
}

