F_ClickThenGoBack(coordinates) {
     MouseGetPos(&initX, &initY)
   , Click(coordinates)
   , MouseMove(initX, initY)
}

;Clicks as an event for extra fucky things
F_ClickThenGoBack_Event(coordinates) {
     MouseGetPos(&initX, &initY)
   , SendEvent("{Click " . coordinates . "}")
   , MouseMove(initX, initY)
} 

;A faster send. Sending stuff can take too long, but if you copy and paste it, it's much faster. Takes care of your previous clipboard disappearing as well
F_ClipSend(toSend, space:=" ") {
     prevClip := A_Clipboard
   , A_Clipboard := toSend . space
   , Send("^v")
   , SetTimer(() => A_Clipboard := prevClip, -200) ;Reverts the clipboard to what it was
}

;Runs the link and makes sure the browser is activated
F_RunLink(link) {
   Run(link), WinActivate("Google Chrome")
}


;Sends an emoji using its unicode
F_Emoji(emojiName) {
   Send("{" . D_KeyCodes_In[emojiName] . "}")
}

;Sends a random word from your specified array
F_RandomWord(whichArray) {
   Send("{BackSpace 6}")
   , i := Random(1, 3000)
   , Send(whichArray[i])
}

