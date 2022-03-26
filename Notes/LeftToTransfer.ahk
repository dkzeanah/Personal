
;Opens a msgbox showing the exact time
+!q::
FormatTime, currentFullTime_time,, H:mm
FormatTime, currentFullTime_weekDay,, dddd 
FormatTime, currentFullTime_date,, d MMMM 
MsgBox, 4096, Current time, %currentFullTime_time%`n%currentFullTime_weekDay%`n%currentFullTime_date%
return


;Get the root to the exe of the active window and put it into your clipboard
#F5::
WinGet, windowExe, ProcessPath, A
((windowExe) ? (Clipboard := windowExe))
return

;Opens a gui that lets you select a file. Gets the path to that file into your clipboard.
#F7::
FileSelectFile, FilePath,, %A_WorkingDir%, Select a file
((FilePath) ? (Clipboard := FilePath))
return

;Opens a gui that lets you select a folder. Gets the path to that folder into your clipboard.
#F8::
FileSelectFolder, FolderPath, C:\, 3, Select a folder
((FolderPath) ? (Clipboard := FolderPath))
return


