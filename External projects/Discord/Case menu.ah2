SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.
#SingleInstance Force
; if !A_IsAdmin {
;    Run *RunAs A_ScriptFullPath  ; Requires v1.0.92.01+
;    ExitApp
; } ;the syntax is confusing, idk how to make it work

GroupAdd "AllWindows" ;is this necessary? ahk_group is not used in this script

;You can't name variables names that are used in something else, so no O_Case, Switch, if, else, A_ScriptDir and so own for your own variables
O_Case := Menu() ;In v2 with guis, and apparently menus you first create an object and then use that object to refer to the gui/menu to do anything. For buttons, controls, so on you create a different object
O_Case.Add("&UPPERCASE", v1_Gb_ultCase) ;Labels are gone in v2, so functions are used instead. Annoying thing is: you can't just call the function, you have to call a function *object* (this is required at least in guis) so if your function doesn't require parameters, just omit the brackets and you're good
O_Case.Add("&lowercase", v1_Gb_ultCase)
O_Case.Add("&Title Case", v1_Gb_ultCase)
O_Case.Add("&Sentence case", v1_Gb_SentenceCase)
O_Case.Add("&Nothing") ;Your fifth one was missing, I imagine it's blank on purpose?
O_Case.Add("&Fix Linebreaks", v1_Gb_linebreaksCase)
O_Case.Add("&Reverse", v1_Gb_ReverseCase)

^CapsLock:: {
   v1_F_GetText()
   O_Case.Show()
}

;A_ThisMenuItemPos is not a thing anymore
v1_Gb_ultCase() {
   TempText := StrLower(TempText)
   v1_F_PutText(TempText)
}

v1_Gb_SentenceCase() {
   ; TempText := StrLower(TempText)
   ; TempText := RegExReplace(TempText, "((?:^|[.!?]\s+)[a-z])", "$u1")
   TempText := RegExReplace(StrLower(TempText), "((?:^|[.!?]\s+)[a-z])", "$u1") ;You can chain functions, which is slightly faster
   v1_F_PutText(TempText)
}

v1_Gb_linebreaksCase() {
   TempText := RegExReplace(TempText, "\R", "`r`n")
}

v1_Gb_ReverseCase() {
   Temp2 :=
   TempText := StrReplace(TempText, "`r`n", Chr(29))
   Loop Parse, TempText
   Temp2 := A_LoopField . Temp2
   TempText := StrReplace(Temp2, Chr(29), "`r`n")
}

; Handy function.
; Copies the selected text to a variable while preserving the a_clipboard.
v1_F_GetText() ;I recommend ALWAYS using := rather than =
{
   SavedClip := ClipboardAll()
   A_Clipboard :=
   Send "^c"
   if !ClipWait(0.5) {
      A_Clipboard := SavedClip
      MyText := ""
   }
   MyText := A_Clipboard
   A_Clipboard := SavedClip
   Return MyText
}

; Pastes text from a variable while preserving the a_clipboard.
v1_F_PutText(MyText)
{
   SavedClip := ClipboardAll()
   A_Clipboard :=              ; For better compatability
   Sleep 20                    ; with A_Clipboard History
   A_Clipboard := MyText
   Send "^v"
   Sleep 100
   A_Clipboard := SavedClip
   ; Return ;if you don't make a function return a value, the return serves no purpose
}
