#HotIf !WinActive("ahk_group Game")

;SIDE TO SPECIAL ######################################################################
;######################################################################################
;######################################################################################
;######################################################################################


XButton1 & Media_Stop:: {
   Switch {
      Case WinActive("YouTube Music"):      YTMusic.ytm_CancelSearch()
      Case YouTube.ytt_isNotWatchingVid:    YouTube.ytt_Miniscreen()
      Case YouTube.ytt_isWatchingVid
         , WinActive("WatchMoviesHD"):      YouTube.ytt_Fullscreen()
      Case WinActive("Messenger"):               VK.vkk_Notifications()
      Case WinActive("ahk_exe Discord.exe"):Discord.dsc_Emoji()
      Case WinActive("ahk_exe Code.exe"):      Base.bsd_ShiftClick()
   }
}

XButton2 & Media_Stop:: {
   Switch {
      Case WinActive("YouTube Music"):        YTMusic.ytm_ChannelSwitch()
      Case WinActive("YouTube"):              YouTube.ytt_ChannelSwitch()
      Case WinActive("Messenger"):                 VK.vkk_Voice()
      Case WinActive("ahk_exe Telegram.exe"):Telegram.tlg_Voice()
      Case WinActive("ahk_group Whatiber"):  Whatiber.wtb_Voice()
      Case WinActive("ahk_exe Discord.exe"):  Discord.dsc_Gif()
      Case WinActive("ahk_exe Code.exe"):        Base.bsd_Search()
   }
}




;KEYS #################################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Special button + side buttons
Media_Stop & XButton1::Hold.hld_Send("XButton1", Base.bsd_Copy, Base.bsd_Cut, "0.19")
Media_Stop & XButton2::Hold.hld_Send("XButton2", Base.bsd_Paste, Base.bsd_WinPaste, "0.17")

;Combined side buttons
XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

XButton1 & WheelUp::Base.bsd_Redo()
XButton1 & WheelDown::Base.bsd_Undo()

XButton2 & WheelUp:: {
   MouseGetPos(&sectionX, &sectionY)
   topLeft := ((sectionX < 252) && (sectionY < 229))
   ((topLeft)
      ? TransAndProud(40)
      : Send("{Volume_Up}"))
}

XButton2 & WheelDown:: {
   MouseGetPos(&sectionX, &sectionY)
   topLeft := ((sectionX < 252) && (sectionY < 229))
   ((topLeft)
      ? TransAndProud(-40)
      : Send("{Volume_Down}"))
}

;Close side button with L and R buttons 
XButton1 & LButton:: {
   ((Hold.hld_Bool("LButton", "0.19"))
      ? Base.bsd_SelectAll()
      : Send("{BackSpace}"))
}
XButton1 & RButton::Delete

;Far side button with L and R buttons
XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter

Media_Stop & RButton::Send "!{Pause}"



;SPECIAL #############################################################################
;#####################################################################################
;#####################################################################################
;##################################################################################### 


Media_Stop:: { 
   MouseGetPos &sectionX, &sectionY
     right       := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , topRight    := ((sectionX > 1707) && (sectionY < 233))
   , topLeft     := ((sectionX < 252) && (sectionY < 229))
   , bottomLeft  := ((sectionX < 263) && (sectionY > 849))
   , bottomRight := ((sectionX > 1673) && (sectionY > 839))
   Switch {
      Case right:
         ( (topRight)    ? Win.niw_MaximizeWin()
         : (bottomRight) ? Win.niw_App("Telegram", Win.Telegram)
         :                 Win.niw_App("ahk_exe Discord.exe", Win.Discord))
      Case left:
         ( (topLeft)     ? Win.niw_WinRestoreDown()
         : (bottomLeft)  ? Win.niw_App("ahk_exe Todoist.exe", Win.Todoist)
         :                 Win.niw_App("ahk_exe Code.exe", Win.VScode))
      Case down:           Win.niw_App_WinNum("YouTube Music", 5)
      Case up:             Win.niw_App("Google Chrome", Win.GoogleChrome)
      Default:             Base.bsd_AltTab()
   } 
}




;FAR SIDE #############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


XButton2:: { 
   MouseGetPos &sectionX, &sectionY
     right       := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , topRight    := ((sectionX > 1707) && (sectionY < 233))
   , topLeft     := ((sectionX < 252) && (sectionY < 229))
   , bottomLeft  := ((sectionX < 263) && (sectionY > 849))
   , bottomRight := ((sectionX > 1673) && (sectionY > 839))
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
      Case down:Win.niw_CloseWin()
      Case up:Win.niw_MinimizeWin()
      Default:
         Send(WinActive("ahk_exe Code.exe") 
            ? VSC.vsc_DeleteLine()
            : "{Browser_Forward}")
   }
}




;CLOSE SIDE ###########################################################################
;######################################################################################
;######################################################################################
;######################################################################################


XButton1:: { 
   MouseGetPos &sectionX, &sectionY
     right       := (sectionX > 1368)
   , left        := (sectionX < 568)
   , down        := (sectionY > 747)
   , up          := (sectionY < 347)
   , topRight    := ((sectionX > 1707) && (sectionY < 233))
   , topLeft     := ((sectionX < 252) && (sectionY < 229))
   , bottomLeft  := ((sectionX < 263) && (sectionY > 849))
   , bottomRight := ((sectionX > 1673) && (sectionY > 839))
   Switch {
      Case WinActive("Google Chrome"): ;_chrome
         Switch {
            Default:      Send "{Browser_Back}"
            Case right:
               ((topRight) 
                  ?       Base.bsd_RestoreTab()
                  :       Base.bsd_NextTab())
            Case left:    Base.bsd_PrevTab()
            Case up:      Base.bsd_NewTab()
            Case down:
               (WinActive("Messenger") 
                  ?       VK.vkk_Scroll() 
                  :       Base.bsd_CloseTab())
         }
      Case WinActive("ahk_exe Code.exe"): ;_vscode
         Switch {
            Default:           VSC.vsc_Comment()
            Case right:
               ( topRight    ? VSC.vsc_IndentRight()
               : bottomRight ? Script.scr_Reload()
               :               Base.bsd_NextTab())
            Case left:
               ( topLeft     ? VSC.vsc_IndentLeft()
               : bottomLeft  ? Script.scr_Test()
               :               Base.bsd_PrevTab())
            Case down:         Base.bsd_CloseTab()
            Case up:           Send "#{PgUp}"
         }
      Case WinActive("YouTube Music"): ;_youtube music
         ytmCover := ((sectionX > 1594) && (sectionY > 686))
         Switch {
            Default:        Send "{Browser_Back}"
            Case right:
               (ytmCover ?  YTMusic.ytm_Options()
               : topRight ? YTMusic.ytm_SmartRandomPlaylist()
               :            YTMusic.ytm_Fullscreen())
            Case left:      YTMusic.ytm_Library()
            Case up:        YTMusic.ytm_Like()
            Case down:      YTMusic.ytm_Dislike()
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