F_Copy() {
   Send "^c"
}
V_Copy := "^c"

F_Paste() {
   Send "^v"
}
V_Paste := "^v"

F_WinPaste() {
   Send "#v"
}
V_WinPaste := "#v"

F_Cut() {
   Send "^x"
}
V_Cut := "^x"

F_SelectAll() {
   Send "^a"
}
V_SelectAll := "^a"

F_Undo() {
   Send "^z"
}
V_Undo := "^z"

F_Redo() {
   Send "^y"
}
V_Redo := "^y"

F_CloseTab() {
   Send "^w"
}
V_CloseTab := "^w"