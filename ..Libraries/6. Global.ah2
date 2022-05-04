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

;A faster send. Sending stuff can take too long, but if you copy and paste it, it's much faster. Takes care of your previous clipboard disappearing as well
ClipSend(toSend, endChar := " ", isClipReverted := 1, untilRevert := 200) {
     ((isClipReverted) ? prevClip := ClipboardAll() : "")
   , A_Clipboard := toSend . endChar
   , Send("^v")
   , ((isClipReverted) 
      ? SetTimer(() => A_Clipboard := prevClip, -untilRevert) 
      : "")
}

;Runs the link and makes sure the browser is activated
RunLink(link) {
   Run(link), WinActivate("Google Chrome ahk_exe chrome.exe")
}


