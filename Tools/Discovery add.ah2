#SingleInstance Force 

G_DiscoveryAdd := Gui("AlwaysOnTop", "Discovery add")
G_DiscoveryAdd.Show("W200 H200 X1620 Y50 NA")
G_DiscoveryAdd.SetFont("S50")
G_DiscoveryAdd_TracksAdded := G_DiscoveryAdd.Add("Text", "W200 X0 Y50 Center", "0")

$~LShift::
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
