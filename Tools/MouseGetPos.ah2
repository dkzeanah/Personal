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
+!f::MGP.mgp_Compared(locX, locY)
Esc::MGP.Exit()

Class C_MouseGetPos {

   X := locX
   Y := locY

   ControlClick() => (A_Clipboard := "`"X" . this.X . " Y" . this.Y . "`"", ExitApp())
   Click() => (A_Clipboard := "`"" . this.X . " " . this.Y . "`"", ExitApp())
   Pure() => (A_Clipboard := this.X . " " . this.Y, ExitApp())
   Exit() => ExitApp()

   mgp_Compared(locX, locY) {
      MouseGetPos &locX2, &locY2
      locX := locX2 - locX
      locY := locY2 - locY
      this.X := locX
      this.Y := locY
      G_MouseGetPos_Coords.Text := "X = " . this.X . "`nY = " . this.Y
   }
}
MGP := C_MouseGetPos()