#SingleInstance Force 

G_PlaylistMoving := Gui("AlwaysOnTop", "Playlist moving")
G_PlaylistMoving.Show("W200 H200 X1620 Y50 NA")
G_PlaylistMoving.SetFont("S50")
G_PlaylistMoving_PlaylistNum := G_PlaylistMoving.Add("Text", "W200 X0 Y50 Center", "0")
G_PlaylistMoving_PlaylistNum.OnEvent("Click", Gb_ExitApp)

$~LShift::
$~RButton::
{
   static playlistNum := 0
   if (playlistNum < 10)
   {
      playlistNum++
      G_PlaylistMoving_PlaylistNum.Text := playlistNum
   }
   else
   {
      playlistNum := 1
      G_PlaylistMoving_PlaylistNum.Text := playlistNum
   }
}

Gb_ExitApp(*) {
   ExitApp
}