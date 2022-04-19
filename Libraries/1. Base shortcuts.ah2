Class C_Base {
   Copy() {
      Send "^c"
   }
   Copy => "^c"

   Paste() {
      Send "^v"
   }
   Paste => "^v"

   WinPaste() {
      Send "#v"
   }
   WinPaste => "#v"

   Cut() {
      Send "^x"
   }
   Cut => "^x"

   SelectAll() {
      Send "^a"
   }
   SelectAll => "^a"

   Undo() {
      Send "^z"
   }
   Undo => "^z"

   Redo() {
      Send "^y"
   }
   Redo => "^y"

   CloseTab() {
      Send "^w"
   }
   CloseTab => "^w"

   NewTab() {
      Send "^t"
   }
   NewTab => "^t"

   NextTab() {
      Send "^{PgDn}"
   }
   NextTab => "^{PgDn}"

   PrevTab() {
      Send "^{PgUp}"
   }
   PrevTab => "^{PgUp}"

   NextWin() {
      Send "!{Tab}"
   }
   NextWin => "!{Tab}"

   PrevWin() {
      Send "+!{Tab}"
   }
   PrevWin => "+!{Tab}"

   ;Defaults to closing the current window
   CloseWin(winTitle := "A") {
      PostMessage "0x0010",,,, winTitle
   }

   ;Defaults to minimizing the current window
   MinimizeWin(winTitle := "A") {
      PostMessage "0x112", "0xF020",,, winTitle
   }
}
Base := C_Base.Call()