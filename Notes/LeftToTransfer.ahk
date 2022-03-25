;VARIABLES#############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;Makes sure not to run the same script more than once. Lets you start and end a script with the same hotkey
Playlist_moving_PID := 0
Discovery_add_PID := 0


youtubeDash := " - YouTube"
;Youtube while watching a video 
GroupAdd, YouTube_vid, %youtubeDash%,,, Watch later|Subscriptions
;Youtube while not watching a video
GroupAdd, YouTube_main, A)YouTube|Watch later|Subscriptions



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





;KBMAIN################################################################################
;######################################################################################
;######################################################################################
;######################################################################################







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
