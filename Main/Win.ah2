#HotIf !WinActive("ahk_group Game")

;OBS
<!o::Win.niw_MinMax("ahk_exe obs64.exe") 

;Command prompt
#F9::Win.niw_App("ahk_exe cmd.exe", "cmd.exe")

;Python cmd
#F10::Win.niw_App("ahk_exe py.exe", "py.exe")

;Monkeytype
<!u::Win.niw_App_WinNum("Monkeytype", "4")

;Mail
<!SC033::Win.niw_App_WinNum("Gmail", "1")

;Calendar
<!SC034::Win.niw_App_WinNum("Google Calendar", "2")

;Calculator
<!SC035::Win.niw_App("Calculator", "calc.exe")

;Autohotkey help file
<!SC028::Win.niw_App("AutoHotkey Help", Win.AutoHotkeyDocs_v1)

;Autohotkey v2 help file
<!SC027::Win.niw_App("AutoHotkey v2 Help", Win.AutoHotkeyDocs_v2)

;Gimp 
<!SC01A::Win.niw_App("ahk_exe gimp-2.10.exe", Win.Gimp)

;Atom 
<!y::Win.niw_App("ahk_exe atom.exe", Win.Atom) 

;Video editor
<!SC01B::Win.niw_App("ahk_exe Resolve.exe", Win.DavinciResolve)

;Visual studio code
<!a::Win.niw_App("ahk_exe Code.exe", Win.VScode)

;Youtube music
<!s::Win.niw_App_WinNum("YouTube Music", "6")

;Chrome 
<!c::Win.niw_App("Google Chrome", Win.GoogleChrome)

;Todoist
<!x::Win.niw_App("ahk_exe Todoist.exe", Win.Todoist)

;Wps
<!w::Win.niw_App("ahk_exe wps.exe", Win.WPS)

;Discord
<!q::Win.niw_App("ahk_exe Discord.exe", Win.Discord)

;Explorer
<!e::Win.niw_App_Folders("C:\")

;Documents 
<!d::Win.niw_App_Folders("C:\Files\Documents")

;Pictures
<!v::Win.niw_App_Folders("C:\Files\Pictures")

;One Piece
<!b::Win.niw_App_Folders("C:\Files\Pictures\One Piece")

;MinMaxes a game if it exists, closes all apps but spotify if all main 6 apps exist, if they don't: launches those apps of the main 6, that do not yet exist
<!g:: {

   chrome := "Google Chrome"
   todoist := "ahk_exe Todoist.exe"
   telegram := "Telegram"
   vscode := "ahk_exe Code.exe"
   discord := "ahk_exe Discord.exe"
   steam := "ahk_exe steam.exe"

   ;Variable for ALL the main 6 apps existing
   mainAppsExist := (WinExist(chrome) && WinExist(todoist) && WinExist(telegram) && WinExist(vscode) && WinExist(discord))

   (WinExist("ahk_group Game") 
      ? Win.niw_MinMax("ahk_group Game") 
      : (mainAppsExist 
         ? WinClose("ahk_group Main") 
         : (Win.niw_ifClose(steam),
            Win.niw_ifRun(chrome, Win.GoogleChrome),
            Win.niw_ifRun(todoist, Win.Todoist),
            Win.niw_ifRun(telegram, Win.Telegram),
            Win.niw_ifRun(vscode, Win.VScode),
            Win.niw_ifRun(discord, Win.Discord))))
}


; Telegram, whatsapp, viber on one, two and three presses
<!t:: {
   Switch Double.dbl_Bool("t") {
      Case True:
         Switch Double.dbl_Bool("t") {
            ; You pressed three times
            Case True:Win.niw_App("ahk_exe Viber.exe", Win.Viber) 
            ; You pressed twice
            Case False:Win.niw_App("ahk_exe WhatsApp.exe", Win.WhatsApp)
         }
      ; You pressed once
      Case False:Win.niw_App("Telegram", Win.Telegram)
   } 
}

;Projects folder on single press, FL Studio on double press
<!f:: {
   (Double.dbl_Bool("f")
      ? Win.niw_App("ahk_exe FL64.exe", Win.FL) 
      : Win.niw_App_Folders("C:\Files\Projects"))
}

;Photos or steam
<!r:: {
   (!Win.niw_ifMinMax("ahk_group Media")
      ? Win.niw_App("ahk_exe steam.exe", Win.Steam, "Steam - News")
      : "")
}

;VPN
<!z:: {
   (!Win.niw_ifMinMax("SoundCloud")
      ? Win.niw_App("ahk_exe vpncmgr_x64.exe", Win.VPN) : "")
}

#HotIf 