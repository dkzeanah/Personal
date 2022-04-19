SetWorkingDir A_ScriptDir . "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds
SetScrollLockState "AlwaysOff"
#HotIf ;At the start to autoresolve "this hotkey already exists" conflicts




;SCRIPT SELF ##########################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Reload this script
$ScrollLock::F_Reload()
$SC050::F_Reload()

;Hard reload this script
$!ScrollLock::F_HardReload()
$!SC050::F_HardReload()

;Suspend this script 
#SuspendExempt True
$+ScrollLock::F_Suspend()
$+SC050::F_Suspend()
#SuspendExempt False

;Run Testscript v2
$Pause::F_Test()
$SC051::F_Test()

;Run Testscript v1
$+Pause::F_Test("v1.ahk")
$+SC051::F_Test("v1.ahk")

;Reboot system
$#ScrollLock::F_Reboot()
$#SC050::F_Reboot()




;VARIABLES ############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Functions that send hotkeys that work pretty much everywhere (for readability)
#Include "%A_ScriptDir%\..\Libraries\1. Base shortcuts.ah2"

;A dictionary of key names and SC codes of them
#Include "%A_ScriptDir%\..\Libraries\2. Key codes.ah2"

;Functions for multiple presses
#Include "%A_ScriptDir%\..\Libraries\3. Multiple presses.ah2"

;An array of the 1000 most used english words
#Include "%A_ScriptDir%\..\Libraries\4. Random words.ah2"

;Functions for app window manipulation
#Include "%A_ScriptDir%\..\Libraries\5. WindowsApp.ah2"

;Other functions that work everywhere
#Include "%A_ScriptDir%\..\Libraries\6. Global functions.ah2"

;Functions that do something with the current script
#Include "%A_ScriptDir%\..\Libraries\Script interaction.ah2"

;Functions for clicking and opening stuff in different apps, for readability
#Include "%A_ScriptDir%\..\Libraries\App clicks and shortcuts.ah2"

;Often when you want something selected, you'll send down and enter, so this is the variable for that 
select := "{Down}{Enter}"

;Games
GroupAdd "Game",            "ahk_exe EtG.exe"
GroupAdd "Game",            "ahk_exe isaac-ng.exe"
GroupAdd "Game",            "ahk_exe nuclearthrone.exe"
GroupAdd "Game",            "ahk_exe METAL GEAR RISING REVENGEANCE.exe"

;Games that use base remapping
GroupAdd "Game_M",          "ahk_exe EtG.exe"
GroupAdd "Game_M",          "ahk_exe isaac-ng.exe"
GroupAdd "Game_M",          "ahk_exe nuclearthrone.exe"

;Main apps
GroupAdd "Main",            "ahk_exe chrome.exe"
GroupAdd "Main",            "ahk_exe Todoist.exe"
GroupAdd "Main",            "ahk_exe Telegram.exe"
GroupAdd "Main",            "ahk_exe Code.exe"
GroupAdd "Main",            "ahk_exe Discord.exe" 
GroupAdd "Main",            "AutoHotkey Help"
GroupAdd "Main",            "AutoHotkey v2 Help"

;Messengers
GroupAdd "Messenger",       "Google Chrome"
GroupAdd "Messenger",       "ahk_exe Telegram.exe"
GroupAdd "Messenger",       "ahk_exe Discord.exe"
GroupAdd "Messenger",       "ahk_exe WhatsApp.exe"
GroupAdd "Messenger",       "ahk_exe Viber.exe"

;Word documents
GroupAdd "Document",        ".doc"
GroupAdd "Document",        ".docx"

;Whatsapp and viber
GroupAdd "Whatiber",        "ahk_exe WhatsApp.exe"
GroupAdd "Whatiber",        "ahk_exe Viber.exe"

;Media
GroupAdd "Media",           "Photos"
GroupAdd "Media",           "ahk_exe KMPlayer64.exe"

;Autohotkey help
GroupAdd "AutoHotkey_Help", "AutoHotkey Help"
GroupAdd "AutoHotkey_Help", "AutoHotkey v2 Help"




;KBMAIN ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;SPECIAL CHARACTERS
;————————————————————

;Long dash
$!-::Send "{ASC 0151}"

;Hotstring that turns into a random english word every time
:B0*?:uclanr:: {
   Send "{BackSpace 6}"
   Ri_randomWords_Eng := Random(1, 3003)
   Send R_randomWords_Eng[Ri_randomWords_Eng]
}

;Hotstring that turns into a random russian word every time
:B0*?:ilandh:: {
   Send "{BackSpace 6}"
   Ri_randomWords_Rus := Random(1, 3000)
   Send R_randomWords_Rus[Ri_randomWords_Rus]
}

;If I try to laugh in russian but my language is set to english, it autosets the language to russian
:*?:[f[f::{LWin Down}{Space}{LWin Up} 
:*?:[[f[f::{LWin Down}{Space}{LWin Up} 


;GLOBAL MANIPULATION
;—————————————————————————————

;Close active window
$!Escape::PostMessage("0x0010",,,, "A")

;Alt enter in down enter
$!Enter::Send select

;Undo/redo
$+!Left::Base.Undo()
$+!Right::Base.Redo()

;Select all
$Insert::Base.SelectAll()
$SC047::Base.SelectAll()

;Easily accessible paste window
$#Insert::Base.WinPaste()

;Cut
$!Insert::Base.Cut()
$!SC047::Base.Cut()

;Media hotkeys
$!SC029::Media_Play_Pause
$>^Home::Volume_Up
$>^End::Volume_Down
$>^Insert::Volume_Mute
$>^Delete::Media_Play_Pause
$>^PgUp::Media_Prev
$>^Pgdn::Media_Next


#HotIf WinActive("ahk_group Messenger")

;Alt + number sends the Unicode for a specific emoji, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😭🧐😳🤨🤔—💀
$!1::F_Emoji("pleading")
$!2::F_Emoji("yum")
$!3::F_Emoji("exploding_head")
$!4::F_Emoji("smirk_cat")
$!5::F_Emoji("sunglasses")
$!6::F_Emoji("sob")
$!7::F_Emoji("face_with_monocle")
$!8::F_Emoji("flushed")
$!9::F_Emoji("face_with_raised_eyebrow")
$!0::F_Emoji("thinking")
$!=::F_Emoji("skull")

;Alt + F keys are emojis as well
;😩🤤💜👉👈
$!F5::F_Emoji("weary")
$!F6::F_Emoji("drooling")
$!F7::F_Emoji("purple_heart")
$!F8::F_Emoji("finger_right"), F_Emoji("finger_left")

#HotIf 

;Makes sure fn + function key doesn't do its native function. Commented if made into a hotkey
$Launch_Media::return ;F1
$Media_Play_Pause::return ;F2
$Media_Stop::return ;F3
$Media_Prev::return ;F4
$Media_Next::return ;F5
$Volume_Mute::return ;F6
$Volume_Up::return ;F7
; $Volume_Down::return ;F8
$Launch_App1::return ;F9
; $Launch_Mail::return ;F10
; $Launch_App2::return ;F11
$Browser_Home::return ;F12

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

;Numpad is special buttons
SC047::Insert
SC04B::Delete
SC048::Home
SC04C::End
SC049::PgUp
SC04D::PgDn
AppsKey::LCtrl

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game 
#HotIf WinActive("ahk_group Game_M")
$*XButton1::u
$*XButton2::y
$*Volume_Down::i

#HotIf WinActive("ahk_exe METAL GEAR RISING REVENGEANCE.exe")
$*XButton1::u
$*XButton2::LCtrl
$*Volume_Down::i
$*CapsLock::Enter
#HotIf




;SPECIAL HOTKEYS ######################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Gives you a place to essentially type a hotstring. Runs what you entered
$+!l:: {
   O_Runner := InputBox("What do you want to run?", "Runner")
   if O_Runner.Result = "Cancel" 
      return
   ;Time part of the ekursы link
   Switch A_MMMM {
      Case "April":ekursTime := 1648746000
      Case "May":ekursTime := 1651338000
      Case "June":ekursTime := 1654016400
      Case "July":ekursTime := 1656608400
      Case "August":ekursTime := 1659286800
      Case "September":ekursTime := 1661965200
      Case "October":ekursTime := 1664557200
      Case "November":ekursTime := 1667235600
      Case "December":ekursTime := 1669827600
   }
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
      Case "eku":F_RunLink("https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . ekursTime)
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
            Default:Run A_WorkingDir . "\Files\Time table\Monday.jpg", "Max"
            Case 2:Run A_WorkingDir . "\Files\Time table\Tuesday.jpg", "Max"
            Case 3:Run A_WorkingDir . "\Files\Time table\Wednesday.jpg", "Max"
            Case 4:Run A_WorkingDir . "\Files\Time table\Thursday.jpg", "Max"
            Case 5:Run A_WorkingDir . "\Files\Time table\Friday.jpg", "Max"
         }
      Case "today":
         Switch A_WDay {
            Default:Run A_WorkingDir . "\Files\Time table\Monday.jpg", "Max"
            Case 3:Run A_WorkingDir . "\Files\Time table\Tuesday.jpg", "Max"
            Case 4:Run A_WorkingDir . "\Files\Time table\Wednesday.jpg", "Max"
            Case 5:Run A_WorkingDir . "\Files\Time table\Thursday.jpg", "Max"
            Case 6:Run A_WorkingDir . "\Files\Time table\Friday.jpg", "Max"
         }
      Case "week":Run "https://edu.sfu-kras.ru/timetable?group=%D0%98%D0%9A21-08%D0%91+%28%D0%BF%D0%BE%D0%B4%D0%B3%D1%80%D1%83%D0%BF%D0%BF%D0%B0+2%29"
      Case "monday":Run A_WorkingDir . "\Files\Time table\Monday.jpg", "Max"
      Case "tuesday":Run A_WorkingDir . "\Files\Time table\Tuesday.jpg", "Max"
      Case "wednesday":Run A_WorkingDir . "\Files\Time table\Wednesday.jpg", "Max"
      Case "thursday":Run A_WorkingDir . "\Files\Time table\Thursday.jpg", "Max"
      Case "friday":Run A_WorkingDir . "\Files\Time table\Friday.jpg", "Max"


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
      Case "playlist moving":Run A_WorkingDir . "\Tools\Playlist moving.ah2"
      Case "format table to array":F_FormatTableToArray()
      Case "startup":F_StartupRun()
      Case "coin flip":F_CoinFlip()
      Case "dr":F_DollarToRub()
      Case "rd":F_RubToDollar()
      Case "ytm":F_YTMusic()
      Case "lib", "libload":F_LibLoad()


      ;GITHUB
      ;————————————————————
      
      Case "gitpage", "gitfile", "gitlink":F_GitPage("paste")
      Case "git":F_GitPage("run")
      Case "github":F_RunLink("https://github.com/Axlefublr")


      ;SEND
      ;————————————

      ;Micha github nickname
      Case "git Micha":F_ClipSend("@Micha-ohne-el")

      ;My source is that I made it the fuck up
      Case "I made it the fuck up", "I made it up":F_ClipSend("https://www.youtube.com/watch?v=r7l0Rq9E8MY")
      ;Funny mic
      Case "funny mic":F_ClipSend("https://www.youtube.com/watch?v=jfbKJy_ZuIU")
      ;Delay lama vs meowsynth
      Case "delay lama":F_ClipSend("https://www.youtube.com/watch?v=Np4iG7-se7I")
      ;I quickly became homophobic
      Case "I quickly became homophobic":F_ClipSend("https://www.youtube.com/watch?v=m2ksGuqf8eo")
      ;If you design a quest
      Case "If you design a quest":F_ClipSend("https://www.youtube.com/watch?v=chn0ggv9TdY")
   }
   #Include "%A_ScriptDir%\..\Libraries\Runner functions.ah2"
}

;Easy way to reactivate the previous window after using the quick add task of todoist
+!x:: {
   prevActWin := WinGetID("A")
   Send "^+!x"
   (WinWait("ahk_exe Todoist.exe",, 7) 
      ? SetTimer(F_ReactivatePrevActWin, 100) : "")
   
   ;Waits for the quick add task window to disappear and as soon as it does, reactivates the window it was called from
   F_ReactivatePrevActWin() => (
      !WinActive("ahk_exe Todoist.exe")
         ? (WinActivate("ahk_id " . prevActWin),
            SetTimer(F_ReactivatePrevActWin, 0)) : ""
   ) 
}




;APP DIFFERENT KEYS ###################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf !WinActive("ahk_group Game")

XButton1 & Volume_Down:: {
   Switch {
      ;Leave search
      Case WinActive("YouTube Music"):YTM.CancelSearch()
      ;Maximize pop out window
      Case YT.isNotWatchingVid():Send "i"
      ;Fullscreen
      Case YT.isWatchingVid(), WinActive("WatchMoviesHD"):Send "f"
      ;Notifications
      Case WinActive("Messenger"):ControlClick "X788 Y126"
      ;Emoji tab
      Case WinActive("ahk_exe Discord.exe"):Send "^e"
      ;Shift click, but entirely on the mouse
      Case WinActive("ahk_exe Code.exe"):Send "+{Click}"
   }
}

XButton2 & Volume_Down:: {
   Switch {
      ;Switch channels in youtube music
      Case WinActive("YouTube Music"):YTM.ChannelSwitch()
      ;Switch channels in youtube
      Case WinActive("YouTube"):YT.ChannelSwitch()
      ;Clicks the send button to either start recording or send a voice message
      Case WinActive("Messenger"):ControlClick "X1757 Y1014"
      ;Clicks the send button to send a voice message
      Case WinActive("ahk_exe Telegram.exe"):F_ClickThenGoBack_Event("1452 1052")
      ;Clicks the send button to send a voice message
      Case WinActive("ahk_group Whatiber"):ControlClick "X1873 Y1047"
      ;Gif tab
      Case WinActive("ahk_exe Discord.exe"):Send "^g"
      ;Search
      Case WinActive("ahk_exe Code.exe"):Send "^f"
   }
}

$^m:: {
   Switch {
      Default:Send "^m"
      Case WinActive("ahk_exe Discord.exe"):
         ;Markdown
         MsgBox "__ underline __`n* italic *`n** bold **`n~~ strikethrough ~~`n|| spoiler ||`n`````` code ```````n`` code inline ```n_ nothing _", "Markdown", "4096"
      Case WinActive("Google Chrome"):
         if WinActive("Messenger")
            ;Blank message
            Send "&{#}12288;"
         else
            ;Markdown
            MsgBox("* italic *`n** bold **`n~~ strikethrough ~~`n>! spoiler !<`n[embed](link)`n^(superscript)`n`` code inline ```n # BIG TEXT", "MarkDown", "4096")
   }
}

;Converts a YT Music link into a YT link while these windows are active, otherwise just sends itself
$+!r:: {
   ((WinActive("ahk_exe Discord.exe")
   || WinActive("ahk_exe Telegram.exe")
   || (WinActive("ahk_exe chrome.exe") && !WinActive("YouTube")))
      ? F_YTMusic()
      : Send("+!r"))
}




;MOUSE KEY INTERACTION ################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Special button + side buttons
#HotIf !WinActive("ahk_group Game") && !WinActive("Google Chrome")
Volume_Down & XButton1::F_ifKeyHeld_Send("XButton1", Base.Copy, Base.Cut)
#HotIf !WinActive("ahk_group Game") && !WinActive("ahk_exe chrome.exe")
Volume_Down & MButton::Send "^a"
#HotIf !WinActive("ahk_group Game")
Volume_Down & LButton::Space
Volume_Down & XButton2::F_ifKeyHeld_Send("XButton2", Base.Paste, Base.WinPaste)

;Special button by itself pressed in different sections of the screen does different things
$Volume_Down:: { 
   MouseGetPos &sectionX, &sectionY
   right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347), discard := ((sectionX > 1707) && (sectionY < 233))
   Switch {
      Case discard:return
      Case right:Send "#{Right}"
      Case left:Send "#{Left}"
      Case down:Send "#{Down}"
      Case up:Send "#{Up}"
      Default: 
         Send "{AltDown}{Tab}" 
         KeyWait "LButton", "D"
         Sleep 150
         Send "{AltUp}"
         if WinActive("ahk_exe wps.exe")
            Send "{Esc}"
   } 
}

;Combined side buttons
XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

;Far side button and Wheel
XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down

;Close side button and Wheel
XButton1 & WheelUp::Send "^y"
XButton1 & WheelDown::Send "^z"

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
$XButton2:: { 
   MouseGetPos &sectionX, &sectionY
   right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347), topRight := ((sectionX > 1707) && (sectionY < 233)), topLeft := ((sectionX < 252) && (sectionY < 229)) ;Here I define the sections
   Switch {
      Case right:
         Switch {
            Case topRight:Send "!{Tab}"
            Case WinActive("YouTube Music"), YT.isWatchingVid():YT.SkipNext()
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgDn}"
            Default:Send "{Media_Next}"
         }
      Case left:
         Switch {
            Case topLeft:Send "+!{Tab}"
            Case WinActive("YouTube Music"), YT.isWatchingVid():YT.SkipPrev()
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgUp}"
            Default:Send "{Media_Prev}"
         }
      Case down:Base.CloseWin()
      Case up:Base.MinimizeWin()()
      Default:
         Send(WinActive("ahk_exe Code.exe") 
            ? "^!{Insert}" 
            : "{Browser_Forward}")
   }
}

;Close side button, does different things depending on what section of the screen it was pressed on. Right, left, down, up or middle
$XButton1:: { 
   MouseGetPos &sectionX, &sectionY
   right := (sectionX > 1368), left := (sectionX < 568), down := (sectionY > 747), up := (sectionY < 347), topRight := ((sectionX > 1707) && (sectionY < 233)), topLeft := ((sectionX < 252) && (sectionY < 229)), bottomLeft := ((sectionX < 263) && (sectionY > 849)), bottomRight := ((sectionX > 1673) && (sectionY > 839))
   Switch {
      Case WinActive("Google Chrome"): ;_chrome
         Switch {
            Default:Send "{Browser_Back}"
            Case right:Send "^{PgDn}"
            Case left:Send "^{PgUp}"
            Case up:Send "^t"
            Case down:(WinActive("Messenger") ? ControlClick("X1750 Y903") : Send("^w"))
         }
      Case WinActive("ahk_exe Code.exe"): ;_vscode
         Switch {
            Default:Send "^/"
            Case right:Send "^!{Right}"
            Case left:Send "^!{Left}"
            Case down:F_Test()
            Case up:F_Reload()
         }
      Case WinActive("YouTube Music"): ;_youtube music
         ytmCover := ((sectionX > 1594) && (sectionY > 686))
         Switch {
            Default:          Send "{Browser_Back}"
            Case right:
               ( topRight   ? YTM.Discovery()
               : ytmCover   ? YTM.Options()
               :              YTM.Fullscreen())
            Case left:
               ( topLeft    ? YTM.Best()
               : bottomLeft ? YTM.Liked()
               :              YTM.Library())
            Case up:          YTM.Like()
            Case down:        YTM.Dislike()
         }
      Case WinActive("ahk_exe wps.exe"): 
         Switch {
            Default:Send "{Browser_Back}"
            Case right:Send "^{Tab}"
            Case left:Send "^+{Tab}"
            Case down:Send "{PgDn}"
            Case up:Send "^s"
         }
      Case WinActive("ahk_exe Todoist.exe"): ;_todoist
         Switch {
            Default:Send "{Browser_Back}"
            Case right:F_TodoistSearch("unfinished")
            Case left:F_TodoistSearch("rappers")
            Case down:F_TodoistSearch("payments")
            Case up:F_TodoistSearch("inbox")
         }
      Case WinActive("ahk_exe Discord.exe") && down:Send "{Esc}" ;_discord
      Case WinActive("ahk_exe Telegram.exe") && down:ControlClick "X1434 Y964" ;_telegram
      Case WinActive("ahk_group Whatiber") && down:ControlClick "X1878 Y961"
      Default:Send "{Browser_Back}"
   } 
}




;CHROME AND YOUTUBE ###################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Reload page
#HotIf WinActive("ahk_exe chrome.exe")
Volume_Down & MButton::F5

#HotIf WinActive("Google Chrome") ;_chrome

;Single press is copy, double press will get current tab's link to clipboard
Volume_Down & XButton1::(F_isKeyHeld("XButton1") ? (Send("^l"), Sleep(40), Send("^c")) : Send("^c"))

;Ctrl numbers aren't easy to press, so F keys instead
$F1::Send "^1"
$F2::Send "^2"
$F3::Send "^3"
$F4::Send "^4"
$F5::Send "^5"
$F6::Send "^6"
$F7::Send "^7"
$F8::Send "^8"

;Volume
$F10::Send "{Volume_Up}"
$F9::Send "{Volume_Down}"

;Opens a new tab
$+!e::Base.NewTab()

;Closes a tab
$#Delete::Base.CloseTab()

;Shift alt w closes a tab
$+!w::(!WinActive("Messenger") ? Base.CloseTab() : "")


;Shift n to skip never made sense to begin with
#HotIf WinActive("YouTube") ;_youtube 
$PgDn::YT.SkipNext()
$PgUp::YT.SkipPrev()


#HotIf WinActive("YouTube Music")

$F1::YTM.Search()
$F2::YTM.Library()
$F3::YTM.CancelSearch()
$F4::YTM.Fullscreen()
$F5::YTM.Liked()
$F6::YTM.Best()
$F7::YTM.Discovery()

;Volume
$F10::Send "{Volume_Up}"
$F9::Send "{Volume_Down}"

;Like and dislike
$F12::YTM.Like()
$F11::YTM.Dislike()


;Close minimized window 
#HotIf WinActive("Watch later") || WinActive("Subscriptions") || (WinActive("YouTube") && !WinActive(" - YouTube"))
Escape::ControlClick "X1858 Y665"

;Seek farther
#HotIf WinActive(" - YouTube") && !WinActive("Watch later") && !WinActive("Subscriptions")
$!Right::Send "l"
$!Left::Send "j"

;Change volume
#HotIf WinActive("WatchMoviesHD")
$Up::Send "{Volume_Up}"
$Down::Send "{Volume_Down}"




;OTHER ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("ahk_exe Telegram.exe") ;_telegram

;Clicks the search bar for you to search for channels, finds and goes to the channel you want
F_TelegramSearch(channelToFind) {
   ControlClick("X422 Y78"), Send(channelToFind . "{Down}{Enter}")
} 

;Press an F key -> go to a channel
$F1::F_TelegramSearch("diary")
$F2::F_TelegramSearch("texts")
$F3::F_TelegramSearch("transfer")
$F4::F_TelegramSearch("documents")
$F5::F_TelegramSearch("gallery")
$F6::F_TelegramSearch("мама")
$F7::F_TelegramSearch("кристина")
$F8::F_TelegramSearch("алена")
$F9::F_TelegramSearch("invie")

;Spoiler
$^p::Send "^+p" 

;Strikethrough
$^n::Send "^+x"


#HotIf WinActive("ahk_exe Todoist.exe") ;_todoist

;Goes to the project or label or filter or your mom
F_TodoistSearch(projectToFind) {
   Send "f" . projectToFind . "{Down}{Enter}"
}

;Hotkeys to jump to different projects
$F1::F_TodoistSearch("inbox") 
$F2::F_TodoistSearch("rappers") 
$F3::F_TodoistSearch("unfinished")
$F4::F_TodoistSearch("payments")
$F5::F_TodoistSearch("desires")
$F6::F_TodoistSearch("shopping") 

;Gives the current task an unfinished label and lets you edit its description
$+!e::Send " {#}unfinished — " 

;Enter is always down enter
$Enter::Send select




;TECH #################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("ahk_exe Code.exe") ;_vscode 

F_WorkspaceCorrectPath(vscodeHotkey) => (
   ;Open explorer window
   Send(vscodeHotkey), WinWait("ahk_exe explorer.exe"),
   ;Paste the correct path to where workspaces are
   workSpacesFolder := "C:\Files\Programming\Personal\Backups\Workspaces",
   Send("^l"), SendText(workSpacesFolder), Send("{Enter}")
)

;Copies the most important setting files of vs code into the /Backups folder
$^u::Run A_WorkingDir . "\Scripts\Pull vs code settings.py"

;Choose a workspace to open
$^!SC02B::F_WorkspaceCorrectPath("^!\")

;Save a workspace
$^+SC02B::F_WorkspaceCorrectPath("^+\")

;Choose a folder to open, now always starts in the folder where project folders are likely to be
$+!SC02B:: {
   ;Open project chooser
   Send("+!\"), WinWait("ahk_exe explorer.exe")
   ;Start in the folder that contains the project folders
   projectsFolder := "C:\Files\Programming"
   Send("^l"), SendText(projectsFolder), Send("{Enter}")
}

;Opens an inputbox for you to put in the name of the key to get its SC code into your clipboard, or takes the SC code to then show you to which key it belongs in a msgbox; if it finds neither, says so
$+!k:: {
   inBoxTitle := "Key codes"
   prevClip := A_Clipboard
   Send "^c"
   Sleep 40
   Try {
      MsgBox D_KeyCodes_Out[A_Clipboard], inBoxTitle
      A_Clipboard := prevClip
   }
   Catch {
      Try {
         keyPointer := InputBox("Key pointer:", inBoxTitle)
         if keyPointer.Result != "Cancel"
            A_Clipboard := D_KeyCodes_In[keyPointer.Value]
      }
      Catch
         MsgBox "Key not found!", inBoxTitle, "T1"
   }
}


#HotIf WinActive("ahk_exe wps.exe") ;_wps

;Switch between open documents
$^+Space::Send "^{Tab}"
$^Space::Send "^+{Tab}"

;Save 
$+!s::Send "^s"
;Close tab
$+!w::Send "^w"


#HotIf WinActive("ahk_exe wps.exe") && WinActive(".pptx")

;Uses an alt shortcut without the letters popping up
F_WpsShortcut(letter) {
   Send("{LAlt Down}{LAlt Up}" . letter . "{LAlt Down}{LAlt Up}")
}

;Menu tabs
$F1::F_WpsShortcut("h")
$F2::F_WpsShortcut("n")
$F3::F_WpsShortcut("g")
$F4::F_WpsShortcut("t")
$F5::F_WpsShortcut("a")
$F6::F_WpsShortcut("s")
$F7::F_WpsShortcut("r")
$F8::F_WpsShortcut("w")
$F9::F_WpsShortcut("k")
$F10::F_WpsShortcut("jd")
$F11::F_WpsShortcut("je")


#HotIf WinActive("ahk_exe wps.exe") && WinActive("ahk_group Document")

;Menu tabs
$F1::F_WpsShortcut("h")
$F2::F_WpsShortcut("n")
$F3::F_WpsShortcut("p")
$F4::F_WpsShortcut("s")
$F5::F_WpsShortcut("r")
$F6::F_WpsShortcut("w")
$F7::F_WpsShortcut("z")
$F8::F_WpsShortcut("k")

;Bullets
$!F7::ControlClick "X568 Y98"


#HotIf WinActive("ahk_exe KMPlayer64.exe")

;Skip opening
$Delete::Send "{Delete 6}{Right 4}"

;Volume
$Up::Volume_Up
$Down::Volume_Down


;Search in docs
#HotIf WinActive("ahk_group AutoHotkey_Help")
$F1::Send "!s"

;Scroll to go between pics
#HotIf WinActive("ahk_group Media")
$WheelUp::Send "{Left}"
$WheelDown::Send "{Right}"


#HotIf WinActive("ahk_exe ScreenClippingHost.exe")

;In the screenshot tool there are three options that can be selected. Selects those options in a rotary manner, depending on direction
F_ScreenshotOptions(direction) {
   MouseGetPos &initX, &initY
   static optionYoureOn := 1
   if (direction == "left")
      Switch optionYoureOn
      {
         Case 1:
            Click "959 27"
            optionYoureOn := 3
         Case 2:
            Click "839 28"
            optionYoureOn--
         Case 3:
            Click "897 31"
            optionYoureOn--
      }
   else 
      Switch optionYoureOn
      {
         Case 1:
            Click "897 31"
            optionYoureOn++
         Case 2:
            Click "959 27"
            optionYoureOn++
         Case 3:
            Click "839 28"
            optionYoureOn := 1
      }
   MouseMove initX, initY   
}

;Use the scroll wheel to choose among modes of the screenshot tool
$WheelUp::F_ScreenshotOptions("left")
$WheelDown::F_ScreenshotOptions("right")
$MButton::F_ClickThenGoBack("1017 29") ;Takes a full-screen screenshot
#HotIf




;TOOLS ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Opens an inputbox for you to input how many minutes to wait, plays a sound and opens a msgbox saying the time has passed after it has. Press the same hotkey while the timer is running to see when it will ring and three options: start a new timer, discarding the current one, continue on, exit the timer
$#F5::Run A_WorkingDir . "\Tools\Basic timer.ah2"

;Get the root to the exe of the active window and put it into your clipboard
$#F6::A_Clipboard := WinGetProcessPath("A")

;Get the name of the active window and put it into your clipboard
$#F7::A_Clipboard := WinGetTitle("A")

;Opens a fileselect in the current folder for you to choose a file to get the path of into your clipboard
$#F8:: {
   windowTitle := WinGetTitle("A")
   if SubStr(windowTitle, 1, 3) == "C:\"
      A_Clipboard := FileSelect("S", windowTitle)
}

;Gets current cursor's position and opens a gui giving you the options for formatting the parameters for different commands to put them into your Clipboard or to not copy them into your Clipboard at all and just exit the gui
$+!f::Run A_WorkingDir . "\Tools\MouseGetPos.ah2"

;Opens a msgbox showing the exact time
$+!t:: {
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
$<!o::F_MinMax("ahk_exe obs64.exe") 

;Command prompt
$#F9::F_WindowsApp("ahk_exe cmd.exe", "cmd.exe")

;Python cmd
$#F10::F_WindowsApp("ahk_exe py.exe", "py.exe")

;Monkeytype
$<!u::F_WindowsApp_WinNum("Monkeytype", "4")

;Mail
$<!SC033::F_WindowsApp_WinNum("Gmail", "1")

;Calendar
$<!SC034::F_WindowsApp_WinNum("Google Calendar", "2")

;Calculator
$<!SC035::F_WindowsApp("Calculator", "calc.exe")

;Autohotkey help file
$<!SC028::F_WindowsApp("AutoHotkey Help", "C:\Program Files\Autohotkey\AutoHotkey.chm")

;Autohotkey v2 help file
$<!SC027::F_WindowsApp("AutoHotkey v2 Help", "C:\Program Files\Autohotkey\v2\AutoHotkey.chm")

;Gimp 
$<!SC01A::F_WindowsApp("ahk_exe gimp-2.10.exe", "C:\Programs\GIMP 2\bin\gimp-2.10.exe")

;Atom 
$<!y::F_WindowsApp("ahk_exe atom.exe", "C:\Users\serge\AppData\Local\atom\app-1.58.0\atom.exe") 

;Video editor
$<!SC01B::F_WindowsApp("ahk_exe Resolve.exe", "C:\Programs\Davinci Resolve\Resolve.exe")

;MinMaxes a game if it exists, closes all apps but spotify if all main 6 apps exist, if they don't: launches those apps of the main 6, that do not yet exist
$<!g:: {
   ;Google Chrome
   chrome := "Google Chrome"
   chrome_exe := "C:\Program Files\Google\Chrome\Application\chrome.exe" 
   ;Todoist
   todoist := "ahk_exe Todoist.exe"
   todoist_exe := "C:\Users\serge\AppData\Local\Programs\todoist\Todoist.exe"
   ;Telegram
   telegram := "Telegram"
   telegram_exe := "C:\Programs\Telegram Desktop\Telegram.exe"
   ;Visual Studio Code
   vscode := "ahk_exe Code.exe"
   vscode_exe := "C:\Programs\Microsoft VS Code\Code.exe"
   ;Discord
   discord := "ahk_exe Discord.exe"
   discord_exe := "C:\Users\serge\AppData\Local\Discord\app-1.0.9004\Discord.exe"
   ;Steam
   steam := "ahk_exe steam.exe"

   ;Variable for ALL the main 6 apps existing
   mainAppsExist := (WinExist(chrome) && WinExist(todoist) && WinExist(telegram) && WinExist(vscode) && WinExist(discord))

   (WinExist("ahk_group Game") 
      ? F_MinMax("ahk_group Game") 
      : (mainAppsExist 
         ? WinClose("ahk_group Main") 
         : (F_ifWinClose(steam), F_ifRunApp(chrome, chrome_exe), F_ifRunApp(todoist, todoist_exe), F_ifRunApp(telegram, telegram_exe), F_ifRunApp(vscode, vscode_exe), F_ifRunApp(discord, discord_exe), F_ifRunApp_WinNum("YouTube Music", "6"))))
}

#HotIf !WinActive("ahk_group Game")

; Telegram, whatsapp, viber on one, two and three presses
$<!t:: {
   Switch F_isDoublePressed("t") {
      Case True:
         Switch F_isDoublePressed("t") {
            ; You pressed three times
            Case True:F_WindowsApp("ahk_exe Viber.exe", "C:\Users\serge\AppData\Local\Viber\Viber.exe") 
            ; You pressed twice
            Case False:F_WindowsApp("ahk_exe WhatsApp.exe", "C:\Users\serge\AppData\Local\WhatsApp\app-2.2140.12\WhatsApp.exe")
         }
      ; You pressed once
      Case False:F_WindowsApp("Telegram", "C:\Programs\Telegram Desktop\Telegram.exe")
   } 
}

;Projects folder on single press, FL Studio on double press
$<!f:: {
   (F_isDoublePressed("f")
      ? F_WindowsApp("ahk_exe FL64.exe", "C:\Programs\FL Studio 20\FL64.exe") 
      : F_WindowsApp_Folders("C:\Files\Projects"))
}

;Photos
$<!r:: {
   (!F_ifMinMax("ahk_group Media")
      ? F_WindowsApp("ahk_exe steam.exe", "C:\Programs\Steam\steam.exe", "Steam - News")
      : "")
}

;Visual studio code
$<!a::F_WindowsApp("ahk_exe Code.exe", "C:\Programs\Microsoft VS Code\Code.exe")

;Youtube music
$<!s::F_WindowsApp_WinNum("YouTube Music", "6")

;Chrome 
$<!c::F_WindowsApp("Google Chrome", "C:\Program Files\Google\Chrome\Application\chrome.exe")

;Todoist
$<!x::F_WindowsApp("ahk_exe Todoist.exe", "C:\Users\serge\AppData\Local\Programs\todoist\Todoist.exe")

;Wps
$<!w::F_WindowsApp("ahk_exe wps.exe", "C:\Users\serge\AppData\Local\Kingsoft\WPS Office\ksolaunch.exe")

;Discord
$<!q::F_WindowsApp("ahk_exe Discord.exe", "C:\Users\serge\AppData\Local\Discord\app-1.0.9004\Discord.exe")

;VPN
$<!z::F_WindowsApp("ahk_exe vpncmgr_x64.exe", "C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe")

;Explorer
$<!e::F_WindowsApp_Folders("C:\")

;Documents 
$<!d::F_WindowsApp_Folders("C:\Files\Documents")

;Pictures
$<!v::F_WindowsApp_Folders("C:\Files\Pictures")

;One Piece
$<!b::F_WindowsApp_Folders("C:\Files\Pictures\One Piece")