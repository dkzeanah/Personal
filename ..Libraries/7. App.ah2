;CHROME ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


Class C_Chrome {
   
   chr_Markdown() {
      MsgBox "* italic *`n** bold **`n~~ strikethrough ~~`n>! spoiler !<`n[embed](link)`n^(superscript)`n`` code inline ```n # BIG TEXT", "MarkDown", "4096"
   }

   chr_CopyLink() {
      Send("^l"), Sleep(40), Base.bsd_Copy()
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
      static i := 0
      ((i) 
         ? (this.ytm_ChannelSwitch_Switch(), i := !i)
         : (this.ytm_ChannelSwitch_Menu(), i := !i))
   }

   ytm_ChannelSwitch_Menu() => ControlClick("X1863 Y75")
   ytm_ChannelSwitch_Switch() => ControlClick("X1688 Y297")

   ;Converts a YT music link into a youtube link and pastes it
   ytm_LinkConverter() {
      F_ClipSend(A_Clipboard := StrReplace(StrReplace(A_Clipboard, "&feature=share", ""), "//music.", "//www."))
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
      Send "f"
   }

   ytt_Miniscreen() {
      Send "i"
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
      static i := 0
      ((i) 
         ? (this.ytt_ChannelSwitch_Switch(), i := !i)
         : (this.ytt_ChannelSwitch_Menu(), i := !i))
   }

   ytt_ChannelSwitch_Menu() => ControlClick("X1821 Y131")
   ytt_ChannelSwitch_Switch() => ControlClick("X1534 Y460")

}
YouTube := C_YouTube.Call()




;MESSENGERS ###########################################################################
;######################################################################################
;######################################################################################
;######################################################################################


Class C_VK {

   vk_Notifications() {
      ControlClick "X788 Y126"
   }

   vk_Voice() {
      ControlClick "X1757 Y1014"
   }

   vk_Scroll() {
      ControlClick "X1750 Y903"
   }

   vk_BlankMessage() {
      Send "&{#}12288;"
   }
}
VK := C_VK()


Class C_Telegram {
   
   tlg_Voice() {
      F_ClickThenGoBack_Event("1452 1052")
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

   dsc_NextServer() {
      Send "^!{Down}"
   }

   dsc_PrevServer() {
      Send "^!{Up}"
   }

   dsc_Markdown() {
      MsgBox "__ underline __`n* italic *`n** bold **`n~~ strikethrough ~~`n|| spoiler ||`n`````` code ```````n`` code inline ```n_ nothing _", "Markdown", "4096"
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
      Send "{Delete 6}{Right 4}"
   }
}
Player := C_Player()


Class C_Screenshot {
   
   ;In the screenshot tool there are three options that can be selected. Selects those options in a rotary manner, depending on direction
   scr_Options(direction) {
      MouseGetPos &initX, &initY
      static optionYoureOn := 1
      if (direction == "left")
         Switch optionYoureOn
         {
            Case 1:
                 Click("959 27")
               , optionYoureOn := 3
            Case 2:
                 Click("839 28")
               , optionYoureOn--
            Case 3:
                 Click("897 31")
               , optionYoureOn--
         }
      else 
         Switch optionYoureOn
         {
            Case 1:
                 Click("897 31")
               , optionYoureOn++
            Case 2:
                 Click("959 27")
               , optionYoureOn++
            Case 3:
                 Click("839 28")
               , optionYoureOn := 1
         }
      MouseMove initX, initY   
   }

   scr_Fullscreen() {
      F_ClickThenGoBack("1017 29")
   }
}
Screenshot := C_Screenshot()