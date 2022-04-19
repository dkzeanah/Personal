;YOUTUBE MUSIC
;——————————————————————————————

Class C_YTM {
   
   Liked() => ControlClick("X447 Y913")

   Library() => ControlClick("X1013 Y73")

   Best() => ControlClick("X1206 Y914")

   Discovery() => ControlClick("X950 Y920")

   Fullscreen() => ControlClick("X1863 Y1030")

   Options() => ControlClick("X1542 Y1025",,, "R")

   Like() => Send("^i")

   Dislike() => Send("^u")

   Search() => ControlClick("X1191 Y77")

   CancelSearch() => ControlClick("X398 Y78")

   ChannelSwitch() => (
      ControlClick("X1861 Y75"),
      Sleep(100),
      Send("{Tab 3}{Enter}"),
      Sleep(350),
      Send("{Tab 5}{Enter}")
   )
}
YTM := C_YTM.Call()



;YOUTUBE
;—————————————————————————————

Class C_YT {

   SkipNext() => Send "+n"

   SkipPrev() => Send "+p"

   isWatchingVid() => WinActive(" - YouTube") && !WinActive("Watch later") && !WinActive("Subscriptions")

   isNotWatchingVid() => WinActive("Watch later") || WinActive("Subscriptions") || (WinActive("YouTube") && !WinActive(" - YouTube"))

   ChannelSwitch() => (
      ControlClick("X1820 Y133"),
      Sleep(400),
      Send("{Tab 5}{Enter}")
   )
}
YT := C_YT.Call()