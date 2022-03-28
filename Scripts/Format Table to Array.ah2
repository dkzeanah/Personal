A_Clipboard := StrReplace(A_Clipboard, "`r`n", '", "') 
A_Clipboard := "[`"" . A_Clipboard . "`"]"
MsgBox "Done formatting table to array"