;CHROME ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


Class C_Chrome {
   
   chr_CopyLink() {
      Send("^l"), Sleep(40), Base.bsd_Copy()
   }

   chr_CloseAllTabs() {
      Send "^+{Delete}"
   }
}
Chrome := C_Chrome()


Class C_YouTubeMusic {
   
   ytm_Library() {
      ControlClick("X1013 Y73")
   }

   ytm_Liked() {
      ControlClick("X447 Y913")
   }

   ytm_Discovery() {
      ControlClick("X697 Y940")
   }

   ytm_Best() {
      ControlClick("X950 Y920")
   }

   ytm_Fullscreen() {
      ControlClick("X1863 Y1030")
   }

   ytm_Options() {
      ControlClick("X1542 Y1025",,, "R")
   }

   ytm_Like() {
      Send("^i")
   }

   ytm_Dislike() {
      Send("^u")
   }

   ytm_Search() {
      ControlClick("X1191 Y77")
   }

   ytm_CancelSearch() {
      ControlClick("X398 Y78")
   }

   ytm_ChannelSwitch() {
      ControlClick("X1863 Y75"), WaitClick("switch account ytm")
   }

   ;Converts a YT music link into a youtube link and pastes it
   ytm_LinkConverter() {
      ClipSend(A_Clipboard := StrReplace(StrReplace(A_Clipboard, "&feature=share", ""), "//music.", "//www."))
   }

   ytm_SmartRandomPlaylist() {

      file := FileOpen(A_WorkingDir . "\Files\Innit\Last playlists.txt", "r")
      , file.Seek(, 0) ;Go to the start of the file
      , prevNums := file.Read() ;Read the whole file to get all the string of numbers there
      , fileParam := (StrLen(prevNums) >= 10 ? "w" : "a") ;If there are 10 of them, decide to overwrite them on the next new number
      , file.Close() ;Flush

      , file := FileOpen(A_WorkingDir . "\Files\Innit\Last playlists.txt", fileParam) ;Reopen the same file having decided to either overwrite it or append to it
      Loop
         newNum := Random(0, 9)
      Until !InStr(prevNums, newNum) ;Get a number that won't be a dublicate to any currently in the file
      file.Write(newNum) ;Write that new number
      , file.Close() ;Flush

      , G_Plst := Gui("AlwaysOnTop", "Playlist chooser") ;Create a gui
      , G_Plst.Show("X10 Y10 W200 H200") ;Small square in the center
      , G_Plst.SetFont("S70")
      , G_Plst_Num := G_Plst.Add("Text", "X0 Y40 W200 H200 Center", newNum) ;Show the new number in the gui
      , SetTimer((*) => (G_Plst.Destroy(), WinActivate("YouTube Music ahk_exe chrome.exe")), -1000) ;Destroy the gui in a second
   }

}
YTMusic := C_YouTubeMusic.Call()


Class C_YouTube {

   ytt_SkipNext() {
      Send "+n"
   }

   ytt_SkipPrev() {
      Send "+p"
   }

   ytt_Seek(direction) {
      Send(
           direction == "right"
            ? "l"
         : direction == "left"
            ? "j"
         : ""
      )
   }

   ytt_Fullscreen() {
      Base.bsd_LanguageEng(), Send("f")
   }

   ytt_Miniscreen() {
      Base.bsd_LanguageEng(), Send("i")
   }

   ytt_MiniscreenClose() {
      ControlClick "X1858 Y665"
   }

   ytt_isWatchingVid => (WinActive(" - YouTube ahk_exe chrome.exe") && !WinActive("Watch later ahk_exe chrome.exe") && !WinActive("Subscriptions ahk_exe chrome.exe"))

   ytt_isNotWatchingVid => (
      WinActive("Watch later ahk_exe chrome.exe")
      ||  WinActive("Subscriptions ahk_exe chrome.exe")
      || (WinActive("YouTube ahk_exe chrome.exe")
      && !WinActive(" - YouTube"))
   )

   ytt_ChannelSwitch() {
      ControlClick("X1823 Y133")
      , WaitUntilImage("switch account ytt")
      , ControlClick("X1519 Y460")
   }

}
YouTube := C_YouTube.Call()




;MESSENGERS ###########################################################################
;######################################################################################
;######################################################################################
;######################################################################################


Class C_VK {

   vkk_Notifications() {
      ControlClick "X788 Y126"
   }

   vkk_Voice() {
      ControlClick "X1757 Y1014"
   }

   vkk_Scroll() {
      ControlClick "X1750 Y903"
   }
}
VK := C_VK()


Class C_Telegram {
   
   tlg_Voice() {
      ClickThenGoBack_Event("1452 1052")
   }

   tlg_Scroll() {
      ControlClick "X1434 Y964"
   }

   tlg_Channel(channelToFind) {
      ControlClick("X422 Y78"), Send(channelToFind . "{Down}{Enter}")
   }
}
Telegram := C_Telegram()


Class C_Whatiber {
   
   wtb_Voice() {
      ControlClick "X1873 Y1047"
   }

   wtb_Scroll() {
      ControlClick "X1878 Y961"
   }
}
Whatiber := C_Whatiber()


Class C_Discord {
   
   dsc_Emoji() {
      Send "^e"
   }

   dsc_Gif() {
      Send "^g"
   }

   dsc_Reply() {
      Base.bsd_CtrlClick()
   }

   dsc_React() {
      ImageSearch(&reactX, &reactY, 1730, 88, 1820, 995, A_WorkingDir "\Files\Images\react.png")
      try ControlClick("X" reactX " Y" reactY, "ahk_exe Discord.exe")
   }

   dsc_NextServer() {
      Send "^!{Down}"
   }

   dsc_PrevServer() {
      Send "^!{Up}"
   }

   dsc_DeleteMessage() {
      Send "{Delete Down}{Click}{Delete Up}"
   }
}
Discord := C_Discord()




;OTHER ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


Class C_Todoist {
   
   tds_Project(projectToFind) {
      Send "f" . projectToFind . "{Down}{Enter}"
   }

   tds_toUnfinished() {
      Send " {#}unfinished — " 
   }
}
Todoist := C_Todoist()




;TECH #################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


Class C_VSCode {

   vsc_IndentRight() {
      Send "^!{Right}"
   }

   vsc_IndentLeft() {
      Send "^!{Left}"
   }

   vsc_Comment() {
      Send "^/"
   }

   vsc_RunCurrentInTerminal() {
      Send "+!h"
   }

   vsc_KillCurrentTerminalOrDebug() {
      Send "^!h"
   }

   vsc_Debug() {
      Send "^+h"
   }

   vsc_CloseAllTabs() {
      Send "+{Escape}"
   }

   vsc_DeleteLine() {
      Send "+{Delete}"
   }
   
   vsc_KeyCodeGetter(direction) {
      inputBoxTitle := "Key codes"
      vsc_KeyNotFound() => MsgBox("Key not found!", inputBoxTitle, "T1")

      ((direction == "to")
         ? vsc_ToSC()
      : direction == "from"
         ? vsc_FromSC() : "")

      vsc_ToSC() {
         Try {
            keyPointer := InputBox("Key pointer:", inputBoxTitle)
            if keyPointer.Result != "Cancel"
               A_Clipboard := D_KeyCodes_In[keyPointer.Value]
         }
         Catch
            vsc_KeyNotFound()
      }
      
      vsc_FromSC() {
         Try {
            prevClip := A_Clipboard
            , Base.bsd_Copy()
            , Sleep(40)
            , MsgBox(D_KeyCodes_Out[A_Clipboard], inputBoxTitle)
            , A_Clipboard := prevClip
         }
         Catch 
            vsc_KeyNotFound()
      }
   }

   vsc_Reload() {
      Send "+!y"
   }

}
VSC := C_VSCode()


Class C_WPSOffice {
   
   wps_NextTab() {
      Send "^{Tab}"
   }

   wps_PrevTab() {
      Send "^+{Tab}"
   }

   wps_Shortcut(letter) {
      Send("{LAlt Down}{LAlt Up}" . letter . "{LAlt Down}{LAlt Up}")
   }

   wps_Bullets() {
      ControlClick "X568 Y98"
   }
}
WPS := C_WPSOffice()


Class C_Player {
   
   plr_SkipOpening() {
      Send "{F12 7}"
   }
}
Player := C_Player()


Class C_Screenshot {
   
   ;In the screenshot tool there are three options that can be selected. Selects those options in a rotary manner, depending on direction
   prt_Options() {
      static optionYoureOn := 1
      ClickThenGoBack((optionYoureOn 
         ? (optionYoureOn := !optionYoureOn, "959 27")
         : (optionYoureOn := !optionYoureOn, "839 28")))
   }

   prt_Fullscreen() {
      ClickThenGoBack("1017 29")
   }
}
Screenshot := C_Screenshot()

Class C_Explorer {
   
   exp_Rename() {
      Send "{F2}"
   }
}
Explorer := C_Explorer()