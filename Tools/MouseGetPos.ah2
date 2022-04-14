#SingleInstance Force 
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's

MouseGetPos &locX, &locY
G_MouseGetPos := Gui("AlwaysOnTop", "Mouse get position")
G_MouseGetPos.Show("W301 H250 Center")
G_MouseGetPos.SetFont("S30")
G_MouseGetPos.Add("Text", "X0 W300 H250 Center", "X = " . locX . "`nY = " . locY)
G_MouseGetPos.SetFont("S10")
G_MouseGetPos_ControlClick := G_MouseGetPos.Add("Button", "Xp+10 Yp+120 W83 H30", "Control")
G_MouseGetPos_Click := G_MouseGetPos.Add("Button", "Xp+98 Yp W83 H30", "Click")
G_MouseGetPos_Pure := G_MouseGetPos.Add("Button", "Xp+98 Yp W83 H30", "Pure")
G_MouseGetPos_Exit := G_MouseGetPos.Add("Button", "X10 Yp+50 W280 H30", "Exit")
G_MouseGetPos_ControlClick.OnEvent("Click", Gb_ControlClick)
G_MouseGetPos_Click.OnEvent("Click", Gb_Click)
G_MouseGetPos_Pure.OnEvent("Click", Gb_Pure)
G_MouseGetPos_Exit.OnEvent("Click", Gb_Exit)

Gb_ControlClick(*)
{
   A_Clipboard := "`"X" . locX . " Y" . locY . "`""
   ExitApp
}

Gb_Click(*)
{
   A_Clipboard := "`"" . locX . " " . locY . "`""
   ExitApp
}

Gb_Pure(*)
{
   A_Clipboard := locX . " " . locY
   ExitApp
}

Gb_Exit(*)
{
   ExitApp
}
