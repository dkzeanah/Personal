SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts
#InputLevel 5
SetScrollLockState "AlwaysOff"
SetNumLockState "AlwaysOn"
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
CoordMode "Pixel", "Client"
SetControlDelay -1
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds

#SuspendExempt True
ScrollLock::   Script.scr_Reload()
!ScrollLock::  Script.scr_HardReload()
+ScrollLock::  Script.scr_Suspend()
#ScrollLock::  Script.scr_Reboot()
Pause::        Script.scr_Test()
#SuspendExempt False




;INCLUDES #############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Libraries
;————————————————————————————————
#Include "%A_ScriptDir%\..\_Libraries\Func\1. Base.ah2"
; Base
#Include "%A_ScriptDir%\..\_Libraries\Func\2. Press.ah2"
; Twice
; Double
; Hold
#Include "%A_ScriptDir%\..\_Libraries\Func\3. Global.ah2"
#Include "%A_ScriptDir%\..\_Libraries\Func\4. Win.ah2"
; Win
#Include "%A_ScriptDir%\..\_Libraries\Func\5. App.ah2"
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
#Include "%A_ScriptDir%\..\_Libraries\Func\6. Script.ah2"
; Script
#Include "%A_ScriptDir%\..\_Libraries\Func\7. Runner.ah2"
; Runner
; TimeTable

#Include "%A_ScriptDir%\..\_Libraries\Var\1. KeyCodes.ah2"
; D_KeyCodes_In
; D_KeyCodes_Out
#Include "%A_ScriptDir%\..\_Libraries\Var\2. RandomWords.ah2"
; R_RandomWords_Eng
; R_RandomWords_Rus
#Include "%A_ScriptDir%\..\_Libraries\Var\3. Links.ah2"
; Links


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


  GroupAdd("Game",            "ahk_exe EtG.exe")
, GroupAdd("Game",            "ahk_exe isaac-ng.exe")
, GroupAdd("Game",            "ahk_exe nuclearthrone.exe")
, GroupAdd("Game",            "ahk_exe METAL GEAR RISING REVENGEANCE.exe")

, GroupAdd("Game_M",          "ahk_exe EtG.exe" )
, GroupAdd("Game_M",          "ahk_exe isaac-ng.exe")
, GroupAdd("Game_M",          "ahk_exe nuclearthrone.exe")

, GroupAdd("Main",            "ahk_exe chrome.exe",, "Google Chrome")
, GroupAdd("Main",            "ahk_exe Todoist.exe")
, GroupAdd("Main",            "ahk_exe Telegram.exe")
, GroupAdd("Main",            "ahk_exe Code.exe")
, GroupAdd("Main",            "ahk_exe Discord.exe" )
, GroupAdd("Main",            "AutoHotkey Help")
, GroupAdd("Main",            "AutoHotkey v2 Help")

, GroupAdd("Messenger",       "Google Chrome")
, GroupAdd("Messenger",       "ahk_exe Telegram.exe")
, GroupAdd("Messenger",       "ahk_exe Discord.exe")
, GroupAdd("Messenger",       "ahk_exe WhatsApp.exe")
, GroupAdd("Messenger",       "ahk_exe Viber.exe")

, GroupAdd("Document",        ".doc")
, GroupAdd("Document",        ".docx")

, GroupAdd("Whatiber",        "ahk_exe WhatsApp.exe")
, GroupAdd("Whatiber",        "ahk_exe Viber.exe")

, GroupAdd("Media",           "Photos")
, GroupAdd("Media",           "ahk_exe KMPlayer64.exe")

, GroupAdd("AutoHotkey_Help", "AutoHotkey Help")
, GroupAdd("AutoHotkey_Help", "AutoHotkey v2 Help")

, GroupAdd("MinMax", "ahk_exe FL64.exe")
, GroupAdd("MinMax", "ahk_exe Resolve.exe")
, GroupAdd("MinMax", "GIMP ahk_exe gimp-2.10.exe")
, GroupAdd("MinMax", "SoundCloud ahk_exe chrome.exe")
, GroupAdd("MinMax", "ahk_group AutoHotkey_Help")
, GroupAdd("MinMax", "Monkeytype ahk_exe chrome.exe")




;SPECIAL ##############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Long dash
!-::Send D_KeyCodes_In["long_dash"]
+!-::Send D_KeyCodes_In["middle_dot"]

;Hotstring that turns into a random english word every time
:XB0*?:uclanr::Runner.nur_RandomWord(R_randomWords_Eng)

;Hotstring that turns into a random russian word every time
:XB0*?:ilandh::Runner.nur_RandomWord(R_randomWords_Rus)

;If I try to laugh in russian but my language is set to english, it autosets the language to russian
:X*?:[f[::Base.bsd_LanguageRus()
:X*?:[ff::Base.bsd_LanguageRus()
:X*?:[[f::Base.bsd_LanguageRus()
:X*?:f[::Base.bsd_LanguageRus()
:X*?:f[[::Base.bsd_LanguageRus()

#HotIf WinActive("ahk_group Messenger")

;Alt + number sends the Unicode for a specific emoji, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😭🧐😳🤨🤔—💀
!1::Runner.nur_Emoji("pleading")
!2::Runner.nur_Emoji("yum")
!3::Runner.nur_Emoji("exploding_head")
!4::Runner.nur_Emoji("smirk_cat")
!5::Runner.nur_Emoji("sunglasses")
!6::Runner.nur_Emoji("sob")
!7::Runner.nur_Emoji("face_with_monocle")
!8::Runner.nur_Emoji("flushed")
!9::Runner.nur_Emoji("face_with_raised_eyebrow")
!0::Runner.nur_Emoji("thinking")
!=::Runner.nur_Emoji("skull")

;😩🤤💜👉👈
!F5::Runner.nur_Emoji("weary")
!F6::Runner.nur_Emoji("drooling")
!F7::Runner.nur_Emoji("purple_heart")
!F8::Runner.nur_Emoji("finger_right"), Runner.nur_Emoji("finger_left")

#HotIf 



;GLOBAL ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


!Escape::Win.niw_CloseWin()

!BackSpace::Send("{BackSpace 4}")

;Undo/redo
+!Left::Base.bsd_Undo()
+!Right::Base.bsd_Redo()

#Up::Win.niw_MaximizeWin()
#Down::Win.niw_WinRestoreDown()
#Right::Base.bsd_WinRestore("right")
#Left::Base.bsd_WinRestore("left")

Insert::Base.bsd_SelectAll()

#Insert::Base.bsd_WinPaste()

!Insert::Base.bsd_Cut()

;Media hotkeys
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


#HotIf WinActive("ahk_exe Code.exe")
SC04F:: VSC.vsc_RunCurrentInTerminal()
!SC04F::VSC.vsc_KillCurrentTerminalOrDebug()
^SC04F::VSC.vsc_Debug()
#HotIf 

SC050:: Script.scr_Reload()
!SC050::Script.scr_HardReload()
+SC050::Script.scr_Suspend()
#SC050::Script.scr_Reboot()

SC051:: Script.scr_Test()
+SC051::Script.scr_Test("v1.ahk")
!SC051::Send "!{Pause}"

SC04B::Delete
SC04C::End
SC04D::PgDn

SC047:: Base.bsd_SelectAll()
#SC047::Base.bsd_WinPaste()
!SC047::Base.bsd_Cut()

SC048::Home
SC049::PgUp
AppsKey::LCtrl
SC138::LAlt

Launch_Media::    return        ;F1
Media_Play_Pause::return        ;F2
; Media_Stop::      return        ;F3
Media_Prev::      return        ;F4
Media_Next::      return        ;F5
Volume_Mute::     return        ;F6
Volume_Up::       return        ;F7
Volume_Down::     return        ;F8
Launch_App1::     return        ;F9
Launch_Mail::     return        ;F10
Launch_App2::     return        ;F11
Browser_Home::    return        ;F12

*NumpadMult:: return
*NumpadDiv::  return
*NumpadAdd::  return
*NumpadSub::  return
*Numpad0::    return
*Numpad1::    return
*NumLock::    return
*NumpadDot::  return
*NumpadEnter::return

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game 
#HotIf WinActive("ahk_group Game_M")
XButton1::u
XButton2::y
Media_Stop::i

#HotIf WinActive("ahk_exe METAL GEAR RISING REVENGEANCE.exe")
*XButton1::u
*XButton2::LCtrl
*Media_Stop::i
*CapsLock::Enter

#HotIf 




;TOOLS ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Opens an inputbox for you to input how many minutes to wait, plays a sound and opens a msgbox saying the time has passed after it has. Press the same hotkey while the timer is running to see when it will ring and three options: start a new timer, discarding the current one, continue on, exit the timer
#F5::Run A_WorkingDir . "\Tools\Basic timer.ah2"

#F6::FileSearch(False)

+!f::CoordGetter()
+!g::WindowGetter()

+!t::Clock()

;Because markdown image paste
#HotIf !WinActive("ahk_exe Code.exe")
+!v::YTMusic.ytm_LinkConverter()
#HotIf 