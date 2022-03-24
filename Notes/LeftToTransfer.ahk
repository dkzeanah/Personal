;VARIABLES#############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Makes sure not to run the same script more than once. Lets you start and end a script with the same hotkey
Playlist_moving_PID := 0
Discovery_add_PID := 0

;Time part of the ekursы link
ekurs_time := 1646067600 

youtubeDash := " - YouTube"
;Youtube while watching a video 
GroupAdd, YouTube_vid, %youtubeDash%,,, Watch later|Subscriptions
;Youtube while not watching a video
GroupAdd, YouTube_main, A)YouTube|Watch later|Subscriptions

;Messengers
GroupAdd, Messenger, Messenger
GroupAdd, Messenger, Telegram
GroupAdd, Messenger, Discord
GroupAdd, Messenger, WhatsApp
GroupAdd, Messenger, Viber
GroupAdd, Messenger, ahk_group YouTube_vid
GroupAdd, Messenger, Instagram




;FUNCTIONS#############################################################################
;######################################################################################
;###################################################################################### 
;###################################################################################### 


;it literally says what it does
ClickThenGoBack(coordX, coordY)
{
   MouseGetPos, initX, initY
   Click, %coordX%, %coordY%
   MouseMove, %initX%, %initY%
}

;clickthengoback, but clicks as an event for extra fucky things
ClickThenGoBack_Event(coordX, coordY)
{
   MouseGetPos, initX, initY
   SendEvent, {Click %coordX%, %coordY%}
   MouseMove, %initX%, %initY%
} 

;Winclose as a function for ternary
ifWinClose(winTitle)
{
   ((WinExist(winTitle)) ? (WinClose(winTitle)))
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
:?:reddit::
Run, https://www.reddit.com/notifications
return 
;Instagram
:?:inst::
Run, https://www.instagram.com/
return 
;Twitter
:?:twit::
Run, https://twitter.com/home
return 
;Eкурсы
:?:eku::
Run, https://e.sfu-kras.ru/calendar/view.php?view=month&time=%ekurs_time%
return 
;Расписание пар
:?:timt::
Switch A_WDay 
{
   Default:Run, %A_WorkingDir%\Libraries\Time table\Monday.jpg
   Case 2:Run, %A_WorkingDir%\Libraries\Time table\Tuesday.jpg
   Case 3:Run, %A_WorkingDir%\Libraries\Time table\Wednesday.jpg
   Case 4:Run, %A_WorkingDir%\Libraries\Time table\Thursday.jpg
   Case 5:Run, %A_WorkingDir%\Libraries\Time table\Friday.jpg
}
return
:?:timf::
Run, %A_WorkingDir%\Libraries\Time table
return 
;MyAnimeList
:?:mal::
Run, https://myanimelist.net/profile/Axlefublr
return 
;Metta
:?:metta::
Run, https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4
return 
;Weather
:?:weather::
Run, https://yandex.ru/pogoda/krasnoyarsk
return 
;GitHub
:?:git::
Run, https://github.com/Axlefublr/Personal_Projects
return 

;Alt + number sends the Unicode for a specific emoji, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😭🧐😳🤨🤔—💀
#IfWinActive ahk_group Messenger
!1::Send, {U+1F97A} ;1
!2::Send, {U+1F60B} ;2
!3::Send, {U+1F92F} ;3
!4::Send, {U+1F63C} ;4
!5::Send, {U+1F60E} ;5
!6::Send, {U+1F62D} ;6
!7::Send, {U+1F9D0} ;7
!8::Send, {U+1F633} ;8
!9::Send, {U+1F928} ;9
!0::Send, {U+1F914} ;0
!=::Send, {U+1F480} ;=
#IfWinActive 




;KBMAIN################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Long dash
!-::Send, {ASC 0151}

;Close active window
!Escape::((WinActive("ahk_exe Spotify.exe")) ? (Send("^+q")) : (PostMessage("0x0010",,,, "A")))

;Alt enter in down enter
!Enter::Send, % ((WinActive("ahk_exe Code.exe")) ? ("{Down}{Tab}") : (select)) 

;Easily accessible paste window
#Insert::Send, #v

;Cut everything that you've written
!Insert::Send, ^a^x

;Delete everything that you've written
!Delete::Send, ^a{Delete} 

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
;Shift alt w closes a tab
+!w::Send, ^w
;Shift alt a selects all
+!a::Send, ^a

;Easy way to reactivate the previous window after using the quick add task of todoist
+!x::
WinGet, prevActWin, ID, A
Send, ^!+x
WinWait, ahk_exe Todoist.exe,, 3
if !ErrorLevel
   SetTimer, Todoist_ReActivateWin, 100
return

Todoist_ReActivateWin:
if !WinActive("ahk_exe Todoist.exe")
{
   WinActivate, ahk_id %prevActWin% 
   SetTimer, Todoist_ReActivateWin, Off
}
return

;Pure remapping
AppsKey::LCtrl 
SC138::RAlt ;This is supposed to be right alt to begin with, but it worked fuckily so I made sure it's right alt. Worked a wonder ever since.

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game 
#IfWinActive ahk_group Game
Volume_Down & MButton::Media_Play_Pause
XButton1::XButton1
XButton2::XButton2
#IfWinActive

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





;APP SPECIFIC MULTIPLE MAIN############################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


#IfWinActive Google Chrome ;_chrome

;Ctrl numbers aren't easy to press, so F keys instead
$F1::Send, ^1
$F2::Send, ^2
$F3::Send, ^3
$F4::Send, ^4
$F5::Send, ^5
$F6::Send, ^6
$F7::Send, ^7
$F8::Send, ^8 
$F9::Send, ^9 

;Reminds of the markdown syntax for reddit
:?:mark::
MsgBox, 4096, Markdown, * italic *`n** bold **`n~~ strikethrough ~~`n>! spoiler !<`n[embed](link)`n^(superscript)`n`` code inline ```n # BIG TEXT
return

;Single press is copy, double press will get current tab's link to clipboard
Volume_Down & XButton1::
KeyWait, XButton1
KeyWait, XButton1, D T0.1 
((ErrorLevel) ? (Send("^c")) : (Send("{F6}"), Sleep("40"), Send("^c")))
return 

;Opens a new tab
+!e::Send, ^t

#IfWinActive


#IfWinActive YouTube ;_youtube 

;Switch channels
XButton2 & Volume_Down::ControlClick, X1821 Y131

;Shift n to skip never made sense to begin with
PgDn::Send, +n
PgUp::Send, +p

#IfWinActive


#IfWinActive ahk_group YouTube_main

;Close minimized window 
Escape::ControlClick, X1858 Y665

;Pop out window
XButton1 & Volume_Down::i

#IfWinActive 


#IfWinActive ahk_group YouTube_vid 

;Picture in picture
+!r::ControlClick, X1579 Y73

;Fullscreen
XButton1 & Volume_Down::f

#IfWinActive 


#IfWinActive ahk_exe Spotify.exe ;_spotify

;Slows down the selection of stuff in spotify so you don't accidentally drag stuff as often
^LButton::Send, ^{Click}

;Search (meaning filter)
!j::Send, ^f

;Go to liked
!h::Send, +!s

;Shuffle
Volume_Down & XButton1::Send, ^s

;Like
Volume_Down & XButton2::Send, +!b

;Playlists
$F1::Send, +!1 

;Podcasts
$F2::Send, +!2 

;Currently playing
$F3::Send, +!j

;Skips
PgDn::Send, ^{Right}
PgUp::Send, ^{Left}

#IfWinActive 


#IfWinActive Todoist ;_todoist

;Goes to the project or label or filter or your mom
Todoist_Search(projectToFind)
{
   Send, f%projectToFind%{Down}{Enter}
}

;Hotkeys to jump to different projects
$F1::Todoist_Search("inbox") ;F1 
$F2::Todoist_Search("rappers") ;F2
$F3::Todoist_Search("unfinished") ;F3
$F4::Todoist_Search("payments") ;F4
$F5::Todoist_Search("desires") ;F5
$F6::Todoist_Search("shopping") ;F6

;Gives the current task an unfinished label and lets you edit its description
+!t::Send, ` {#}unfinished —` ` ;Straight up doesn't work if you don't have a space before everything else

;Enter is always down enter
Enter::Send, % select

#IfWinActive 




;APP SPECIFIC TECH#####################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#IfWinActive ahk_exe Code.exe ;_vscode

;Shift click, but entirely on the mouse
XButton1 & Volume_Down::Send, +{Click}

;Gets the name of the key by its sc code 
XButton2 & Volume_Down::
Send, ^c
Sleep, 100
Loop, Read, %A_WorkingDir%\Libraries\SC code keys.txt ;Reads every line until it comes across the SC code you selected
{
   readLine_contents_key := A_LoopReadLine 
   lineIndex := A_Index
}
Until readLine_contents_key == Clipboard
;Since the SC code of a key is always on the next line after the key, reads every line until it gets to the previous line before the SC code
Loop, Read, %A_WorkingDir%\Libraries\SC code keys.txt
   foundCode := A_LoopReadLine
Until A_Index = lineIndex - 1
;And then shows you the name of the key in a MsgBox
MsgBox, 4096, SC code to key, %foundCode%
return 

#IfWinActive


#IfWinActive ahk_exe wps.exe ;_wps

;Bullets
!6::ControlClick, X568 Y98

;Save 
+!s::Send, ^s

;Switch between open documents
$F1::Send, ^+{Tab}
$F4::Send, ^{Tab}

#IfWinActive 


#IfWinActive ahk_exe ScreenClippingHost.exe

;In the screenshot tool there are three options that can be selected. Selects those options in a rotary manner, depending on direction
ScreenshotOptions(direction)
{
   static optionYoureOn := 1
   if (direction == "left")
      Switch optionYoureOn
      {
         Case 1:
            Click, 959, 27
            optionYoureOn := 3
         Case 2:
            Click, 839, 28
            optionYoureOn--
         Case 3:
            Click, 897, 31
            optionYoureOn--
      }
   else 
      Switch optionYoureOn
      {
         Case 1:
            Click, 897, 31
            optionYoureOn++
         Case 2:
            Click, 959, 27
            optionYoureOn++
         Case 3:
            Click, 839, 28
            optionYoureOn := 1
      }
}

;Use the scroll wheel to choose among modes of the screenshot tool
WheelUp::ScreenshotOptions("left")
WheelDown::ScreenshotOptions("right")
MButton::ClickThenGoBack("1017", "29") ;Takes a full-screen screenshot

#IfWinActive




;APP SPECIFIC MESSENGERS###############################################################
;######################################################################################
;######################################################################################
;######################################################################################


#IfWinActive Messenger ;_vk

;Clicks the scroll button bc shift pgdn doesn't work
+PgDn::ControlClick, X1750 Y903 

;Clicks the send button to either start recording or send a voice message
XButton2 & Volume_Down::ControlClick, X1757 Y1014

;Notifications
XButton1 & Volume_Down::ControlClick, X788 Y126

;Makes sure the tab can't be closed by shift alt w which is now ctrl w
+!w::return

#IfWinActive 


#IfWinActive Telegram ;_telegram

;Clicks the search bar for you to search for channels, finds and goes to the channel you want
Telegram_Search(channelToFind)
{
   ControlClick, X422 Y78
   Send, %channelToFind%{Down}{Enter}
} 

;Shift pgdn scrolls down by clicking the scroll button
+PgDn::ControlClick, X1434 Y964 

;SYNTAX HOTKEYS
;--------------
;Spoiler
^p::Send, ^+p 
;Strikethrough
^n::Send, ^+x

;Clicks the send button to send a voice message
XButton2 & Volume_Down::ClickThenGoBack_Event("1452", "1052")

;Press an F key -> go to a channel
$F1::Telegram_Search("diary") ;F1
$F2::Telegram_Search("texts") ;F2
$F3::Telegram_Search("transfer") ;F3
$F4::Telegram_Search("documents") ;F4
$F5::Telegram_Search("алена") ;F5
$F6::Telegram_Search("мама") ;F6
$F7::Telegram_Search("gallery") ;F9 

#IfWinActive 


#IfWinActive Discord ;_discord

;Emoji tab 
XButton1 & Volume_Down::Send, ^e

;Gif tab
XButton2 & Volume_Down::Send, ^g

;Reminds of the markdown syntax in discord
:?:mark::
MsgBox, 4096, Markdown, __ underline __`n* italic *`n** bold **`n~~ strikethrough ~~`n|| spoiler ||`n`````` code ```````n`` code inline ```n_ nothing _
return

#IfWinActive




;APP SPECIFIC SINGLE###################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Voice message
#IfWinActive WhatsApp
XButton2 & Volume_Down::ControlClick, X1875 Y1039
#IfWinActive

;Autoclicker for enter the gungeon
#IfWinActive Enter the Gungeon
MButton::Run, %A_WorkingDir%\Tools\Autoclicker.ahk 
#IfWinActive 

;Edit in edison
#IfWinActive FL Studio
+!t::Send, ^e
#IfWinActive

;Unmute in zoom
#IfWinExist Zoom Meeting
#a::Send, !a
#IfWinExist 

;Scroll to go between pics
#IfWinActive Photos
WheelUp::Send, {Left}
WheelDown::Send, {Right}
#IfWinActive

;Skip opening
#IfWinActive ahk_exe KMPlayer64.exe
Insert::Send, {End 6}{Right 3}
#IfWinActive

;Search in docs
#IfWinActive AutoHotkey Help|AutoHotkey v2 Help
!j::Send, !s
#IfWinActive 




;TOOLS#################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Gets current cursor's position and opens a gui giving you the options for formatting the parameters for different commands to put them into your Clipboard or to not copy them into your Clipboard at all and just exit the gui
+!g::Run, %A_WorkingDir%\Tools\MouseGetPos.ahk

;Opens an inputbox for you to type in a character/button you want the SC code of, then places that SC code into your clipboard
+!k::
InputBox, keyToGetCodeOf, SC Code Getter, Key to get code of: 
;Doesn't do shit to your clipboard if it didn't even try to find a SC code. If it tries and can't find the correct one, places "error" into your clipboard
if (!ErrorLevel && keyToGetCodeOf != "")
{
   ;Reads every line until it comes across the key you inputted
   Loop, Read, %A_WorkingDir%\Libraries\SC code keys.txt
   {
      readLine_contents_key := A_LoopReadLine 
      lineIndex := A_Index
   }
   Until readLine_contents_key = keyToGetCodeOf 
   ;Since the SC code of a key is always on the next line after the key, reads every line until it gets to the next line after the key
   Loop, Read, %A_WorkingDir%\Libraries\SC code keys.txt
      foundCode := A_LoopReadLine
   Until A_Index = lineIndex + 1
   ;And then puts the sc code to your clipboard
   ClipBoard := foundCode 
}
return 

;Launches smart click. Choose the position to click on with shift alt MButton then press the hotkey below again to start clicking. Presses a random position every time until you press the hotkey again to exit the script
#IfWinNotActive ahk_exe Code.exe
+!d::Run, %A_WorkingDir%\Tools\SmartClick.ahk
#IfWinNotActive

;Opens an inputbox for you to input how many minutes to wait, plays a sound and opens a msgbox saying the time has passed after it has. Press the same hotkey while the timer is running to see when it will ring and three options: start a new timer, discarding the current one, continue on, exit the timer
#F6::Run, %A_WorkingDir%\Tools\Basic timer.ahk

;Opens a msgbox showing the exact time
+!q::
FormatTime, currentFullTime_time,, H:mm
FormatTime, currentFullTime_weekDay,, dddd 
FormatTime, currentFullTime_date,, d MMMM 
MsgBox, 4096, Current time, %currentFullTime_time%`n%currentFullTime_weekDay%`n%currentFullTime_date%
return

;Command prompt
#F9::WindowsApp("cmd.exe")

;Python cmd
#F10::WindowsApp("C:\Windows\py.exe")

;Get the root to the exe of the active window and put it into your clipboard
#F5::
WinGet, windowExe, ProcessPath, A
((windowExe) ? (Clipboard := windowExe))
return

;Opens a gui that lets you select a file. Gets the path to that file into your clipboard.
#F7::
FileSelectFile, FilePath,, %A_WorkingDir%, Select a file
((FilePath) ? (Clipboard := FilePath))
return

;Opens a gui that lets you select a folder. Gets the path to that folder into your clipboard.
#F8::
FileSelectFolder, FolderPath, C:\, 3, Select a folder
((FolderPath) ? (Clipboard := FolderPath))
return

;Restart system
#Pause::Shutdown, 2

;Run test script
$Pause:: 
Run, %A_WorkingDir%\Test\TestScript.ahk
SoundPlay, *-1 
return 




;APPS##################################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;MinMaxes a game if it exists, closes all apps but spotify if all main 6 apps exist, if they don't: launches those apps of the main 6, that do not yet exist
<!g:: 

;ahk_exe of the main 6 apps 
chrome := "ahk_exe C:\\Program Files\\Google\\Chrome\\Application\\chrome\.exe"
todoist := "ahk_exe C:\\Users\\serge\\AppData\\Local\\Programs\\todoist\\Todoist\.exe"
telegram := "ahk_exe C:\\Programs\\Telegram Desktop\\Telegram\.exe"
vscode := "ahk_exe C:\\Programs\\Microsoft VS Code\\Code\.exe"
discord := "ahk_exe C:\\Users\\serge\\AppData\\Local\\Discord\\app-1\.0\.9004\\Discord\.exe"
spotify := "ahk_exe C:\\Users\\serge\\AppData\\Roaming\\Spotify\\Spotify\.exe"
steam := "ahk_exe C:\\Programs\\Steam\\steam\.exe"

;Variable for ALL the main 6 apps existing
mainAppsExist := (WinExist(chrome) && WinExist(todoist) && WinExist(telegram) && WinExist(vscode) && WinExist(discord) && WinExist(spotify)) 

((!MinMax("ahk_group Game")) 
? ((mainAppsExist) ? (WinClose(chrome), WinClose(todoist), WinClose(telegram), WinClose(vscode), WinClose(discord), ifWinClose("Monkeytype"), ifWinClose("Google Calendar"), ifWinClose("AutoHotkey Help")) 
: (ifWinClose(steam), IfNotExist_RunApp(chrome), IfNotExist_RunApp(todoist), IfNotExist_RunApp(telegram), IfNotExist_RunApp(vscode), IfNotExist_RunApp(discord), IfNotExist_RunApp(spotify))))
return 

#IfWinNotActive ahk_group Game

;Visual studio code
$<!a::WindowsApp("C:\Programs\Microsoft VS Code\Code.exe")

;Spotify 
$<!s::WindowsApp("C:\Users\serge\AppData\Roaming\Spotify\Spotify.exe")

;Chrome 
<!c::WindowsApp_Name("Google Chrome", "C:\Program Files\Google\Chrome\Application\chrome.exe")

;VPN
<!z::WindowsApp("C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe")

;Todoist
<!x::WindowsApp("C:\Users\serge\AppData\Local\Programs\todoist\Todoist.exe")

;Wps
<!w::WindowsApp_Name("WPS Office","C:\Users\serge\AppData\Local\Kingsoft\WPS Office\11.2.0.10463\office6\wps.exe")

;Telegram, whatsapp, viber on one, two and three presses
<!t::
KeyWait, t
KeyWait, t, D T0.1
if !ErrorLevel 
{ 
   KeyWait, t
   KeyWait, t, D T0.1
   ((!ErrorLevel) ? (WindowsApp("C:\Users\serge\AppData\Local\Viber\Viber.exe")) : (WindowsApp("C:\Users\serge\AppData\Local\WhatsApp\app-2.2140.12\WhatsApp.exe")))
}
else 
   WindowsApp_Name("Telegram", "C:\Programs\Telegram Desktop\Telegram.exe")
return

;Projects folder on single press, FL Studio on double press
<!f::
KeyWait, f
KeyWait, f, D T0.1
((ErrorLevel) ? (WindowsApp_Folders("C:\Files\Projects")) : (WindowsApp_Name("FL Studio 20", "C:\Programs\FL Studio 20\FL64.exe")))
return

;Discord
<!q::WindowsApp("C:\Users\serge\AppData\Local\Discord\app-1.0.9004\Discord.exe")

;Photos
$<!r::((!MinMax("Photos")) ? ((!MinMax("ahk_exe KMPlayer64.exe")) ? (WindowsApp("C:\Programs\Steam\steam.exe"))))

;Explorer
$<!e::WindowsApp_Folders("C:\") 

;Documents 
<!d::WindowsApp_Folders("C:\Files\Documents")

;Pictures
<!v::WindowsApp_Folders("C:\Files\Pictures")

;One Piece
<!b::WindowsApp_Folders("C:\Files\Pictures\One Piece")

#IfWinNotActive