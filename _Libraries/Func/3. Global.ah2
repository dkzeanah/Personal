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
