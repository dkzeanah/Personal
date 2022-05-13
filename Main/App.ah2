;CHROME ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("YouTube Music") ;_youtube music

F1::YTMusic.ytm_Search()
F2::YTMusic.ytm_Library()
F3::YTMusic.ytm_CancelSearch()
F4::YTMusic.ytm_Fullscreen()
F5::YTMusic.ytm_Liked()
F6::YTMusic.ytm_Best()
F7::YTMusic.ytm_Discovery()

F12::YTMusic.ytm_Like()
F11::YTMusic.ytm_Dislike()

Media_Stop & MButton::F5
^Space::Send "{Down}"


#HotIf YouTube.ytt_isNotWatchingVid
Escape::YouTube.ytt_MiniscreenClose()


#HotIf Youtube.ytt_isWatchingVid
>^Right::YouTube.ytt_Seek("right")
>^Left::YouTube.ytt_Seek("left")


#HotIf WinActive("YouTube") ;_youtube 
PgDn::YouTube.ytt_SkipNext()
PgUp::YouTube.ytt_SkipPrev()


#HotIf WinActive("WatchMoviesHD")
Up::Send "{Volume_Up}"
Down::Send "{Volume_Down}"


#HotIf WinActive("Google Chrome") ;_chrome

;Single press is copy, double press will get current tab's link to clipboard
Media_Stop & XButton1:: {
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

+!e::Base.bsd_NewTab()

#Delete::Base.bsd_CloseTab()

+!w::(!WinActive("Messenger") ? Base.bsd_CloseTab() : "")

Media_Stop & MButton::F5
^Space::Send "{Down}"

AppsKey & Delete:: {
   (Hold.hld_Bool("Delete")
      ? Chrome.chr_CloseAllTabs()
      : Base.bsd_CloseTab())
}

AppsKey & Insert::Base.bsd_RestoreTab()
AppsKey & PgUp::Base.bsd_PrevTab()
AppsKey & PgDn::Base.bsd_NextTab()
AppsKey & Home::Base.bsd_NewTab()
AppsKey & End::Chrome.chr_CopyLink()





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

XButton1 & MButton::Discord.dsc_DeleteMessage()
XButton2 & MButton::Discord.dsc_React()

^SC027::Discord.dsc_Emoji()

F1::Discord.dsc_PrevServer()
F2::Discord.dsc_NextServer()

^Space::Send "{Down}"
^+Space::Send "{Up}"




;TECH #################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("ahk_exe Code.exe") ;_vscode 

PrintScreen::VSC.vsc_RunCurrentInTerminal()
!PrintScreen::VSC.vsc_KillCurrentTerminalOrDebug()
^PrintScreen::VSC.vsc_Debug()

AppsKey & Delete:: {
   (Hold.hld_Bool("Delete")
      ? VSC.vsc_CloseAllTabs()
      : Base.bsd_CloseTab())
}

AppsKey & Insert::Base.bsd_RestoreTab()
AppsKey & PgUp::Base.bsd_PrevTab()
AppsKey & PgDn::Base.bsd_NextTab()
AppsKey & Home::VSC.vsc_DeleteLine()
AppsKey & End::VSC.vsc_Comment()

Media_Stop & MButton::VSC.vsc_Reload()

;Opens an inputbox for you to put in the name of the key to get its SC code into your clipboard, or takes the SC code to then show you to which key it belongs in a msgbox; if it finds neither, says so
+!k:: {
   (Hold.hld_Bool("k")
      ? VSC.vsc_KeyCodeGetter("to")
      : VSC.vsc_KeyCodeGetter("from"))
}


#HotIf WinActive(".pptx ahk_exe wps.exe")

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


#HotIf WinActive("ahk_group Document ahk_exe wps.exe")

F1::WPS.wps_Shortcut("h")
F2::WPS.wps_Shortcut("n")
F3::WPS.wps_Shortcut("p")
F4::WPS.wps_Shortcut("s")
F5::WPS.wps_Shortcut("r")
F6::WPS.wps_Shortcut("w")
F7::WPS.wps_Shortcut("z")
F8::WPS.wps_Shortcut("k")

!F7::WPS.wps_Bullets()


#HotIf WinActive("ahk_exe wps.exe") ;_wps

^+Space::WPS.wps_NextTab()
^Space::WPS.wps_PrevTab()

+!s::Base.bsd_Save()
+!w::Base.bsd_CloseTab()


#HotIf WinActive("ahk_exe KMPlayer64.exe")

Delete::Player.plr_SkipOpening()

Up::Volume_Up
Down::Volume_Down


;Scroll to go between pics
#HotIf WinActive("ahk_group Media")
WheelUp::Send "{Left}"
WheelDown::Send "{Right}"


#HotIf WinActive("ahk_group AutoHotkey_Help")
F1::Send "!s" ;Search in docs

^Space::Send "{Down}"
^+Space::Send "{Up}"

#HotIf WinActive("ahk_exe AutoHotkey64.exe")
^BackSpace::Base.bsd_DeleteAll()

#HotIf WinActive("Snip & Sketch")
XButton1 & LButton::Base.bsd_Save()

#HotIf WinActive("C:\ ahk_exe explorer.exe")
+!r::Explorer.exp_Rename()

;Use the scroll wheel to choose among modes of the screenshot tool
#HotIf WinActive("ahk_exe ScreenClippingHost.exe")
WheelUp::Screenshot.prt_Options()
WheelDown::Screenshot.prt_Options()
MButton::Screenshot.prt_Fullscreen() 
#HotIf
