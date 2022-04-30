Class C_Base {
   bsd_Copy() {
      Send "^c"
   }
   bsd_Copy => "^c"

   bsd_Paste() {
      Send "^v"
   }
   bsd_Paste => "^v"

   bsd_WinPaste() {
      Send "#v"
   }
   bsd_WinPaste => "#v"

   bsd_Cut() {
      Send "^x"
   }
   bsd_Cut => "^x"

   bsd_SelectAll() {
      Send "^a"
   }
   bsd_SelectAll => "^a"

   bsd_Undo() {
      Send "^z"
   }
   bsd_Undo => "^z"

   bsd_Redo() {
      Send "^y"
   }
   bsd_Redo => "^y"

   bsd_CloseTab() {
      Send "^w"
   }
   bsd_CloseTab => "^w"

   bsd_NewTab() {
      Send "^t"
   }
   bsd_NewTab => "^t"

   bsd_NextTab() {
      Send "^{PgDn}"
   }
   bsd_NextTab => "^{PgDn}"

   bsd_PrevTab() {
      Send "^{PgUp}"
   }
   bsd_PrevTab => "^{PgUp}"

   bsd_NextWin() {
      Send "!{Tab}"
   }
   bsd_NextWin => "!{Tab}"

   bsd_PrevWin() {
      Send "+!{Tab}"
   }
   bsd_PrevWin => "+!{Tab}"

   bsd_CloseWin(winTitle := "A") {
      PostMessage "0x0010",,,, winTitle
   }

   bsd_MinimizeWin(winTitle := "A") {
      PostMessage "0x112", "0xF020",,, winTitle
   }

   bsd_WinRestoreDown(winTitle := "A") {
      PostMessage "0x112", "0xF120",,, winTitle
   }

   bsd_Maximize(winTitle := "A") {
      PostMessage "0x112", "0xF030",,, winTitle
   }

   bsd_WinRestore(direction, winTitle := "A") {
      ((WinGetMinMax(winTitle)) ;If window is maximized
      ? (this.bsd_WinRestoreDown(winTitle), ;Unmaximize it
         SetTimer(() => (
            !WinGetMinMax(winTitle) ;Check if it's unmaximized every 10ms
               ? (F_WinMove(), SetTimer(, 0)) ;If so, move it
               : ""), 20)) 
      : F_WinMove()) ;If window is not maximized

      F_WinMove() => (
         ( (direction == "right") ? direction := 960
         : (direction == "left")  ? direction := 0 : ""),
         WinMove(direction, 0, 960, 1079, winTitle)
      )
   }

   bsd_ChooseNext() {
      Send "{Down}{Enter}"
   }
   bsd_ChooseNext => "{Down}{Enter}"

   bsd_SwitchLanguage() {
      Send "{LWin Down}{Space}{LWin Up}"
   }
   bsd_SwitchLanguage => "{LWin Down}{Space}{LWin Up}"

   bsd_ShiftClick() {
      Send "+{Click}"
   }
   bsd_ShiftClick => "+{Click}"

   bsd_CtrlClick() {
      Send "^{Click}"
   }
   bsd_CtrlClick => "^{Click}"

   bsd_Search() {
      Send "^f"
   }
   bsd_Search => "^f"

   bsd_MouseAltTab() {
        Send("{AltDown}{Tab}")
      , KeyWait("LButton", "D")
      , Sleep(150)
      , Send("{AltUp}")
      , (WinActive("ahk_exe wps.exe") ? Send("{Esc}") : "")
   }

   bsd_WinTab() {
      Send "#{Tab}"
   }

   bsd_Save() {
      Send "^s"
   }
   bsd_save => "^s"

   bsd_RestoreTab() {
      Send "^+t"
   }
   bsd_RestoreTab => "^+t"
}
Base := C_Base()