#SingleInstance Force 

O_timerInput := InputBox("Enter time in minutes:", "Timer")
if (!O_timerInput.Value) || ((O_timerInput.Value // O_timerInput.Value) != 1) || (O_timerInput.Result == "Cancel")
   ExitApp
else if O_timerInput.Value < 0 {
   MsgBox("Go fuck yourself smartass", "Timer", "4096")
   , ExitApp()
}
else {
   endSecond := A_Sec
   if ((O_timerInput.Value // 60) >= 1) { ;calculates for if the time is more than an hour
      endHour := A_Hour + (O_timerInput.Value // 60)
      , endMinute := A_Min + Mod(O_timerInput.Value, 60)
      if (endMinute >= 60) ;accounts for if the end time becomes something like 4:78, making it 5:18
         endHour := endHour + (endMinute // 60)
         , endMinute := Mod(endMinute, 60) 
   }
   else {
      endHour := A_Hour
      , endMinute := A_Min + O_timerInput.Value
      if (endMinute >= 60) ;line 21 comment
         endHour++
         , endMinute := Mod(endMinute, 60) 
   }
   ((endHour >= 24)
      ? endHour := Mod(endHour, 24) : "") ;if the ringing time becomes later than 24 hours, turns that into next day hours, meaning 00 and on
   , SetTimer(tmr_IsItTimeYet, 1000)
} 

;Checks for if it's the ringing time every second.
tmr_IsItTimeYet()
{
   (((A_Hour == endHour) && (A_Min == endMinute) && (A_Sec >= endSecond))
      ? (SoundPlay("*-1"),
         MsgBox("Time's up!", "Timer", "4096"),
         ExitApp() : ""))
   
}

$#F5:: {
   result := MsgBox("The timer will ring on " . endHour . ":" . endMinute . "`n`nYes: Start a new timer, overwriting the current one`nNo: Continue the timer as normal`nCancel: Exit the timer", "Timer", "4355")
   Switch result {
      Case "Yes":Run A_ScriptFullPath
      Case "No":return
      Case "Cancel":ExitApp
   }
}