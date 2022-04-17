;Why is there a send variant for every function? It's faster even if you'd use ternary


;RETURN TRUE OR FALSE
;———————————————————————————

;Returns true if you pressed the same hotkey twice in a row (will return true on the false on the first press either way)
F_isSameHotkeyTwice(howLong:=200) {
   if (A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong)
      return True
   else 
      return False
}

;Returns true if you pressed the same hotkey twice in a row (won't also return false on double press)
F_isDoublePressed(whichKey, howLong:="0.1") {
   KeyWait whichKey, "U"
   if KeyWait(whichKey, "D T" . howLong) {
      KeyWait(whichKey, "U") ;If you don't, first return false and then true from one double press
      return True
   }
   else 
      return False
}

;Returns True if a key was held for your specified time, false if tapped quickly
F_isKeyHeld(whichKey, howLong:="0.15") {
   if KeyWait(whichKey, "U T" . howLong) 
      return False
   else 
      return True
}


;SEND
;—————————————————————————

;Sends one thing on single press, sends both consecutively on double press
F_ifSameHotkeyTwice_Send(toSend1, toSend2, howLong:=200) {
   if (A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong)
      Send toSend2
   else 
      Send toSend1

}

;Sends one thing on a single press, a different one on a double press
F_ifDoublePressed_Send(whichKey, toSend1, toSend2, howLong:="0.1") {
   KeyWait whichKey, "U"
   if KeyWait(whichKey, "D T" . howLong)
      Send(toSend1), KeyWait(whichKey, "U")
   else 
      Send toSend2
}

;Send one thing if pressed quickly, a different one if held
F_ifKeyHeld_Send(whichKey, toSend1, toSend2, howLong:="0.15") {
   if KeyWait(whichKey, "U T" . howLong)
      Send toSend1
   else 
      Send toSend2
}


;CONTROLCLICK
;———————————————————————————————————————

;ControlClicks one place on a single press, a different one on a double press
F_ifDoublePressed_ControlClick(whichKey, coord1, coord2, winTitle:="", howLong:="0.1") {
   KeyWait whichKey, "U"
   if KeyWait(whichKey, "D T" . howLong)
      ControlClick(coord1, winTitle), KeyWait(whichKey, "U")
   else 
      ControlClick coord2, winTitle
}

