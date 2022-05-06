#SingleInstance Force 
#InputLevel 5

CoordMode("Mouse", "Screen")
, MouseGetPos(&locX, &locY)
, CoordMode("Mouse", "Client")
, MouseGetPos(&loc2X, &loc2Y)
, CoordMode("Mouse", "Window")
, MouseGetPos(&loc3X, &loc3Y)
, CoordMode("Pixel", "Screen")
, G_MouseGetPos := Gui("AlwaysOnTop", "Mouse get position")
, G_MouseGetPos.Show("W301 H150 Center")
, G_MouseGetPos.SetFont("S30")
, G_MouseGetPos_Coords := G_MouseGetPos.Add("Text", "X0 W300 H250 Center", "X = " . locX . "`nY = " . locY)
, G_MouseGetPos.OnEvent("Close", (*) => ExitApp())

F1::MGP.ControlClick()
F2::MGP.Client()
F3::MGP.Screen()
F4::MGP.Window()
F5::MGP.PixelColor()
+!f::MGP.mgp_Compared()
Esc::MGP.Exit()

Class C_MouseGetPos {

   ControlClick() => (A_Clipboard := "`"X" . loc2X . " Y" . loc2Y . "`"", ExitApp())
   Client() => (A_Clipboard := loc2X " " loc2Y, ExitApp())
   Screen() => (A_Clipboard := locX . " " . locY, ExitApp())
   Window() => (A_Clipboard := loc3X . " " . loc3Y, ExitApp())
   PixelColor() => (MouseGetPos(&X, &Y)
   , A_Clipboard :=  PixelGetColor(X, Y, "Slow")
   , G_MouseGetPos_Coords.Text := A_Clipboard)
   Exit() => ExitApp()

   mgp_Compared() {
      CoordMode("Mouse", "Screen")
      MouseGetPos(&X2, &Y2) ;Second coordinates to compare with
      , diffX := X2 - locX ;The difference between the first and the second set of coords
      , diffY := Y2 - locY
      , G_MouseGetPos_Coords.Text := "X = " . diffX . "`nY = " . diffY ;Show the difference between coords in gui
      , A_Clipboard := diffX . " " . diffY ;Paste the difference into clipboard, but don't exit the script yet F
   }
}
MGP := C_MouseGetPos()