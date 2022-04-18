;Minimizes or maximizes the window depending on its state
F_MinMax(title) => (WinActive(title) ? WinMinimize(title) : WinActivate(title))

;If the window exists, minimize or maximize it depending on its state and return 1, otherwise return 0
F_ifMinMax(title) => (WinExist(title) ? (F_MinMax(title), 1) : 0)

;Run app, but only if it doesn't exist already
F_ifRunApp(winTitle, exePath) => (!WinExist(winTitle) ? Run(exePath) : "")

;ifRunApp, but runs using a windows + number hotkey
F_ifRunApp_WinNum(winTitle, winNum) => (!WinExist(winTitle) ? Send("#" . winNum) : "")

;Run an exe, activate its window
F_RunApp(winTitle, exePath, closeWin:=False) {
   Run exePath,, "Max"
   WinWait winTitle,, 10
   WinActivate winTitle
   ;If there's an unnesesary window that likes to pop up, it will get closed
   ((closeWin) 
   ? (WinWait(closeWin,, 20), F_ifWinClose(closeWin)) : "")
} 

;Only tries to close the window if it exists
F_ifWinClose(winTitle) {
   if WinExist(winTitle)
      WinClose(winTitle)
}

;If the app doesn't exist, launches it. If it does and is active, minimizes it. If it's minimized, activates it
F_WindowsApp(winTitle, exePath, closeWin:=False) {
   (!F_ifMinMax(winTitle) ? F_RunApp(winTitle, exePath, closeWin) : "")
}

;Windows app name, but there's no exe fot the app so you put it in your taskbar and use windows + number to launch it and then this optimized way of activating it and minimizing it
F_WindowsApp_WinNum(winTitle, windowsNumber) {
   (!F_ifMinMax(winTitle)
   ? (Send("#" . windowsNumber),
   WinWait(winTitle,, 10),
   WinActivate(winTitle)) : "")
}

;WindowsApp, but for folders
F_WindowsApp_Folders(folderPath) {
   Switch {
      Case !WinExist(folderPath):Run(folderPath), WinWait(folderPath), WinActivate(folderPath)
      Case WinActive(folderPath):WinMinimize folderPath
      Case !WinActive(folderPath):WinActivate folderPath
   }
}
