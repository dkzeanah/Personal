ClickThenGoBack(coordinates) {
     MouseGetPos(&initX, &initY)
   , Click(coordinates)
   , MouseMove(initX, initY)
}

;Clicks as an event for extra fucky things
ClickThenGoBack_Event(coordinates) {
     MouseGetPos(&initX, &initY)
   , SendEvent("{Click " . coordinates . "}")
   , MouseMove(initX, initY)
} 

;A faster send. Sending stuff can take too long, but if you copy and paste it, it's much faster. Retains your clipboard as well
ClipSend(toSend, endChar := " ", isClipReverted := 1, untilRevert := 200) {
     ((isClipReverted) ? prevClip := ClipboardAll() : "")
   , A_Clipboard := toSend . endChar
   , Send("^v")
   , ((isClipReverted) 
      ? SetTimer(() => A_Clipboard := prevClip, -untilRevert) 
      : "")
}

RunLink(link) {
   Run(link), WinActivate("Google Chrome ahk_exe chrome.exe")
}

WaitUntilImage(image) {
   var := 0
   imageFile := A_WorkingDir . "\Files\Images\" . image . ".png"
   While !var {
      var := ImageSearch(&imgX, &imgY, 0, 0, A_ScreenWidth, A_ScreenHeight, imageFile)
   }
   return [imgX, imgY]
}

WaitClick(image) {
   coords := WaitUntilImage(image)
   , ControlClick("X" . coords[1] . " Y" . coords[2], "A")
}

WindowGetter() {

   ;Getting the current window's info
   winTitle := WinGetTitle("A")
   winExePath := WinGetProcessPath("A")
   winExe := WinGetProcessName("A")
   
   ;Gui creation
   , G_WinGet := Gui("AlwaysOnTop", "WinGet")
   , G_WinGet.Show("Center H200 W1000")
   , G_WinGet.SetFont("S20")
   
   ;Show the window's info
   , G_WinGet_WinTitle := G_WinGet.Add("Text", "Center", winTitle)
   , G_WinGet_WinExePath := G_WinGet.Add("Text", "Center", winExePath)
   , G_WinGet_WinExe := G_WinGet.Add("Text", "Center", winExe)

   ;When you click on the text, it activates toClip
   , G_WinGet_WinTitle.OnEvent("Click", (*) => ToClip(winTitle))
   , G_WinGet_WinExePath.OnEvent("Click", (*) => ToClip(winExePath))
   , G_WinGet_WinExe.OnEvent("Click", (*) => ToClip(winExe))

   ;This function copies the text you clicked to your clipboard and destroys the gui right after
   , ToClip(text) => (
      A_Clipboard := text,
      G_WinGet.Destroy()
   )

   ;Destroys the gui when you close the X button on it
   , G_WinGet.OnEvent("Close", (*) => G_WinGet.Destroy())
   
}
