SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#InputLevel 5 ;Makes sure hotkeys can't activate themselves (effectively $ on every hotkey)
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
SetControlDelay -1 ;Even faster ControlClick/Send
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds
#Include "%A_ScriptDir%\..\_Libraries\Func\6. Script.ah2"
#Include "%A_ScriptDir%\..\_Libraries\Func\3. Global.ah2"
#Include "%A_ScriptDir%\..\_Libraries\Func\1. Base.ah2"
#Include "%A_ScriptDir%\..\_Libraries\Func\2. Press.ah2"

Class C_OnePiece { ;In a class so it's easy to use the episode number as a variable
   
   NextEpisode := 0

   onp_SetEpidode(epNum) => this.NextEpisode := epNum + 1 ;We bind the found last downloaded episode to the class' variable, incrementing it by one, meaning "next episode"

   onp_DownloadEpisodes() => RunLink("https://gogoanime.sk/one-piece-episode-" . this.NextEpisode) ;Opens the page to download the next episode

   onp_PasteAndIncr() => (ClipSend(this.NextEpisode), this.NextEpisode++, Send("{Enter}")) ;Pastes the next episode's number in the download screen and increments it once again

}
OnePiece := C_OnePiece()

, R_AllFiles := []
Loop Files "C:\Files\Pictures\One piece\*.mp4" {
   R_AllFiles.Push(A_LoopFileName) ;Push all the file names into an array
}
LastEpisode := R_AllFiles[-1] ;And retrive the last file name. Strange way to get it, ik

, OnePiece.onp_SetEpidode(LastEpisode) ;Now that we have the last file's number, we set it to the class' variable
, OnePiece.onp_DownloadEpisodes() ;And open the next episode

#HotIf WinActive("Save As ahk_exe chrome.exe")
CapsLock::OnePiece.onp_PasteAndIncr()
#HotIf WinActive("Google Chrome ahk_exe chrome.exe")
CapsLock::Base.bsd_CloseTab()
#HotIf ;With hotifs you can use the same button for the two actions you're going to be doing the most

Esc::Script.scr_ExitApp()