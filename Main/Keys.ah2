SetWorkingDir "C:\Files\Programming\Personal" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
; Persistent True ;Make the script not autoquit if it doesn't have hotkeys




;SCRIPT SELF###########################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Reload this script
+ScrollLock::
{
   Run A_ScriptFullPath
   SoundPlay "*-1"
}

;Suspend this script 
#SuspendExempt True
^!ScrollLock::
{
   if A_IsSuspended
   {
      Suspend False
      SoundPlay "*-1"

   }
   else 
   {
      Suspend True
      SoundPlay "*16"
   }
}
#SuspendExempt 

;Exit this script
+!ScrollLock::SoundPlay("*16"), ExitApp()

;Run Testscript
+Pause::SoundPlay("*-1"), Run(A_WorkingDir . "\Test\TestScript.ah2") 




;VARIABLES#############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Often when you want something selected, you'll send down and enter, so this is the variable for that 
select := "{Down}{Enter}"

;Time part of the ekursы link
ekurs_time := 1646067600 

;Games
GroupAdd "Game", "Enter the Gungeon"
GroupAdd "Game", "Binding of Isaac: Repentance"
GroupAdd "Game", "Super Auto Pets"
GroupAdd "Game", "Nuclear Throne"
GroupAdd "Game", "Terraria"
GroupAdd "Game", "Minecraft"

;Messengers
GroupAdd "Messenger", "Messenger"
GroupAdd "Messenger", "Telegram"
GroupAdd "Messenger", "Discord"
GroupAdd "Messenger", "WhatsApp"
GroupAdd "Messenger", "Viber"
GroupAdd "Messenger", "YouTube"
GroupAdd "Messenger", "Instagram" 

;Media
GroupAdd "Media", "Photos"
GroupAdd "Media", "ahk_exe KMPlayer64.exe"




;FUNCTIONS#############################################################################
;######################################################################################
;###################################################################################### 
;###################################################################################### 


;Sends one thing if you pressed a button once. A different thing if twice. 
PressSend_Double(keyname, toSend1:="", toSend2:="")
{
   KeyWait keyname
   ((KeyWait(keyname, "D T0.1")) ? (Send(toSend2)) : (Send(toSend1)))
}

;Only tries to close the window if it exists
ifWinClose(winTitle)
{
   if WinExist(winTitle)
      WinClose(winTitle)
}




;HOTSTRINGS############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;If I try to laugh in russian but my language is set to english, it autosets the language to russian
:*?:[f[f::{LWin Down}{Space}{LWin Up} 
:*?:[[f[f::{LWin Down}{Space}{LWin Up} 


;SECTION OF HOTSTRINGS THAT OPEN LINKS
;-------------------------------------
;Reddit
:?X:reddit::Run "https://www.reddit.com/notifications"
;Instagram
:?X:inst::Run "https://www.instagram.com/"
;Twitter
:?X:twit::Run "https://twitter.com/home"
;Eкурсы
:?X:eku::Run "https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . ekurs_time
;MyAnimeList
:?X:mal::Run "https://myanimelist.net/profile/Axlefublr"
;Metta
:?X:metta::Run "https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4"
;Weather
:?X:weather::Run "https://yandex.ru/pogoda/krasnoyarsk"
;GitHub
:?X:git::Run "https://github.com/Axlefublr/Personal"
;Расписание пар
:?X:timf::Run A_WorkingDir . "\Libraries\Time table"
:?:timt::
{
   Switch A_WDay 
   {
      Default:Run A_WorkingDir . "\Libraries\Time table\Monday.jpg"
      Case 2:Run A_WorkingDir . "\Libraries\Time table\Tuesday.jpg"
      Case 3:Run A_WorkingDir . "\Libraries\Time table\Wednesday.jpg"
      Case 4:Run A_WorkingDir . "\Libraries\Time table\Thursday.jpg"
      Case 5:Run A_WorkingDir . "\Libraries\Time table\Friday.jpg"
   }
}

;Alt + number sends the Unicode for a specific emoji, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😭🧐😳🤨🤔—💀
#HotIf WinActive("ahk_group Messenger")
!1::Send("{U+1F97A}")
!2::Send("{U+1F60B}")
!3::Send("{U+1F92F}")
!4::Send("{U+1F63C}")
!5::Send("{U+1F60E}")
!6::Send("{U+1F62D}")
!7::Send("{U+1F9D0}")
!8::Send("{U+1F633}")
!9::Send("{U+1F928}")
!0::Send("{U+1F914}")
!=::Send("{U+1F480}")
#HotIf 




;KBMAIN################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Close active window
!Escape::(WinActive("ahk_exe Spotify.exe") ? Send("^+q") : PostMessage("0x0010",,,, "A"))

;Long dash
!-::Send "{ASC 0151}"

;Alt enter in down enter
!Enter::Send select

;Easily accessible paste window
#Insert::Send "#v"

;Cut everything that you've written
!Insert::Send "^a^x"

;Delete everything that you've written
!Delete::Send "^a{Delete}" 

;Media keys
!SC029::Media_Play_Pause
>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next


;SHIFT ALT + KEY HOTKEYS MADE TO BE MORE EASILY PRESSABLE VERSIONS OF DIFFERENT HOTKEYS. THESE SOMETIMES CHANGE DEPENDING ON THE APP IN THE APP SPECIFIC BLOCK
;---------------------------------------------------------------------------------------
#HotIf 
;Shift alt w closes a tab
+!w::Send "^w"
;Shift alt a selects all
+!a::Send "^a"
#HotIf 


;Easy way to reactivate the previous window after using the quick add task of todoist
; +!x::
; {
;    global todoistQA_ID := WinGetID("A")
;    Send "^!+x"
;    if WinWait("ahk_exe Todoist.exe",, 7)
;    {
;       SetTimer TodoistTimer.Call(), 100
;    }
; }

; Class TodoistTimer extends Object
; {
;    Call(todoistQA_ID)
;    {
;       if !WinActive("ahk_exe Todoist.exe")
;       {
;          WinActivate "ahk_id " . todoistQA_ID
;          SetTimer , "Off"
;       }
;    }
; }

;Pure remapping
AppsKey::LCtrl 
SC138::RAlt ;This is supposed to be right alt to begin with, but it worked fuckily so I made sure it's right alt. Worked a wonder ever since.

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game 
#HotIf WinActive("ahk_group Game")
Volume_Down & MButton::Media_Play_Pause
XButton1::XButton1
XButton2::XButton2
#HotIf

;Makes sure fn + function key doesn't do its native function. Commented if made into a hotkey
$Launch_Media::return ;F1
$Media_Play_Pause::return ;F2
$Media_Stop::return ;F3
$Media_Prev::return ;F4
$Media_Next::return ;F5
$Volume_Mute::return ;F6
$Volume_Up::return ;F7
; $Volume_Down::return ;F8
$Launch_App1::return ;F9
; $Launch_Mail::return ;F10
; $Launch_App2::return ;F11
$Browser_Home::return ;F12




;MOUSE KEY INTERACTION#################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


#HotIf

;Special button + side buttons
Volume_Down & XButton2::PressSend_Double("XButton2","^v","#v")
Volume_Down & XButton1::PressSend_Double("XButton1","^c","^x")
Volume_Down & MButton::F5

#HotIf

;Special button by itself pressed in different sections of the screen does different things
Volume_Down::
{ 
   MouseGetPos &SectionX, &SectionY
   right := (SectionX > 1368), left := (SectionX < 568), down := (SectionY > 747), up := (SectionY < 347) 
   Switch
   {
      Case right:Send "#{Right}"
      Case left:Send "#{Left}"
      Case down:Send "#{Down}"
      Case up:Send "#{Up}"
      Default: 
         Send "{AltDown}{Tab}" 
         KeyWait "LButton", "D"
         Sleep 150
         Send "{AltUp}"
   } 
}


#HotIf !WinActive("ahk_group Game")

;Combined side buttons
XButton2 & XButton1::Escape
XButton1 & XButton2::Media_Play_Pause

;Far side button and Wheel
XButton2 & WheelUp::Volume_Up
XButton2 & WheelDown::Volume_Down

;Close side button and Wheel
XButton1 & WheelUp::Send "^y"
XButton1 & WheelDown::Send "^z"

;Close side button with L and R buttons 
XButton1 & LButton::((WinActive("ahk_exe Spotify.exe")) ? Send(select) : Send("{BackSpace}"))
XButton1 & RButton::Delete

;Far side button with L and R buttons
XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter




;SECTION GESTURES#####################################################################
;#####################################################################################
;#####################################################################################
;##################################################################################### 


;Far side button, does different things depending on what section of the screen it was pressed on. Right, left, down, up or middle
$XButton2::
{ 
   MouseGetPos &SectionX, &SectionY
   right := (SectionX > 1368), left := (SectionX < 568), down := (SectionY > 747), up := (SectionY < 347) ;Here I define the sections
   Switch
   {
      Case right:
         Switch
         {
            ; Case WinActive("ahk_group YouTube_vid"):Send, +n
            Case WinActive("ahk_exe Spotify.exe"):Send "^{Right}"
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgDn}"
            Default:Send "{Media_Next}"
         }
      Case left:
         Switch
         {
            ; Case WinActive("ahk_group YouTube_vid"):Send, +p
            Case WinActive("ahk_exe Spotify.exe"):Send "^{Left}"
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgUp}"
            Default:Send "{Media_Prev}"
         }
      Case down:((WinActive("ahk_exe Spotify.exe")) ? (Send("^+q")) : (PostMessage("0x0010",,,, "A"))) ;Closes the active window
      Case up:PostMessage "0x112", "0xF020",,, "A" ;Minimizes the active window
      Default:((WinActive("ahk_exe Code.exe")) ? (Send("^!/")) : (Send("{Browser_Forward}")))
   }
}

;Close side button, does different things depending on what section of the screen it was pressed on. Right, left, down, up or middle
$XButton1::
{ 
   MouseGetPos &SectionX, &SectionY
   right := (SectionX > 1368), left := (SectionX < 568), down := (SectionY > 747), up := (SectionY < 347)
   Switch
   {
      Default:Send "{Browser_Back}"
      Case WinActive("Google Chrome"): ;_chrome
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right:Send "^{PgDn}"
            Case left:Send "^{PgUp}"
            Case up:Send "^t"
            Case down:((WinActive("Messenger")) ? (ControlClick("X1750 Y903")) : (Send("^w")))
         }
      Case WinActive("ahk_exe Code.exe"): ;_vscode
         Switch
         {
            Default:Send "^/"
            Case right:Send "^!{Right}"
            Case left:Send "^!{Left}"
            Case down:
               Run A_WorkingDir . "\Test\TestScript.ah2"
               SoundPlay "*-1" 
            Case up: 
               Run A_ScriptFullPath
               SoundPlay "*-1" 
         }
      Case WinActive("ahk_exe Spotify.exe"): ;_spotify
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right:
            ;    Process, Exist, %Discovery_add_PID%
            ;    ;Launches a script that counts how many tracks you've added to a playlist in spotify (meaning, right clicks) if it isn't already running, otherwise exits it by sending a button that is binded to an exitapp in that script
            ;    if ErrorLevel
            ;       Send, {Launch_App2}
            ;    else 
            ;       Run, %A_WorkingDir%\Tools\Discovery add.ahk,,, Discovery_add_PID
            ; Case left:
            ;    Process, Exist, %Playlist_moving_PID%
            ;    ;Launches a scripts that counts how many tracks you've selected in spotify (meaning, controlclicks) if it isn't already running, otherwise exits it by sending a button that is binded to an exitapp in that script
            ;    if ErrorLevel
            ;       Send, {Launch_Mail}
            ;    else 
            ;       Run, %A_WorkingDir%\Tools\Playlist moving.ahk,,, Playlist_moving_PID
            Case down:
               ;Unlikes current track and opens the menu for you to click to delete it from the playlist
               ControlClick "X36 Y1021",,, "R" 
               ControlSend "{Up 3}" 
               Send "+!b"
            Case up:
               ;Likes current track and opens the menu for you to click to add to a playlist
               ControlClick "X36 Y1021",,, "R"
               ControlSend "{Up 2}{Right}"
               Sleep 5
               Send "+!b" 
         } 
      Case WinActive("ahk_exe wps.exe"): 
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right:Send "^{Tab}"
            Case left:Send "^+{Tab}"
            Case down:Send "{PgDn}"
            Case up:Send "^s"
         }
      Case WinActive("Discord"): ;_discord
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right, left, up:return
            Case down:Send "{Esc}"
         }
      Case WinActive("Telegram"): ;_telegram
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right, left, up:return
            Case down:ControlClick "X1434 Y964" ;Clicks the scroll button since shift PgDn doesn't work for some reason
         }
      Case WinActive("Todoist"): ;_todoist
         Switch
         {
            Default:Send "{Browser_Back}"
            ; Case right:Todoist_Search("unfinished")
            ; Case left:Todoist_Search("rappers")
            ; Case down:Todoist_Search("payments")
            ; Case up:Todoist_Search("inbox")
         }
   } 
}

#HotIf




;APP SPECIFIC MULTIPLE MAIN############################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


#HotIf WinActive("Google Chrome") ;_chrome

;Ctrl numbers aren't easy to press, so F keys instead
$F1::Send "^1"
$F2::Send "^2"
$F3::Send "^3"
$F4::Send "^4"
$F5::Send "^5"
$F6::Send "^6"
$F7::Send "^7"
$F8::Send "^8"
$F9::Send "^9"

;Reminds of the markdown syntax for reddit
:?X:mark::MsgBox "* italic *`n** bold **`n~~ strikethrough ~~`n>! spoiler !<`n[embed](link)`n^(superscript)`n`` code inline ```n # BIG TEXT", "MarkDown", "4096"

;Single press is copy, double press will get current tab's link to clipboard
Volume_Down & XButton1::
{
   KeyWait "XButton1" 
   (KeyWait "XButton1", "D T0.1" ? (Send("{F6}"), Sleep("40"), Send("^c")) : Send("^c"))
}

;Opens a new tab
+!e::Send "^t"

#HotIf




;APP SPECIFIC TECH#####################################################################
;######################################################################################
;######################################################################################
;######################################################################################




;APP SPECIFIC MESSENGERS###############################################################
;######################################################################################
;######################################################################################
;######################################################################################




;APP SPECIFIC SINGLE###################################################################
;######################################################################################
;######################################################################################
;######################################################################################




;TOOLS#################################################################################
;######################################################################################
;######################################################################################
;######################################################################################




;APPS##################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Minimizes or maximizes the window depending on its state
MinMax(title) {
   Try (WinActive(title) ? WinMinimize(title) : WinActivate(title))
}

;If the window exists, minimize or maximize it depending on its state and return 1, otherwise return 0
ifMinMax(title)
{
   if WinExist(title)
   {
      MinMax(title)
      return 1
   }
   else
      return 0
}

;Run an exe, activate its window
RunApp(winTitle, exePath)
{
   Run exePath,, "Max"
   WinWait winTitle,, 7
   WinActivate winTitle
} 

;Run app, but only if it doesn't exist already
ifRunApp(winTitle, exePath)
{
   if !WinExist(winTitle)
   {
      Run exePath,, "Max" 
      WinWait winTitle
   } 
}

;If the app doesn't exist, launches it. If it does and is active, minimizes it. If it's minimized, activates it
WindowsApp(winTitle, exePath) 
{
   if !ifMinMax(winTitle)
      RunApp(winTitle, exePath)
}

;Windows app name, but there's no exe fot the app so you put it in your taskbar and use windows + number to launch it and then this optimized way of activating it and minimizing it
WindowsApp_WinNum(winTitle, windowsNumber)
{
   if !ifMinMax(winTitle)
   {
      Send "#" . windowsNumber
      WinWait winTitle,, 7
      WinActivate winTitle
   } 
}

;WindowsApp, but for folders
WindowsApp_Folders(folderPath)
{
   Switch
   {
      Case !WinExist(folderPath):RunWait folderPath
      Case WinActive(folderPath):WinMinimize folderPath
      Case !WinActive(folderPath):WinActivate folderPath
   }
}

;OBS
<!o::MinMax("OBS") 

;Monkeytype
<!u::WindowsApp_WinNum("Monkeytype", "4")

;Mail
<!SC033::WindowsApp_WinNum("Gmail", "1")

;Calendar
<!SC034::WindowsApp_WinNum("Google Calendar", "2")

;Calculator
<!SC035::WindowsApp("Calculator", "calc.exe")

;Autohotkey help file
<!SC028::WindowsApp("AutoHotkey Help", "C:\Programs\Autohotkey\AutoHotkey.chm")

;Autohotkey v2 help file
<!SC027::WindowsApp("AutoHotkey v2 Help", "C:\Programs\Autohotkey\v2\AutoHotkey.chm")

;Gimp 
<!SC01A::WindowsApp("GIMP", "C:\Programs\GIMP 2\bin\gimp-2.10.exe")

;Atom 
<!y::WindowsApp("ahk_exe atom.exe", "C:\Users\serge\AppData\Local\atom\app-1.58.0\atom.exe") 

;Video editor
<!SC01B::WindowsApp("ahk_exe Resolve.exe", "C:\Programs\Davinci Resolve\Resolve.exe")

;MinMaxes a game if it exists, closes all apps but spotify if all main 6 apps exist, if they don't: launches those apps of the main 6, that do not yet exist
<!g:: 
{
   ;ahk_exe of the main 6 apps 

   ;Google Chrome
   chrome := "ahk_exe chrome.exe"
   chrome_exe := "C:\Program Files\Google\Chrome\Application\chrome.exe" 
   ;Todoist
   todoist := "ahk_exe Todoist.exe"
   todoist_exe := "C:\Users\serge\AppData\Local\Programs\todoist\Todoist.exe"
   ;Telegram
   telegram := "ahk_exe Telegram.exe"
   telegram_exe := "C:\Programs\Telegram Desktop\Telegram.exe"
   ;Visual Studio Code
   vscode := "ahk_exe Code.exe"
   vscode_exe := "C:\Programs\Microsoft VS Code\Code.exe"
   ;Discord
   discord := "ahk_exe Discord.exe"
   discord_exe := "C:\Users\serge\AppData\Local\Discord\app-1.0.9004\Discord.exe"
   ;Spotify
   spotify := "ahk_exe Spotify.exe"
   spotify_exe := "C:\Users\serge\AppData\Roaming\Spotify\Spotify.exe"
   ;Steam
   steam := "ahk_exe steam.exe"
   steam_exe := "C:\Programs\Steam\steam.exe"

   ;Variable for ALL the main 6 apps existing
   mainAppsExist := (WinExist(chrome) && WinExist(todoist) && WinExist(telegram) && WinExist(vscode) && WinExist(discord) && WinExist(spotify)) 

   if !MinMax("ahk_group Game")
      (mainAppsExist ? (WinClose(chrome), WinClose(todoist), WinClose(telegram), WinClose(vscode), WinClose(discord), ifWinClose("Monkeytype"), ifWinClose("Google Calendar"), ifWinClose("AutoHotkey Help"), ifWinClose("AutoHotkey v2 Help"), WinActivate(spotify)) 
      : (ifWinClose(steam), ifRunApp(chrome, chrome_exe), ifRunApp(todoist, todoist_exe), ifRunApp(telegram, telegram_exe), ifRunApp(vscode, vscode_exe), ifRunApp(discord, discord_exe), ifRunApp(spotify, spotify_exe)))
}


HotIfWinNotActive "ahk_group Game"

;Visual studio code
$<!a::WindowsApp("ahk_exe Code.exe", "C:\Programs\Microsoft VS Code\Code.exe")

;Spotify 
$<!s::WindowsApp("ahk_exe Spotify.exe", "C:\Users\serge\AppData\Roaming\Spotify\Spotify.exe")

;Chrome 
<!c::WindowsApp("Google Chrome", "C:\Program Files\Google\Chrome\Application\chrome.exe")

;VPN
<!z::WindowsApp("ahk_exe vpncmgr_x64.exe", "C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe")

;Todoist
<!x::WindowsApp("ahk_exe Todoist.exe", "C:\Users\serge\AppData\Local\Programs\todoist\Todoist.exe")

;Wps
<!w::WindowsApp("ahk_exe wps.exe", "C:\Users\serge\AppData\Local\Kingsoft\WPS Office\11.2.0.10463\office6\wps.exe")

;Telegram, whatsapp, viber on one, two and three presses
<!t::
{
   KeyWait "t"
   Switch KeyWait("t", "D T0.1")
   {
      Case True:
         KeyWait "t"
         Switch KeyWait("t", "D T0.1")
         {
            ; You pressed three times
            Case True:WindowsApp("ahk_exe Viber.exe", "C:\Users\serge\AppData\Local\Viber\Viber.exe") 
            ; You pressed twice
            Case False:WindowsApp("ahk_exe WhatsApp.exe", "C:\Users\serge\AppData\Local\WhatsApp\app-2.2140.12\WhatsApp.exe")
         }
      ; You pressed once
      Case False:WindowsApp("Telegram", "C:\Programs\Telegram Desktop\Telegram.exe")
   } 
}

;Projects folder on single press, FL Studio on double press
<!f::
{
   KeyWait "f"
   if KeyWait("f", "D T0.1")
      WindowsApp("ahk_exe FL64.exe", "C:\Programs\FL Studio 20\FL64.exe")
   else
      WindowsApp_Folders("C:\Files\Projects")
}

;Discord
<!q::WindowsApp("ahk_exe Discord.exe", "C:\Users\serge\AppData\Local\Discord\app-1.0.9004\Discord.exe")

;Photos
$<!r::
{
   if !ifMinMax("ahk_group Media")
      WindowsApp("ahk_exe steam.exe", "C:\Programs\Steam\steam.exe")
}

;Explorer
$<!e::WindowsApp_Folders("C:\") 

;Documents 
<!d::WindowsApp_Folders("C:\Files\Documents")

;Pictures
<!v::WindowsApp_Folders("C:\Files\Pictures")

;One Piece
<!b::WindowsApp_Folders("C:\Files\Pictures\One Piece")
