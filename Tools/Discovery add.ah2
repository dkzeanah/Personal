G_DiscoveryAdd := Gui("AlwaysOnTop", "Discovery add")
G_DiscoveryAdd.Show("W200 H200 X1620 Y50 NA")
G_DiscoveryAdd.SetFont("S50")
G_DiscoveryAdd_TracksAdded := G_DiscoveryAdd.Add("Text", "W200 X0 Y50 Center", "0")
G_DiscoveryAdd_TracksAdded.OnEvent("Click", (*) => ExitApp())

$~LShift:: {
   static tracksAdded := 0
   tracksAdded++
   ((tracksAdded < 15)
      ? G_DiscoveryAdd_TracksAdded.Text := tracksAdded
      : ExitApp())
}

