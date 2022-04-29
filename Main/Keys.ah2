SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
SetScrollLockState "AlwaysOff"
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
SetControlDelay -1
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds

#SuspendExempt True
Launch_Media:: Script.scr_Reload()
!Launch_Media::Script.scr_HardReload()
+Launch_Media::Script.scr_Suspend()
#Launch_Media::Script.scr_Reboot()
Pause::        Script.scr_Test()
+Pause::       Script.scr_Test("v1.ahk")
#SuspendExempt False
#InputLevel 5




;INCLUDES #############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Libraries
;————————————————————————————————
#Include "%A_ScriptDir%\..\Libraries\1. Base.ah2"
; Base
#Include "%A_ScriptDir%\..\Libraries\2. KeyCodes.ah2"
; D_KeyCodes_In
; D_KeyCodes_Out
#Include "%A_ScriptDir%\..\Libraries\3. Press.ah2"
; Twice
; Double
; Hold
#Include "%A_ScriptDir%\..\Libraries\4. RandomWords.ah2"
; R_RandomWords_Eng
; R_RandomWords_Rus
#Include "%A_ScriptDir%\..\Libraries\5. Win.ah2"
; Win
#Include "%A_ScriptDir%\..\Libraries\6. Global.ah2"
; F_
#Include "%A_ScriptDir%\..\Libraries\7. App.ah2"
; Chrome
; YTMusic
; YouTube
; VK
; Telegram
; Whatiber
; Discord
; Todoist
; VSC
; WPS
; Player
; Screenshot
#Include "%A_ScriptDir%\..\Libraries\8. Script.ah2"
; Script
#Include "%A_ScriptDir%\..\Libraries\9. Runner.ah2"
; Runner
; TimeTable


;Script parts
;————————————————————————————————
#Include "%A_ScriptDir%\..\Main\Runner.ah2"
#Include "%A_ScriptDir%\..\Main\App.ah2"
#Include "%A_ScriptDir%\..\Main\Mouse.ah2"
#Include "%A_ScriptDir%\..\Main\Win.ah2"





;GROUPS################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


GroupAdd "Game",            "ahk_exe EtG.exe"
GroupAdd "Game",            "ahk_exe isaac-ng.exe"
GroupAdd "Game",            "ahk_exe nuclearthrone.exe"
GroupAdd "Game",            "ahk_exe METAL GEAR RISING REVENGEANCE.exe"

GroupAdd "Game_M",          "ahk_exe EtG.exe" 
GroupAdd "Game_M",          "ahk_exe isaac-ng.exe"
GroupAdd "Game_M",          "ahk_exe nuclearthrone.exe"

GroupAdd "Main",            "ahk_exe chrome.exe",, "Google Chrome"
GroupAdd "Main",            "ahk_exe Todoist.exe"
GroupAdd "Main",            "ahk_exe Telegram.exe"
GroupAdd "Main",            "ahk_exe Code.exe"
GroupAdd "Main",            "ahk_exe Discord.exe" 
GroupAdd "Main",            "AutoHotkey Help"
GroupAdd "Main",            "AutoHotkey v2 Help"

GroupAdd "Messenger",       "Google Chrome"
GroupAdd "Messenger",       "ahk_exe Telegram.exe"
GroupAdd "Messenger",       "ahk_exe Discord.exe"
GroupAdd "Messenger",       "ahk_exe WhatsApp.exe"
GroupAdd "Messenger",       "ahk_exe Viber.exe"

GroupAdd "Document",        ".doc"
GroupAdd "Document",        ".docx"

GroupAdd "Whatiber",        "ahk_exe WhatsApp.exe"
GroupAdd "Whatiber",        "ahk_exe Viber.exe"

GroupAdd "Media",           "Photos"
GroupAdd "Media",           "ahk_exe KMPlayer64.exe"

GroupAdd "AutoHotkey_Help", "AutoHotkey Help"
GroupAdd "AutoHotkey_Help", "AutoHotkey v2 Help"




;SPECIAL ##############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Long dash
!-::Send D_KeyCodes_In["long_dash"]

;Hotstring that turns into a random english word every time
:XB0*?:uclanr::F_RandomWord(R_randomWords_Eng)

;Hotstring that turns into a random russian word every time
:XB0*?:ilandh::F_RandomWord(R_randomWords_Rus)

;If I try to laugh in russian but my language is set to english, it autosets the language to russian
:X*?:[f[::Base.bsd_SwitchLanguage() 
:X*?:[ff::Base.bsd_SwitchLanguage() 
:X*?:[[f::Base.bsd_SwitchLanguage()
:X*?:f[::Base.bsd_SwitchLanguage()
:X*?:f[[::Base.bsd_SwitchLanguage()

^m:: {
   Switch {
      Default:Send "^m"
      Case WinActive("ahk_exe Discord.exe"):Discord.dsc_Markdown()
      Case WinActive("Google Chrome"):
         (WinActive("Messenger")
            ?                               VK.vk_BlankMessage()
            :                               Chrome.chr_Markdown())
   }
}

+!r:: {
   ((WinActive("ahk_exe Discord.exe")
   || WinActive("ahk_exe Telegram.exe")
   || (WinActive("ahk_exe chrome.exe") && !WinActive("YouTube")))
      ? YTMusic.ytm_LinkConverter()
      : Send("+!r"))
}


#HotIf WinActive("ahk_group Messenger")

;Alt + number sends the Unicode for a specific emoji, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😭🧐😳🤨🤔—💀
!1::F_Emoji("pleading")
!2::F_Emoji("yum")
!3::F_Emoji("exploding_head")
!4::F_Emoji("smirk_cat")
!5::F_Emoji("sunglasses")
!6::F_Emoji("sob")
!7::F_Emoji("face_with_monocle")
!8::F_Emoji("flushed")
!9::F_Emoji("face_with_raised_eyebrow")
!0::F_Emoji("thinking")
!=::F_Emoji("skull")

;Alt + F keys are emojis as well
;😩🤤💜👉👈
!F5::F_Emoji("weary")
!F6::F_Emoji("drooling")
!F7::F_Emoji("purple_heart")
!F8::F_Emoji("finger_right"), F_Emoji("finger_left")

#HotIf 



;GLOBAL ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Close active window
!Escape::Base.bsd_CloseWin()

;Alt enter in down enter
!Enter::Base.bsd_ChooseNext()

;Undo/redo
+!Left::Base.bsd_Undo()
+!Right::Base.bsd_Redo()

;Select all
Insert::Base.bsd_SelectAll()
SC047::Base.bsd_SelectAll()

;Easily accessible paste window
#Insert::Base.bsd_WinPaste()

;Cut
!Insert::Base.bsd_Cut()
!SC047::Base.bsd_Cut()

;Media hotkeys
!SC029::Media_Play_Pause
>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next


;REMAP ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Makes sure fn + function key doesn't do its native function. Commented if made into a hotkey
; Launch_Media::return ;F1
Media_Play_Pause::return ;F2
Media_Stop::return ;F3
Media_Prev::return ;F4
Media_Next::return ;F5
Volume_Mute::return ;F6
Volume_Up::return ;F7
; Volume_Down::return ;F8
Launch_App1::return ;F9
; Launch_Mail::return ;F10
; Launch_App2::return ;F11
Browser_Home::return ;F12

;Useless numpad
*NumpadMult::return
*NumpadDiv::return
*NumpadAdd::return
*NumpadSub::return
*NumLock::return
*Numpad0::return
*Numpad1::return
*NumpadDot::return
*NumpadEnter::return
*PrintScreen::return

;Numpad is special buttons
#SuspendExempt True
#InputLevel 6
SC047::Insert
SC04B::Delete
SC048::Home
SC04C::End
SC049::PgUp
SC04D::PgDn
SC050::Launch_Media
ScrollLock::Launch_Media
SC051::SC045
AppsKey::LCtrl
#InputLevel 5
#SuspendExempt False

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game 
#HotIf WinActive("ahk_group Game_M")
*XButton1::u
*XButton2::y
*Volume_Down::i

#HotIf WinActive("ahk_exe METAL GEAR RISING REVENGEANCE.exe")
*XButton1::u
*XButton2::LCtrl
*Volume_Down::i
*CapsLock::Enter

#HotIf 




;TOOLS ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Opens an inputbox for you to input how many minutes to wait, plays a sound and opens a msgbox saying the time has passed after it has. Press the same hotkey while the timer is running to see when it will ring and three options: start a new timer, discarding the current one, continue on, exit the timer
#F5::Run A_WorkingDir . "\Tools\Basic timer.ah2"

;Get the root to the exe of the active window and put it into your clipboard
#F6::A_Clipboard := WinGetProcessPath("A")

;Get the name of the active window and put it into your clipboard
#F7::A_Clipboard := WinGetTitle("A")

;Opens a fileselect in the current folder for you to choose a file to get the path of into your clipboard
#HotIf WinActive("ahk_exe explorer.exe")
#F8::A_Clipboard := FileSelect("S", WinGetTitle("A"))
#HotIf 

;Gets current cursor's position and opens a gui giving you the options for formatting the parameters for different commands to put them into your Clipboard or to not copy them into your Clipboard at all and just exit the gui
+!f::Run A_WorkingDir . "\Tools\MouseGetPos.ah2"

;Opens a msgbox showing the exact time
+!t:: {
     clock_time := FormatTime(, "H:mm")
   , clock_weekDay := FormatTime(, "dddd")
   , clock_date := FormatTime(, "d MMMM")
   , MsgBox(clock_time . "`n" . clock_weekDay . "`n" . clock_date, "Current time", "4096")
}