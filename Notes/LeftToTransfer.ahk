;VARIABLES#############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Makes sure not to run the same script more than once. Lets you start and end a script with the same hotkey
Playlist_moving_PID := 0
Discovery_add_PID := 0 

;APP SPECIFIC TECH#####################################################################
;######################################################################################
;######################################################################################
;######################################################################################










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

;Scroll to go between pics
#IfWinActive Photos
WheelUp::Send, {Left}
WheelDown::Send, {Right}
#IfWinActive






;TOOLS#################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Gets current cursor's position and opens a gui giving you the options for formatting the parameters for different commands to put them into your Clipboard or to not copy them into your Clipboard at all and just exit the gui
+!g::Run, %A_WorkingDir%\Tools\MouseGetPos.ahk



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


