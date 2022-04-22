#SingleInstance Force 
#InputLevel 2
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's

MouseGetPos &locX, &locY
G_MouseGetPos := Gui("AlwaysOnTop", "Mouse get position")
G_MouseGetPos.Show("W301 H150 Center")
G_MouseGetPos.SetFont("S30")
G_MouseGetPos_Coords := G_MouseGetPos.Add("Text", "X0 W300 H250 Center", "X = " . locX . "`nY = " . locY)
G_MouseGetPos.SetFont("S10")
G_MouseGetPos.OnEvent("Close", (*) => ExitApp())

F1::MGP.ControlClick()
F2::MGP.Click()
F3::MGP.Pure()
+!f::MGP.mgp_Compared()
Esc::MGP.Exit()

Class C_MouseGetPos {

   ControlClick() => (A_Clipboard := "`"X" . locX . " Y" . locY . "`"", ExitApp())
   Click() => (A_Clipboard := "`"" . locX . " " . locY . "`"", ExitApp())
   Pure() => (A_Clipboard := locX . " " . locY, ExitApp())
   Exit() => ExitApp()

   mgp_Compared() {
      MouseGetPos &X2, &Y2 ;Second coordinates to compare with
      diffX := X2 - locX ;The difference between the first and the second set of coords
      diffY := Y2 - locY
      G_MouseGetPos_Coords.Text := "X = " . diffX . "`nY = " . diffY ;Show the difference between coords in gui
      A_Clipboard := diffX . " " . diffY ;Paste the difference into clipboard, but don't exit the script yet F
   }
}
MGP := C_MouseGetPos()