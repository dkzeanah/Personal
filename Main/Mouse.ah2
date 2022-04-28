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
Volume_Down & XButton1::Hold.hld_Send("XButton1", Base.bsd_Copy, Base.bsd_Cut)
Volume_Down & MButton::Base.bsd_SelectAll()
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


#HotIf 