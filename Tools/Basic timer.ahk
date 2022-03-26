#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;Only launch 1 instance of this script.
SetBatchLines, -1

InputBox, Timer_Input, Timer, Enter time in minutes:
if (!Timer_Input) || (ErrorLevel) || ((Timer_Input // Timer_Input) != 1)
   ExitApp
else if (Timer_Input < 0)
{
   MsgBox, 4096,, Go fuck yourself smartass
   ExitApp
}
else 
{
   End_Second := A_Sec
   if ((Timer_Input // 60) >= 1) ;calculates for if the time is more than an hour
   {
      End_Hour := A_Hour + (Timer_Input // 60), End_Minutes := A_Min + Mod(Timer_Input, 60)
      if (End_Minutes >= 60) ;accounts for if the end time becomes something like 4:78, making it 5:18
         End_Hour := End_Hour + (End_Minutes // 60), End_Minutes := Mod(End_Minutes, 60) 
   }
   else 
   {
      End_Hour := A_Hour, End_Minutes := A_Min + Timer_Input
      if (End_Minutes >= 60) ;line 21 comment
         End_Hour++, End_Minutes := Mod(End_Minutes, 60) 
   }
   ((End_Hour >= 24) ? (End_Hour := Mod(End_Hour, 24))) ;if the ringing time becomes later than 24 hours, turns that into next day hours, meaning 00 and on
   SetTimer, isItTimeYet, 1000 
} 

;Checks for if it's the ringing time every second.
isItTimeYet: 
if (A_Hour == End_Hour) AND (A_Min == End_Minutes) AND (A_Sec >= End_Second)
{
   SoundPlay, *-1
   MsgBox, 4096, Timer, Time's up!
   ExitApp
}
return

#SC040::
; Unfinished "how much time is left" feature
; Left_Hour := (End_Hour - A_Hour)
; Time_Left := % Left_Hour . " hours"
; Time until then: %Time_Left%`n
MsgBox, 4355, Timer, The timer will ring on %End_Hour%:%End_Minutes%`n`nYes: Start a new timer, overwriting the current one`nNo: Continue the timer as normal`nCancel: Exit the timer
IfMsgBox, Yes ;Discard the current timer and start a new one
   Run, %A_ScriptFullPath%
IfMsgBox, No ;Continue on as usual
   return 
IfMsgBox, Cancel ;Exit the timer
   ExitApp