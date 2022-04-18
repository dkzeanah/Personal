;RETURN TRUE OR FALSE
;———————————————————————————

;Returns false and then true if you pressed the same hotkey twice in a row, only returns false if pressed once, in your specified period
F_isSameHotkeyTwice(howLong:=200) {
   return (A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong)
}

;Returns true if you pressed the same hotkey twice in a row; false if pressed only once
F_isDoublePressed(whichKey, howLong:="0.1") {
   KeyWait whichKey, "U"
   if KeyWait(whichKey, "D T" . howLong) {
      KeyWait(whichKey, "U") ;If you don't, will first return false and then true from one double press
      return True
   }
   else 
      return False
}

;Returns true if a key was held for your specified time, false if tapped quickly
F_isKeyHeld(whichKey, howLong:="0.15") {
   return !KeyWait(whichKey, "U T" . howLong)
} 
   


;SEND
;—————————————————————————

;Sends first thing on single press, sends both consecutively on double press
F_ifSameHotkeyTwice_Send(toSend1, toSend2, howLong:=200) {
   Send((A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong) 
   ? toSend2 
   : toSend1)
}

;Sends first thing on a single press, the second one on a double press
F_ifDoublePressed_Send(whichKey, toSend1, toSend2, howLong:="0.1") {
   KeyWait(whichKey, "U"), (KeyWait(whichKey, "D T" . howLong)
   ? (Send(toSend1), KeyWait(whichKey, "U"))
   : Send(toSend2))
}

;Sends first thing if pressed quickly, the second one if held
F_ifKeyHeld_Send(whichKey, toSend1, toSend2, howLong:="0.15") {
   Send((KeyWait(whichKey, "U T" . howLong) 
   ? toSend1 
   : toSend2))
}


;CONTROLCLICK
;———————————————————————————————————————

;ControlClicks one place on a single press, a different one on a double press
F_ifDoublePressed_ControlClick(whichKey, coord1, mouseButton1:="", coord2:="", mouseButton2:="", winTitle:="", howLong:="0.1") {
   KeyWait(whichKey, "U"), (KeyWait(whichKey, "D T" . howLong) 
   ? (ControlClick(coord1, winTitle,, mouseButton1), KeyWait(whichKey, "U")) 
   : ControlClick(coord2, winTitle,, mouseButton2))
}

