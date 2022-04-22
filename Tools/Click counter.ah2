#SingleInstance Force 
#InputLevel 2

G_ClickCounter := Gui("AlwaysOnTop", "Click counter")
G_ClickCounter.Show("W200 H200 X1620 Y50 NA")
G_ClickCounter.SetFont("S50")
G_ClickCounter_Clicks := G_ClickCounter.Add("Text", "W200 X0 Y50 Center", "0")
G_ClickCounter_Clicks.OnEvent("Click", (*) => ExitApp())
G_ClickCounter.OnEvent("Close", (*) => ExitApp())

~LButton::clk_NumOfClicks("up")
~LShift::clk_NumOfClicks("down")

clk_NumOfClicks(whereCrement) {
   static clicks := 0
   ((whereCrement == "up") ? clicks++ : clicks--)
   G_ClickCounter_Clicks.Text := clicks
}
