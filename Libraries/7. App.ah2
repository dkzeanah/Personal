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
      Send("+n")
   }

   ytt_SkipPrev() {
      Send("+p")
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

