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

   ;Defaults to closing the current window
   bsd_CloseWin(winTitle := "A") {
      PostMessage "0x0010",,,, winTitle
   }

   ;Defaults to minimizing the current window
   bsd_MinimizeWin(winTitle := "A") {
      PostMessage "0x112", "0xF020",,, winTitle
   }
}
Base := C_Base.Call()