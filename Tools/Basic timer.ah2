SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should

Timer_Input := InputBox("Enter time in minutes:", "Timer")
if (!Timer_Input.Value) || ((Timer_Input.Value // Timer_Input.Value) != 1)
   ExitApp
else if Timer_Input.Value < 0
{
   MsgBox "Go fuck yourself smartass", "Timer", "4096"
   ExitApp
}
else if Timer_Input.Result == "Cancel"
   ExitApp
else 
{
   End_Second := A_Sec
   if ((Timer_Input.Value // 60) >= 1) ;calculates for if the time is more than an hour
   {
      End_Hour := A_Hour + (Timer_Input.Value // 60), End_Minutes := A_Min + Mod(Timer_Input.Value, 60)
      if (End_Minutes >= 60) ;accounts for if the end time becomes something like 4:78, making it 5:18
         End_Hour := End_Hour + (End_Minutes // 60), End_Minutes := Mod(End_Minutes, 60) 
   }
   else 
   {
      End_Hour := A_Hour, End_Minutes := A_Min + Timer_Input.Value
      if (End_Minutes >= 60) ;line 21 comment
         End_Hour++, End_Minutes := Mod(End_Minutes, 60) 
   }
   if End_Hour >= 24 
      End_Hour := Mod(End_Hour, 24) ;if the ringing time becomes later than 24 hours, turns that into next day hours, meaning 00 and on
   SetTimer isItTimeYet, 1000 
} 

;Checks for if it's the ringing time every second.
isItTimeYet()
{
   if (A_Hour == End_Hour) AND (A_Min == End_Minutes) AND (A_Sec >= End_Second)
   {
      SoundPlay("*-1")
      MsgBox "Time's up!", "Timer", "4096"
      ExitApp
   }
}

#F6::
{
   Result := MsgBox("The timer will ring on " . End_Hour . ":" . End_Minutes . "`n`nYes: Start a new timer, overwriting the current one`nNo: Continue the timer as normal`nCancel: Exit the timer", "Timer", "4355")
   Switch Result
   {
      Case "Yes":Run A_ScriptFullPath
      Case "No":return
      Case "Cancel":ExitApp
   }
}