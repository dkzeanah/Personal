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

   ytt_SkipNext() {
      Send "+n"
   }

   ytt_SkipPrev() {
      Send "+p"
   }

   ytt_Fullscreen() {
      Send "f"
   }

   ytt_Miniscreen() {
      Send "i"
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
}
Todoist := C_Todoist()


;WPS
;————————————————————————————————

Class C_WPSOffice {
   
   wps_NextTab() {
      Send "^{Tab}"
   }

   wps_PrevTab() {
      Send "^+{Tab}"
   }
}
WPS := C_WPSOffice()