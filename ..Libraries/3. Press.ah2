;You pressed twice and both inputs are counted: the first one as the first one and the second one as the "twice" one, so there will be both of the actions
Class C_Twice {

   ;Returns false then true if you pressed a hotkey twice, othewise just false
   twc_Bool(howLong:=200) {
      return (A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong)
   }
   twc_Bool => (A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= 200)

   ;Sends first thing on single press, sends both consecutively on double press
   twc_Send(toSend1, toSend2, howLong:=200) {
      Send((A_PriorHotkey == A_ThisHotkey) && (A_TimeSincePriorHotkey <= howLong) 
         ? toSend2 
         : toSend1)
   }
}
Twice := C_Twice()

;If there's a double press, the first press gets ignored, but to achieve this, there's a delay
Class C_Double {

   ;Returns true on double press, false on single press
   dbl_Bool(whichKey, howLong:="0.1") {
      KeyWait whichKey, "U"
      if KeyWait(whichKey, "D T" . howLong) {
         KeyWait(whichKey, "U") ;If you don't, will first return false and then true from one double press
         return True
      }
      else 
         return False
   }

   ;Sends first thing on a single press, the second one on a double press
   dbl_Send(whichKey, toSend1, toSend2, howLong:="0.1") {
         KeyWait(whichKey, "U")
      , (KeyWait(whichKey, "D T" . howLong)
         ? (Send(toSend1), KeyWait(whichKey, "U"))
         : Send(toSend2))
   }

}
Double := C_Double()

;Short or long press
Class C_Hold {

   ;Returns true if a key was held for your specified time, false if tapped quickly
   hld_Bool(whichKey, howLong:="0.15") {
      return !KeyWait(whichKey, "U T" . howLong)
   } 

   ;Sends first thing if pressed quickly, the second one if held
   hld_Send(whichKey, toSend1, toSend2, howLong:="0.15") {
      Send((KeyWait(whichKey, "U T" . howLong) 
         ? toSend1 
         : toSend2))
   }

   ;ControlClicks one place on a single press, a different one on a double press
   hld_ControlClick(whichKey, coord1, mouseButton1:="", coord2:="", mouseButton2:="", winTitle:="", howLong:="0.1") {
      KeyWait(whichKey, "U"), (KeyWait(whichKey, "D T" . howLong) 
      ? (ControlClick(coord1, winTitle,, mouseButton1), KeyWait(whichKey, "U")) 
      : ControlClick(coord2, winTitle,, mouseButton2))
   }

}
Hold := C_Hold()