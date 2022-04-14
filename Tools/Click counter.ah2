#SingleInstance Force 

G_ClickCounter := Gui("AlwaysOnTop", "Click counter")
G_ClickCounter.Show("W200 H200 X1620 Y50 NA")
G_ClickCounter.SetFont("S50")
G_ClickCounter_Clicks := G_ClickCounter.Add("Text", "W200 X0 Y50 Center", "0")
G_ClickCounter_Clicks.OnEvent("Click", Gb_ExitApp)

$~LButton::F_NumOfClicks("up")
$~LShift::F_NumOfClicks("down")

F_NumOfClicks(whereCrement)
{
   static clicks := 0
   ((whereCrement == "up") ? clicks++ : clicks--)
   G_ClickCounter_Clicks.Text := clicks
}

Gb_ExitApp(*) {
   ExitApp
}

