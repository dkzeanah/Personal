;CHROME

Class C_Chrome {
   
   chr_Markdown() {
      MsgBox "* italic *`n** bold **`n~~ strikethrough ~~`n>! spoiler !<`n[embed](link)`n^(superscript)`n`` code inline ```n # BIG TEXT", "MarkDown", "4096"
   }

   chr_CopyLink() {
      Send("^l"), Sleep(40), Base.bsd_Copy()
   }
}
Chrome := C_Chrome()


;YOUTUBE MUSIC
;——————————————————————————————

Class C_YouTubeMusic {
   
   ytm_Liked() {
      ControlClick("X447 Y913")
   }

   ytm_Library() {
      ControlClick("X1013 Y73")
   }

   ytm_Best() {
      ControlClick("X1206 Y914")
   }

   ytm_Discovery() {
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
      ControlClick("X1861 Y75")
      Sleep(100),
      Send("{Tab 3}{Enter}")
      Sleep(350),
      Send("{Tab 5}{Enter}")
   }

   ;Converts a YT music link into a youtube link and pastes it
   ytm_LinkConverter() {
      F_ClipSend(A_Clipboard := StrReplace(StrReplace(A_Clipboard, "&feature=share", ""), "//music.", "//www."))
   }
}
YTMusic := C_YouTubeMusic.Call()


;YOUTUBE
;—————————————————————————————

Class C_YouTube {

   ytt_Skip(direction) {
      Send(
           direction == "right"
            ? "+n"
         : direction == "left"
            ? "+p"
         : ""
      )
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

   ytt_isWatchingVid => (WinActive(" - YouTube") && !WinActive("Watch later") && !WinActive("Subscriptions"))

   ytt_isNotWatchingVid => (
      WinActive("Watch later")
      ||  WinActive("Subscriptions")
      || (WinActive("YouTube")
      && !WinActive(" - YouTube"))
   )

   ytt_ChannelSwitch() {
      ControlClick("X1820 Y133")
      Sleep(400)
      Send("{Tab 5}{Enter}")
   }

}
YouTube := C_YouTube.Call()


;VK
;————————————————————————————————

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


;TELEGRAM
;————————————————————————————————

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


;WHATIBER
;————————————————————————————————

Class C_Whatiber {
   
   wtb_Voice() {
      ControlClick "X1873 Y1047"
   }

   wtb_Scroll() {
      ControlClick "X1878 Y961"
   }
}
Whatiber := C_Whatiber()


;DISCORD
;————————————————————————————————

Class C_Discord {
   
   dsc_Emoji() {
      Send "^e"
   }

   dsc_Gif() {
      Send "^g"
   }

   dsc_Markdown() {
      MsgBox "__ underline __`n* italic *`n** bold **`n~~ strikethrough ~~`n|| spoiler ||`n`````` code ```````n`` code inline ```n_ nothing _", "Markdown", "4096"
   }
}
Discord := C_Discord()


;TODOIST
;————————————————————————————————

Class C_Todoist {
   
   tds_Project(projectToFind) {
      Send "f" . projectToFind . "{Down}{Enter}"
   }

   tds_toUnfinished() {
      Send " {#}unfinished — " 
   }
}
Todoist := C_Todoist()


;VS CODE
;————————————————————————————————

Class C_VSCode {
   
   vsc_KeyCodeGetter() {
      inputBoxTitle := "Key codes"
      prevClip := A_Clipboard
      Base.bsd_Copy()
      Sleep 40
      Try {
         MsgBox D_KeyCodes_Out[A_Clipboard], inputBoxTitle
         A_Clipboard := prevClip
      }
      Catch {
         Try {
            keyPointer := InputBox("Key pointer:", inputBoxTitle)
            if keyPointer.Result != "Cancel"
               A_Clipboard := D_KeyCodes_In[keyPointer.Value]
         }
         Catch
            MsgBox "Key not found!", inputBoxTitle, "T1"
      }
   }

   vsc_WorkspaceCorrectPath(vscodeHotkey) {
      ;Open explorer window
      Send(vscodeHotkey), WinWait("ahk_exe explorer.exe"),
      ;Paste the correct path to where workspaces are
      workSpacesFolder := "C:\Files\Programming\Personal\Backups\Workspaces",
      Send("^l"), SendText(workSpacesFolder), Send("{Enter}")
   }

   vsc_FolderCorrectPath(vscodeHotkey) {
      ;Open project chooser
      Send(vscodeHotkey), WinWait("ahk_exe explorer.exe")
      ;Start in the folder that contains the project folders
      projectsFolder := "C:\Files\Programming"
      Send("^l"), SendText(projectsFolder), Send("{Enter}")
   }
}
VSC := C_VSCode()


;WPS
;————————————————————————————————

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


;PLAYER
;————————————————————————————————

Class C_Player {
   
   plr_SkipOpening() {
      Send "{Delete 6}{Right 4}"
   }
}
Player := C_Player()


;SCREENSHOT
;————————————————————————————————

Class C_Screenshot {
   
   ;In the screenshot tool there are three options that can be selected. Selects those options in a rotary manner, depending on direction
   scr_Options(direction) {
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

   scr_Fullscreen() {
      F_ClickThenGoBack("1017 29")
   }
}
Screenshot := C_Screenshot()