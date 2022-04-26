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




;VARIABLES ############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Functions that send hotkeys that work pretty much everywhere (for readability)
#Include "%A_ScriptDir%\..\Libraries\1. Base.ah2"

;A dictionary of key names and SC codes of them
#Include "%A_ScriptDir%\..\Libraries\2. KeyCodes.ah2"

;Functions for multiple presses
#Include "%A_ScriptDir%\..\Libraries\3. Press.ah2"

;An array of the 1000 most used english words
#Include "%A_ScriptDir%\..\Libraries\4. RandomWords.ah2"

;Functions for app window manipulation
#Include "%A_ScriptDir%\..\Libraries\5. Win.ah2"

;Other functions that work everywhere
#Include "%A_ScriptDir%\..\Libraries\6. Global.ah2"

;Functions for clicking and opening stuff in different apps, for readability
#Include "%A_ScriptDir%\..\Libraries\7. App.ah2"

;Functions that do something with the current script
#Include "%A_ScriptDir%\..\Libraries\8. Script.ah2"

;Functions that are used in the runner
#Include "%A_ScriptDir%\..\Libraries\9. Runner.ah2"

GroupAdd "Game",            "ahk_exe EtG.exe"
GroupAdd "Game",            "ahk_exe isaac-ng.exe"
GroupAdd "Game",            "ahk_exe nuclearthrone.exe"
GroupAdd "Game",            "ahk_exe METAL GEAR RISING REVENGEANCE.exe"

GroupAdd "Game_M",          "ahk_exe EtG.exe" 
GroupAdd "Game_M",          "ahk_exe isaac-ng.exe"
GroupAdd "Game_M",          "ahk_exe nuclearthrone.exe"

GroupAdd "Main",            "ahk_exe chrome.exe"
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




;KBMAIN ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;SPECIAL CHARACTERS
;————————————————————

;Long dash
!-::Send D_KeyCodes_In["long_dash"]

;Hotstring that turns into a random english word every time
:XB0*?:uclanr::F_RandomWord(R_randomWords_Eng)

;Hotstring that turns into a random russian word every time
:XB0*?:ilandh::F_RandomWord(R_randomWords_Rus)

;If I try to laugh in russian but my language is set to english, it autosets the language to russian
:X*?:[f[f::Base.bsd_SwitchLanguage() 
:X*?:[[f[f::Base.bsd_SwitchLanguage()


;GLOBAL MANIPULATION
;—————————————————————————————

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
PrintScreen::return

;Numpad is special buttons
#SuspendExempt True
SC047::Insert
SC04B::Delete
SC048::Home
SC04C::End
SC049::PgUp
SC04D::PgDn
SC050::Launch_Media
SC051::SC045
ScrollLock::Launch_Media
AppsKey::LCtrl
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




;RUNNER ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Runner
+!l:: {
   O_Runner := InputBox("What do you want to run?", "Runner")
   if O_Runner.Result = "Cancel" 
      return
   Switch O_Runner.Value {

      ;WEBSITES
      ;——————————————————

      ;Reddit
      Case "reddit":F_RunLink("https://www.reddit.com/notifications")
      ;Instagram
      Case "inst", "instagram":F_RunLink("https://www.instagram.com/")
      ;Twitter
      Case "twit", "twitter":F_RunLink("https://twitter.com/home")
      ;Eкурсы
      Case "eku":F_RunLink("https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . TimeTable.tmt_Month())
      ;MyAnimeList
      Case "mal":F_RunLink("https://myanimelist.net/profile/Axlefublr")
      ;Metta
      Case "metta":F_RunLink("https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4")
      ;Weather
      Case "weather":F_RunLink("https://yandex.ru/pogoda/krasnoyarsk")
      ;Watch movies
      Case "movies":F_RunLink("https://watchmovieshd.ru/")
      ;Gogoanime
      Case "gogoanime":F_RunLink("https://gogoanime.fi/")
      ;Mvideo
      Case "mvideo":F_RunLink("https://www.mvideo.ru/")
      ;Steam keys
      Case "zaka", "zakazaka":F_RunLink("https://zaka-zaka.com/")
      ;Barbershop
      Case "barber":F_RunLink("https://b73723.yclients.com/company/89170/menu?o=")
      ;Emoji unicodes
      Case "emoji":F_RunLink("https://www.alt-codes.net/smiley_alt_codes.php")
      ;Share files
      Case "share files":F_RunLink("https://files.fm/")


      ;РАСПИСАНИЕ
      ;————————————————————

      Case "tom", "tomorrow":
         Switch A_WDay {
            Default:TimeTable.tmt_Day("Monday")
            Case 2:TimeTable.tmt_Day("Tuesday")
            Case 3:TimeTable.tmt_Day("Wednesday")
            Case 4:TimeTable.tmt_Day("Thursday")
            Case 5:TimeTable.tmt_Day("Friday")
         }
      Case "today":
         Switch A_WDay {
            Default:TimeTable.tmt_Day("Monday")
            Case 3:TimeTable.tmt_Day("Tuesday")
            Case 4:TimeTable.tmt_Day("Wednesday")
            Case 5:TimeTable.tmt_Day("Thursday")
            Case 6:TimeTable.tmt_Day("Friday")
         }
      Case "week":F_RunLink(TimeTable.tmt_Full)
      Case "monday":TimeTable.tmt_Day("Monday")
      Case "tuesday":TimeTable.tmt_Day("Tuesday")
      Case "wednesday":TimeTable.tmt_Day("Wednesday")
      Case "thursday":TimeTable.tmt_Day("Thursday")
      Case "friday":TimeTable.tmt_Day("Friday")


      ;VS CODE
      ;—————————————————

      Case "syntax":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\syntaxes\ahk.tmLanguage.json"
      Case "keybind":Run "C:\Users\serge\AppData\Roaming\Code\User\keybindings.json"
      Case "settings":Run "C:\Files\Programming\Personal\Backups\settings.json"
      Case "tasks":Run "C:\Users\serge\AppData\Roaming\Code\User\tasks.json"
      Case "extensions":Run "C:\Users\serge\.vscode\extensions"
      Case "package":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\package.json"


      ;TASKS
      ;———————————————————

      Case "new project tasks":Run A_WorkingDir . "\Scripts\New project tasks.py"
      Case "click counter":Run A_WorkingDir . "\Tools\Click counter.ah2"
      Case "discovery add":Run A_WorkingDir . "\Tools\Discovery add.ah2"
      Case "add to playlist", "atp", "ytp":Run A_WorkingDir . "\Tools\Add to Playlist.ah2"
      Case "format table to array":Runner.nur_FormatTableToArray()
      Case "startup":Runner.nur_StartupRun()
      Case "coin flip":Runner.nur_CoinFlip()
      Case "converter", "conv":Runner.nur_Converter()
      Case "ytm":YTMusic.ytm_LinkConverter()
      Case "lib", "libload":Runner.nur_LibLoad()
      Case "artists count":Runner.nur_ArtistsCount()


      ;GITHUB
      ;————————————————————
      
      Case "gitpage", "gitfile", "gitlink":Runner.nur_GitPage("paste")
      Case "git":Runner.nur_GitPage("run")
      Case "github":F_RunLink("https://github.com/Axlefublr")

      ;Github nicknames
      Case "git Micha":F_ClipSend("@Micha-ohne-el")


      ;AHK 
      ;————————————————————————————————

      ;Tutorials
      Case "ahk yt startup":F_ClipSend("https://youtu.be/vjQIbagvkcs")
      Case "ahk yt arrow":F_ClipSend("https://youtu.be/nSTL3KND25c")

      ;Told often
      Case "ahk directories v1":F_ClipSend(Runner.nur_Directories_v1)


      ;MEMES
      ;————————————

      ;My source is that I made it the fuck up
      Case "I made it the fuck up", "I made it up":F_ClipSend("https://www.youtube.com/watch?v=r7l0Rq9E8MY")
      ;Funny mic
      Case "funny mic":F_ClipSend("https://www.youtube.com/watch?v=jfbKJy_ZuIU")
      ;Delay lama vs meowsynth
      Case "delay lama":F_ClipSend("https://www.youtube.com/watch?v=Np4iG7-se7I")
      ;I quickly became homophobic
      Case "I quickly became homophobic":F_ClipSend("https://www.youtube.com/watch?v=m2ksGuqf8eo")
      ;If you design a quest
      Case "if you design a quest":F_ClipSend("https://www.youtube.com/watch?v=chn0ggv9TdY")
      ;Zoro is racist 100% not even imo
      Case "zoro is racist":F_ClipSend("https://www.youtube.com/watch?v=kb_udP2ZeF8")
   }
}

;Easy way to reactivate the previous window after using the quick add task of todoist
+!x:: {
   prevActWin := WinGetID("A")
   Send "^+!x"
   (WinWait("ahk_exe Todoist.exe",, 7) 
      ? SetTimer(ReactivatePrevActWin, 200) : "")
   
   ;Waits for the quick add task window to disappear and as soon as it does, reactivates the window it was called from
   ReactivatePrevActWin() => (
      (!WinActive("ahk_exe Todoist.exe"))
         ? (WinActivate("ahk_id " . prevActWin),
            SetTimer(ReactivatePrevActWin, 0)) : ""
   ) 
}




;APP DIFFERENT KEYS ###################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf !WinActive("ahk_group Game")

XButton1 & Volume_Down:: {
   Switch {
      Case WinActive("YouTube Music"):                           YTMusic.ytm_CancelSearch()
      Case YouTube.ytt_isNotWatchingVid:                         YouTube.ytt_Miniscreen()
      Case YouTube.ytt_isWatchingVid, WinActive("WatchMoviesHD"):YouTube.ytt_Fullscreen()
      Case WinActive("Messenger"):                               VK.vk_Notifications()
      Case WinActive("ahk_exe Discord.exe"):                     Discord.dsc_Emoji()
      Case WinActive("ahk_exe Code.exe"):                        Base.bsd_ShiftClick()
   }
}

XButton2 & Volume_Down:: {
   Switch {
      Case WinActive("YouTube Music"):       YTMusic.ytm_ChannelSwitch()
      Case WinActive("YouTube"):             YouTube.ytt_ChannelSwitch()
      Case WinActive("Messenger"):           VK.vk_Voice()
      Case WinActive("ahk_exe Telegram.exe"):Telegram.tlg_Voice()
      Case WinActive("ahk_group Whatiber"):  Whatiber.wtb_Voice()
      Case WinActive("ahk_exe Discord.exe"): Discord.dsc_Gif()
      Case WinActive("ahk_exe Code.exe"):    Base.bsd_Search()
   }
}

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

;Converts a YT Music link into a YT link while these windows are active, otherwise just sends itself
+!r:: {
   ((WinActive("ahk_exe Discord.exe")
   || WinActive("ahk_exe Telegram.exe")
   || (WinActive("ahk_exe chrome.exe") && !WinActive("YouTube")))
      ? YTMusic.ytm_LinkConverter()
      : Send("+!r"))
}




;MOUSE KEY INTERACTION ################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Special button + side buttons
#HotIf !WinActive("ahk_group Game") && !WinActive("Google Chrome")
Volume_Down & XButton1::Hold.hld_Send("XButton1", Base.bsd_Copy, Base.bsd_Cut)
#HotIf !WinActive("ahk_group Game") && !WinActive("ahk_exe chrome.exe")
Volume_Down & MButton::Base.bsd_SelectAll()
#HotIf !WinActive("ahk_group Game")
Volume_Down & LButton::Space
Volume_Down & XButton2::Hold.hld_Send("XButton2", Base.bsd_Paste, Base.bsd_WinPaste)

;Special button by itself pressed in different sections of the screen does different things
Volume_Down:: { 
   MouseGetPos &sectionX, &sectionY
   right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347), topRight := ((sectionX > 1707) && (sectionY < 233)), topLeft := ((sectionX < 252) && (sectionY < 229)), bottomLeft := ((sectionX < 263) && (sectionY > 849)), bottomRight := ((sectionX > 1673) && (sectionY > 839))
   Switch {
      Case right:
         ((topRight) ?   Base.bsd_WinUp()
         : bottomRight ? Base.bsd_WinRight()
         :               Win.niw_App("ahk_exe Discord.exe", Win.Discord))
      Case left:
         ((topLeft) ?    Base.bsd_WinDown()
         : bottomLeft ?  Base.bsd_WinLeft()
         :               Win.niw_App("ahk_exe Code.exe", Win.VScode))
      Case down:         Win.niw_App_WinNum("YouTube Music", "6")
      Case up:           Win.niw_App("Google Chrome", Win.GoogleChrome)
      Default:           Base.bsd_MouseAltTab()
   } 
}

;Combined side buttons
XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

;Far side button and Wheel
XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down

;Close side button and Wheel
XButton1 & WheelUp::Base.bsd_Redo()
XButton1 & WheelDown::Base.bsd_Undo()

;Close side button with L and R buttons 
XButton1 & LButton::BackSpace
XButton1 & RButton::Delete

;Far side button with L and R buttons
XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter




;SECTION GESTURES ####################################################################
;#####################################################################################
;#####################################################################################
;##################################################################################### 


;Far side button, does different things depending on what section of the screen it was pressed on. Right, left, down, up or middle
XButton2:: { 
   MouseGetPos &sectionX, &sectionY
   right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347), topRight := ((sectionX > 1707) && (sectionY < 233)), topLeft := ((sectionX < 252) && (sectionY < 229)) ;Here I define the sections
   Switch {
      Case right:
         Switch {
            Case WinActive("YouTube Music"), YouTube.ytt_isWatchingVid:
               YouTube.ytt_SkipNext()
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgDn}"
            Default:Send "{Media_Next}"
         }
      Case left:
         Switch {
            Case WinActive("YouTube Music"), YouTube.ytt_isWatchingVid:
               YouTube.ytt_SkipPrev()
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgUp}"
            Default:Send "{Media_Prev}"
         }
      Case down:Base.bsd_CloseWin()
      Case up:Base.bsd_MinimizeWin()
      Default:
         Send(WinActive("ahk_exe Code.exe") 
            ? "^!{Insert}" 
            : "{Browser_Forward}")
   }
}

;Close side button, does different things depending on what section of the screen it was pressed on. Right, left, down, up or middle
XButton1:: { 
   MouseGetPos &sectionX, &sectionY
   right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347), topRight := ((sectionX > 1707) && (sectionY < 233)), topLeft := ((sectionX < 252) && (sectionY < 229)), bottomLeft := ((sectionX < 263) && (sectionY > 849)), bottomRight := ((sectionX > 1673) && (sectionY > 839))
   Switch {
      Case WinActive("Google Chrome"): ;_chrome
         Switch {
            Default:      Send "{Browser_Back}"
            Case right:
               ((topRight) 
                  ?       Base.bsd_RestoreTab()
                  :       Base.bsd_NextTab())
            Case left:    Base.bsd_PrevTab()
               ; ((topLeft)
               ;    ? YouTube.ytt_)   
            Case up:      Base.bsd_NewTab()
            Case down:
               (WinActive("Messenger") 
                  ?       VK.vk_Scroll() 
                  :       Base.bsd_CloseTab())
         }
      Case WinActive("ahk_exe Code.exe"): ;_vscode
         Switch {
            Default:           VSC.vsc_Comment()
            Case right:
               ( topRight ?    VSC.vsc_IndentRight()
               : bottomRight ? Script.scr_Reload()
               :               Base.bsd_NextTab())
            Case left:
               ( topLeft ?     VSC.vsc_IndentLeft()
               : bottomLeft ?  Script.scr_Test()
               :               Base.bsd_PrevTab())
            Case down:         Base.bsd_CloseTab()
            Case up:           Send "#{PgUp}"
         }
      Case WinActive("YouTube Music"): ;_youtube music
         ytmCover := ((sectionX > 1594) && (sectionY > 686))
         Switch {
            Default:          Send "{Browser_Back}"
            Case right:
               ( topRight   ? YTMusic.ytm_Discovery()
               : ytmCover   ? YTMusic.ytm_Options()
               :              YTMusic.ytm_Fullscreen())
            Case left:
               ( topLeft    ? YTMusic.ytm_Best()
               : bottomLeft ? YTMusic.ytm_Liked()
               :              YTMusic.ytm_Library())
            Case up:          YTMusic.ytm_Like()
            Case down:        YTMusic.ytm_Dislike()
         }
      Case WinActive("ahk_exe wps.exe"): 
         Switch {
            Default:   Send "{Browser_Back}"
            Case right:WPS.wps_NextTab()
            Case left: WPS.wps_PrevTab()
            Case up:   Base.bsd_Save()
         }
      Case WinActive("ahk_exe Todoist.exe"): ;_todoist
         Switch {
            Default:   Send "{Browser_Back}"
            Case right:Todoist.tds_Project("unfinished")
            Case left: Todoist.tds_Project("rappers")
            Case down: Todoist.tds_Project("payments")
            Case up:   Todoist.tds_Project("inbox")
         }
      Case WinActive("ahk_exe Discord.exe") && down: Send "{Esc}"
      Case WinActive("ahk_exe Telegram.exe") && down:Telegram.tlg_Scroll()
      Case WinActive("ahk_group Whatiber") && down:  Whatiber.wtb_Scroll()
      Default:                                       Send "{Browser_Back}"
   } 
}




;CHROME AND YOUTUBE ###################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


#HotIf WinActive("Google Chrome") ;_chrome

;Single press is copy, double press will get current tab's link to clipboard
Volume_Down & XButton1:: {
   (Hold.hld_Bool("XButton1") 
      ? Chrome.chr_CopyLink()
      : Base.bsd_Copy())
}

F1::Send "^1"
F2::Send "^2"
F3::Send "^3"
F4::Send "^4"
F5::Send "^5"
F6::Send "^6"
F7::Send "^7"
F8::Send "^8"

F10::Send "{Volume_Up}"
F9::Send "{Volume_Down}"

+!e::Base.bsd_NewTab()

#Delete::Base.bsd_CloseTab()

+!w::(!WinActive("Messenger") ? Base.bsd_CloseTab() : "")


#HotIf WinActive("YouTube Music") ;_youtube music

F1::YTMusic.ytm_Search()
F2::YTMusic.ytm_Library()
F3::YTMusic.ytm_CancelSearch()
F4::YTMusic.ytm_Fullscreen()
F5::YTMusic.ytm_Liked()
F6::YTMusic.ytm_Best()
F7::YTMusic.ytm_Discovery()

F10::Send "{Volume_Up}"
F9::Send "{Volume_Down}"

F12::YTMusic.ytm_Like()
F11::YTMusic.ytm_Dislike()


#HotIf WinActive("ahk_exe chrome.exe")
Volume_Down & MButton::F5
^Space::Send "{Down}"

#HotIf WinActive("YouTube") ;_youtube 
PgDn::YouTube.ytt_SkipNext()
PgUp::YouTube.ytt_SkipPrev()

#HotIf YouTube.ytt_isNotWatchingVid
Escape::YouTube.ytt_MiniscreenClose()

#HotIf Youtube.ytt_isWatchingVid
>^Right::YouTube.ytt_Seek("right")
>^Left::YouTube.ytt_Seek("left")

#HotIf WinActive("WatchMoviesHD")
Up::Send "{Volume_Up}"
Down::Send "{Volume_Down}"




;OTHER ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("ahk_exe Telegram.exe") ;_telegram

;Press an F key -> go to a channel
F1::Telegram.tlg_Channel("diary")
F2::Telegram.tlg_Channel("texts")
F3::Telegram.tlg_Channel("transfer")
F4::Telegram.tlg_Channel("documents")
F5::Telegram.tlg_Channel("gallery")
F6::Telegram.tlg_Channel("мама")
F7::Telegram.tlg_Channel("кристина")
F8::Telegram.tlg_Channel("алена")
F9::Telegram.tlg_Channel("invie")


#HotIf WinActive("ahk_exe Todoist.exe") ;_todoist

;Hotkeys to jump to different projects
F1::Todoist.tds_Project("inbox") 
F2::Todoist.tds_Project("rappers") 
F3::Todoist.tds_Project("unfinished")
F4::Todoist.tds_Project("payments")
F5::Todoist.tds_Project("desires")
F6::Todoist.tds_Project("shopping") 

;Gives the current task an unfinished label and lets you edit its description
+!e::Todoist.tds_toUnfinished()

Enter::Base.bsd_ChooseNext()


#HotIf WinActive("ahk_exe Discord.exe")
MButton::Discord.dsc_Reply()




;TECH #################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("ahk_exe Code.exe") ;_vscode 

PrintScreen::VSC.vsc_RunCurrentInTerminal()
!PrintScreen::VSC.vsc_KillCurrentTerminal()

;Opens an inputbox for you to put in the name of the key to get its SC code into your clipboard, or takes the SC code to then show you to which key it belongs in a msgbox; if it finds neither, says so
+!k:: {
   (Hold.hld_Bool("k")
      ? VSC.vsc_KeyCodeGetter("to")
      : VSC.vsc_KeyCodeGetter("from"))
}


#HotIf WinActive("ahk_exe wps.exe") ;_wps

;Switch between open documents
^+Space::WPS.wps_NextTab()
^Space::WPS.wps_PrevTab()

;Save 
+!s::Base.bsd_Save()
;Close tab
+!w::Base.bsd_CloseTab()


#HotIf WinActive("ahk_exe wps.exe") && WinActive(".pptx")

;Menu tabs
F1::WPS.wps_Shortcut("h")
F2::WPS.wps_Shortcut("n")
F3::WPS.wps_Shortcut("g")
F4::WPS.wps_Shortcut("t")
F5::WPS.wps_Shortcut("a")
F6::WPS.wps_Shortcut("s")
F7::WPS.wps_Shortcut("r")
F8::WPS.wps_Shortcut("w")
F9::WPS.wps_Shortcut("k")
F10::WPS.wps_Shortcut("jd")
F11::WPS.wps_Shortcut("je")


#HotIf WinActive("ahk_exe wps.exe") && WinActive("ahk_group Document")

;Menu tabs
F1::WPS.wps_Shortcut("h")
F2::WPS.wps_Shortcut("n")
F3::WPS.wps_Shortcut("p")
F4::WPS.wps_Shortcut("s")
F5::WPS.wps_Shortcut("r")
F6::WPS.wps_Shortcut("w")
F7::WPS.wps_Shortcut("z")
F8::WPS.wps_Shortcut("k")

;Bullets
!F7::WPS.wps_Bullets()


#HotIf WinActive("ahk_exe KMPlayer64.exe")

Delete::Player.plr_SkipOpening()

Up::Volume_Up
Down::Volume_Down


;Search in docs
#HotIf WinActive("ahk_group AutoHotkey_Help")
F1::Send "!s"

;Scroll to go between pics
#HotIf WinActive("ahk_group Media")
WheelUp::Send "{Left}"
WheelDown::Send "{Right}"


#HotIf WinActive("ahk_exe ScreenClippingHost.exe")

;Use the scroll wheel to choose among modes of the screenshot tool
WheelUp::Screenshot.scr_Options("left")
WheelDown::Screenshot.scr_Options("right")
MButton::Screenshot.scr_Fullscreen() 

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
#F8:: {
   windowTitle := WinGetTitle("A")
   if SubStr(windowTitle, 1, 3) == "C:\"
      A_Clipboard := FileSelect("S", windowTitle)
}

;Gets current cursor's position and opens a gui giving you the options for formatting the parameters for different commands to put them into your Clipboard or to not copy them into your Clipboard at all and just exit the gui
+!f::Run A_WorkingDir . "\Tools\MouseGetPos.ah2"

;Opens a msgbox showing the exact time
+!t:: {
   clock_time := FormatTime(, "H:mm")
   clock_weekDay := FormatTime(, "dddd")
   clock_date := FormatTime(, "d MMMM")
   MsgBox clock_time . "`n" . clock_weekDay . "`n" . clock_date, "Current time", "4096"
}




;APPS #################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;OBS
<!o::Win.niw_MinMax("ahk_exe obs64.exe") 

;Command prompt
#F9::Win.niw_App("ahk_exe cmd.exe", "cmd.exe")

;Python cmd
#F10::Win.niw_App("ahk_exe py.exe", "py.exe")

;Monkeytype
<!u::Win.niw_App_WinNum("Monkeytype", "4")

;Mail
<!SC033::Win.niw_App_WinNum("Gmail", "1")

;Calendar
<!SC034::Win.niw_App_WinNum("Google Calendar", "2")

;Calculator
<!SC035::Win.niw_App("Calculator", "calc.exe")

;Autohotkey help file
<!SC028::Win.niw_App("AutoHotkey Help", Win.AutoHotkeyDocs_v1)

;Autohotkey v2 help file
<!SC027::Win.niw_App("AutoHotkey v2 Help", Win.AutoHotkeyDocs_v2)

;Gimp 
<!SC01A::Win.niw_App("ahk_exe gimp-2.10.exe", Win.Gimp)

;Atom 
<!y::Win.niw_App("ahk_exe atom.exe", Win.Atom) 

;Video editor
<!SC01B::Win.niw_App("ahk_exe Resolve.exe", Win.DavinciResolve)

;MinMaxes a game if it exists, closes all apps but spotify if all main 6 apps exist, if they don't: launches those apps of the main 6, that do not yet exist
<!g:: {

   chrome := "Google Chrome"
   todoist := "ahk_exe Todoist.exe"
   telegram := "Telegram"
   vscode := "ahk_exe Code.exe"
   discord := "ahk_exe Discord.exe"
   steam := "ahk_exe steam.exe"

   ;Variable for ALL the main 6 apps existing
   mainAppsExist := (WinExist(chrome) && WinExist(todoist) && WinExist(telegram) && WinExist(vscode) && WinExist(discord))

   (WinExist("ahk_group Game") 
      ? Win.niw_MinMax("ahk_group Game") 
      : (mainAppsExist 
         ? WinClose("ahk_group Main") 
         : (Win.niw_ifClose(steam),
            Win.niw_ifRun(chrome, Win.GoogleChrome),
            Win.niw_ifRun(todoist, Win.Todoist),
            Win.niw_ifRun(telegram, Win.Telegram),
            Win.niw_ifRun(vscode, Win.VScode),
            Win.niw_ifRun(discord, Win.Discord),
            Win.niw_ifRun_WinNum("YouTube Music", "6"))))
}

#HotIf !WinActive("ahk_group Game")

; Telegram, whatsapp, viber on one, two and three presses
<!t:: {
   Switch Double.dbl_Bool("t") {
      Case True:
         Switch Double.dbl_Bool("t") {
            ; You pressed three times
            Case True:Win.niw_App("ahk_exe Viber.exe", Win.Viber) 
            ; You pressed twice
            Case False:Win.niw_App("ahk_exe WhatsApp.exe", Win.WhatsApp)
         }
      ; You pressed once
      Case False:Win.niw_App("Telegram", Win.Telegram)
   } 
}

;Projects folder on single press, FL Studio on double press
<!f:: {
   (Double.dbl_Bool("f")
      ? Win.niw_App("ahk_exe FL64.exe", Win.FL) 
      : Win.niw_App_Folders("C:\Files\Projects"))
}

;Photos or steam
<!r:: {
   (!Win.niw_ifMinMax("ahk_group Media")
      ? Win.niw_App("ahk_exe steam.exe", Win.Steam, "Steam - News")
      : "")
}

;Visual studio code
<!a::Win.niw_App("ahk_exe Code.exe", Win.VScode)

;Youtube music
<!s::Win.niw_App_WinNum("YouTube Music", "6")

;Chrome 
<!c::Win.niw_App("Google Chrome", Win.GoogleChrome)

;Todoist
<!x::Win.niw_App("ahk_exe Todoist.exe", Win.Todoist)

;Wps
<!w::Win.niw_App("ahk_exe wps.exe", Win.WPS)

;Discord
<!q::Win.niw_App("ahk_exe Discord.exe", Win.Discord)

;VPN
<!z:: {
   (!Win.niw_ifMinMax("SoundCloud")
      ? Win.niw_App("ahk_exe vpncmgr_x64.exe", Win.VPN) : "")
}

;Explorer
<!e::Win.niw_App_Folders("C:\")

;Documents 
<!d::Win.niw_App_Folders("C:\Files\Documents")

;Pictures
<!v::Win.niw_App_Folders("C:\Files\Pictures")

;One Piece
<!b::Win.niw_App_Folders("C:\Files\Pictures\One Piece")