Class C_WindowsApp {

   ;Minimizes or maximizes the window depending on its state
   niw_MinMax(title) {
      (WinActive(title) 
         ? PostMessage("0x112", "0xF020",,, title) 
         : WinActivate(title))
   } 

   ;If the window exists, minimize or maximize it depending on its state and return 1, otherwise return 0
   niw_ifMinMax(title) {
      if WinExist(title) {
         this.niw_MinMax(title)
         return True
      }
      else
         return False
   }

   ;Run app, but only if it doesn't exist already
   niw_ifRun(winTitle, exePath) {
      (!WinExist(winTitle) ? Run(exePath) : "")
   }

   ;ifRunApp, but runs using a windows + number hotkey
   niw_ifRun_WinNum(winTitle, winNum) {
      (!WinExist(winTitle) ? Send("#" . winNum) : "")
   }

   ;Run an exe, activate its window
   niw_Run(winTitle, exePath, closeWin:=False) {
      Run exePath,, "Max"
      WinWait winTitle,, 10
      WinActivate winTitle
      ;If there's an unnesesary window that likes to pop up, it will get closed
      ((closeWin) 
      ? (WinWait(closeWin,, 20), this.niw_ifClose(closeWin)) : "")
   } 

   ;Only tries to close the window if it exists
   niw_ifClose(winTitle) {
      (WinExist(winTitle) ? WinClose(winTitle) : "")
   }

   ;If the app doesn't exist, launches it. If it does and is active, minimizes it. If it's minimized, activates it
   niw_App(winTitle, exePath, closeWin:=False) {
      (!this.niw_ifMinMax(winTitle) ? this.niw_Run(winTitle, exePath, closeWin) : "")
   }

   ;Windows app name, but there's no exe fot the app so you put it in your taskbar and use windows + number to launch it and then this optimized way of activating it and minimizing it
   niw_App_WinNum(winTitle, windowsNumber) {
      (!this.niw_ifMinMax(winTitle)
         ? (Send("#" . windowsNumber),
            WinWait(winTitle,, 10),
            WinActivate(winTitle)) : "")
   }

   ;WindowsApp, but for folders
   F_App_Folders(folderPath) {
      Switch {
         Case !WinExist(folderPath):Run(folderPath), WinWait(folderPath), WinActivate(folderPath)
         Case WinActive(folderPath):WinMinimize folderPath
         Case !WinActive(folderPath):WinActivate folderPath
      }
   }
}
Win := C_WindowsApp()