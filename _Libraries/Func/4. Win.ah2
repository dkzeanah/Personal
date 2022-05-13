Class C_WindowsApp {

   ;EXE PATHS
   ;————————————————————————————————
   
   AutoHotkeyDocs_v1 => "C:\Program Files\Autohotkey\AutoHotkey.chm"

   AutoHotkeyDocs_v2 => "C:\Program Files\Autohotkey\v2\AutoHotkey.chm"

   Gimp => "C:\Programs\GIMP 2\bin\gimp-2.10.exe"

   Atom => "C:\Users\serge\AppData\Local\atom\app-1.58.0\atom.exe"

   DavinciResolve => "C:\Programs\Davinci Resolve\Resolve.exe"

   Viber => "C:\Users\serge\AppData\Local\Viber\Viber.exe"

   WhatsApp => "C:\Users\serge\AppData\Local\WhatsApp\app-2.2140.12\WhatsApp.exe"

   Telegram => "C:\Programs\Telegram Desktop\Telegram.exe"

   FL => "C:\Programs\FL Studio 20\FL64.exe"

   Steam => "C:\Programs\Steam\steam.exe"

   VScode => "C:\Users\serge\AppData\Local\Programs\Microsoft VS Code\Code.exe"

   GoogleChrome => "C:\Program Files\Google\Chrome\Application\chrome.exe"

   Todoist => "C:\Users\serge\AppData\Local\Programs\todoist\Todoist.exe"

   WPS => "C:\Users\serge\AppData\Local\Kingsoft\WPS Office\ksolaunch.exe"

   Discord => "C:\Users\serge\AppData\Local\Discord\app-1.0.9004\Discord.exe"

   VPN => "C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe"

   Sounds => "C:\Files\Programming\Personal\Files\Sounds"

   Pictures => "C:\Files\Programming\Personal\Files\Pictures"

   niw_CloseWin(winTitle := "A") {
      PostMessage "0x0010",,,, winTitle
   }

   niw_MinimizeWin(winTitle := "A") {
      PostMessage "0x112", "0xF020",,, winTitle
   }

   niw_WinRestoreDown(winTitle := "A") {
      PostMessage "0x112", "0xF120",,, winTitle
   }

   niw_MaximizeWin(winTitle := "A") {
      PostMessage "0x112", "0xF030",,, winTitle
   }

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
        Run(exePath,, "Max")
      , WinWait(winTitle,, 60)
      , WinActivate(winTitle)
      ;If there's an unnesesary window that likes to pop up, it will get closed
      , ((closeWin) 
      ? (WinWait(closeWin,, 60), this.niw_ifClose(closeWin)) : "")
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
            WinWait(winTitle,, 60),
            WinActivate(winTitle)) : "")
   }

   ;WindowsApp, but for folders
   niw_App_Folders(folderPath) {
      Switch {
         Case !WinExist(folderPath):Run(folderPath), WinWait(folderPath), WinActivate(folderPath)
         Case WinActive(folderPath):WinMinimize folderPath
         Case !WinActive(folderPath):WinActivate folderPath
      }
   }

   niw_CloseOnceInactive(winTitle, closedAfter:=5) {
      SetTimer(() => ;Once this function has been called, there's a timer waiting for the specified window to become inactive
         (!WinActive(winTitle) ;Once it is, deletes the timer
            ? (Settimer(, 0), SetTimer(() => ;And starts a new one, that closes the window after your specified time (better than a sleep)
               Win.niw_CloseWin(winTitle), -closedAfter*1000))
            : "")
      , 200)
   }
}
Win := C_WindowsApp()