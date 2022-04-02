;Opens a msgbox showing the exact time
+!q::
FormatTime, currentFullTime_time,, H:mm
FormatTime, currentFullTime_weekDay,, dddd 
FormatTime, currentFullTime_date,, d MMMM 
MsgBox, 4096, Current time, %currentFullTime_time%`n%currentFullTime_weekDay%`n%currentFullTime_date%
return