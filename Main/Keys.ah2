SetWorkingDir A_ScriptDir "\..\" ;Ensures a consistent A_WorkingDir.
#SingleInstance Force ;Launches the new instance of the script always, instead of asking whether it should
#Hotstring EndChars `t ;Decides the characters that can finish a hotstring
#WinActivateForce ;Forces windows to be activated, skipping the gentle method
CoordMode "Mouse", "Screen" ;Uses the coordinates of the screen rather than of the window's
A_MaxHotkeysPerInterval := 1000 ;Removes the limitation of 70 hotkeys per 2 seconds
; Persistent True ;Make the script not autoquit if it doesn't have hotkeys




;SCRIPT SELF ##########################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Reload this script
ScrollLock::
{
   Run A_ScriptFullPath
   SoundPlay "*-1"
}

;Suspend this script 
#SuspendExempt True
+ScrollLock::
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
#SuspendExempt False

;Exit this script
!ScrollLock::SoundPlay("*16"), ExitApp()

;Run Testscript
Pause::SoundPlay("*-1"), Run(A_WorkingDir . "\Test\Tests.ah2") 

;Restart system
#ScrollLock::Shutdown 2




;VARIABLES ############################################################################
;######################################################################################
;######################################################################################
;###################################################################################### 


;An array of the 1000 most used english words
#Include "C:\Files\Programming\Personal\Libraries\Random words.ah2"

;A dictionary of key names and SC codes of them
#Include "C:\Files\Programming\Personal\Libraries\Key codes.ah2"

;Often when you want something selected, you'll send down and enter, so this is the variable for that 
select := "{Down}{Enter}"

;Time part of the ekursы link
ekurs_time := 1648746000

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

;Whatsapp and viber
GroupAdd "Whatiber", "WhatsApp"
GroupAdd "Whatiber", "Viber"

;Media
GroupAdd "Media", "Photos"
GroupAdd "Media", "ahk_exe KMPlayer64.exe"

;Autohotkey help
GroupAdd "AutoHotkey_Help", "AutoHotkey Help"
GroupAdd "AutoHotkey_Help", "AutoHotkey v2 Help"




;FUNCTIONS ############################################################################
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

;it literally says what it does
ClickThenGoBack(coordinates)
{
   MouseGetPos &initX, &initY
   Click coordinates
   MouseMove initX, initY
}

;clickthengoback, but clicks as an event for extra fucky things
ClickThenGoBack_Event(coordinates)
{
   MouseGetPos &initX, &initY
   SendEvent "{Click " . coordinates . "}"
   MouseMove initX, initY
} 

;Intakes text that's written on multiple lines. For every line ending character, replaces it with ", ", formatting every line into a 
Format_Table_to_Array()
{
   A_Clipboard := StrReplace(A_Clipboard, "`r`n", '", "') 
   A_Clipboard := "`"" . A_Clipboard . "`""
   MsgBox "Done formatting table to array"
}




;KBMAIN ###############################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;SPECIAL CHARACTERS
;————————————————————

;Long dash
!-::Send "{ASC 0151}"

;Hotstring that turns into a random english word every time
:B0*?:uclanr::
{
   Send "{BackSpace 6}"
   ERW_index := Random(1, 3003)
   Send Eng_randomWords[ERW_index]
}

;Hotstring that turns into a random russian word every time
:B0*?:ilandh::
{
   Send "{BackSpace 6}"
   RRW_index := Random(1, 3000)
   Send Rus_randomWords[RRW_index]
}

;If I try to laugh in russian but my language is set to english, it autosets the language to russian
:*?:[f[f::{LWin Down}{Space}{LWin Up} 
:*?:[[f[f::{LWin Down}{Space}{LWin Up} 


;GLOBAL MANIPULATION
;—————————————————————————————

;Close active window
!Escape::(WinActive("ahk_exe Spotify.exe") ? Send("^+q") : PostMessage("0x0010",,,, "A"))

;Alt enter in down enter
!Enter::Send select

;Easily accessible paste window
^Insert::Send "#v"

;Copy
#Insert::Send "^c"

;Cut
!Insert::Send "^x"

;Cut everything that you've written
^!Insert::Send "^a^x"

;Delete everything that you've written
!Delete::Send "^a{Delete}" 

#HotIf 
;Shift alt w closes a tab
+!w::Send "^w"
;Shift alt a selects all
+!a::Send "^a"
#HotIf 


;INTERACTION
;————————————————————

;Media hotkeys
!SC029::Media_Play_Pause
>^Home::Volume_Up
>^End::Volume_Down
>^Insert::Volume_Mute
>^Delete::Media_Play_Pause
>^PgUp::Media_Prev
>^Pgdn::Media_Next


#HotIf WinActive("ahk_group Messenger")

;Alt + number sends the Unicode for a specific emoji, making that work anywhere. These hotkeys only work in windows that are messengers
;🥺😋🤯😼😎😭🧐😳🤨🤔—💀
!1::Send "{U+1F97A}"
!2::Send "{U+1F60B}"
!3::Send "{U+1F92F}"
!4::Send "{U+1F63C}"
!5::Send "{U+1F60E}"
!6::Send "{U+1F62D}"
!7::Send "{U+1F9D0}"
!8::Send "{U+1F633}"
!9::Send "{U+1F928}"
!0::Send "{U+1F914}"
!=::Send "{U+1F480}"

;Alt + F keys are emojis as well
;😩💜🙄🥴👉👈🤤😈
!F5::Send "{U+1F629}"
!F6::Send "{U+1F49C}"
!F7::Send "{U+1F644}"
!F8::Send "{U+1F974}"
!F9::Send "{U+1F449}{U+1F448}"
!F10::Send "{U+1F924}"
!F11::Send "{U+1F608}"

#HotIf 


;REMAPPING
;——————————————————

;Pure remapping
AppsKey::LCtrl 

;Makes sure the side mouse buttons work as intended ingame, despite their remapping outside of game 
#HotIf WinActive("ahk_group Game")
Volume_Down & MButton::Media_Play_Pause
XButton1::XButton1
XButton2::XButton2
#HotIf




;SPECIAL HOTKEYS ######################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Gives you a place to essentially type a hotstring. Runs what you entered
+!l::
{
   Path_or_Link := InputBox("What do you want to run?", "Runner",, "today").value
   Switch Path_or_Link
   {
      ;WEBSITES
      ;——————————————————

      ;Reddit
      Case "reddit":Run "https://www.reddit.com/notifications"
      ;Instagram
      Case "inst", "instagram":Run "https://www.instagram.com/"
      ;Twitter
      Case "twit", "twitter":Run "https://twitter.com/home"
      ;Eкурсы
      Case "eku":Run "https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . ekurs_time
      ;MyAnimeList
      Case "mal":Run "https://myanimelist.net/profile/Axlefublr"
      ;Metta
      Case "metta":Run "https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4"
      ;Weather
      Case "weather":Run "https://yandex.ru/pogoda/krasnoyarsk"
      ;GitHub
      Case "git":Run "https://github.com/Axlefublr"
      ;Watch movies
      Case "movies":Run "https://watchmovieshd.ru/"
      ;Gogoanime
      Case "gogoanime":Run "https://gogoanime.fi/"
      ;Mvideo
      Case "mvideo":Run "https://www.mvideo.ru/"
      ;Barbershop
      Case "barber":Run "https://b73723.yclients.com/company/89170/menu?o="
      ;Emoji unicodes
      Case "emoji":Run "https://www.alt-codes.net/smiley_alt_codes.php"
      ;Share files
      Case "share files":Run "https://files.fm/"


      ;РАСПИСАНИЕ
      ;————————————————————

      Case "tom", "tomorrow":
         Switch A_WDay 
         {
            Default:Run A_WorkingDir . "\Libraries\Time table\Monday.jpg", "Max"
            Case 2:Run A_WorkingDir . "\Libraries\Time table\Tuesday.jpg", "Max"
            Case 3:Run A_WorkingDir . "\Libraries\Time table\Wednesday.jpg", "Max"
            Case 4:Run A_WorkingDir . "\Libraries\Time table\Thursday.jpg", "Max"
            Case 5:Run A_WorkingDir . "\Libraries\Time table\Friday.jpg", "Max"
         }
      Case "today":
         Switch A_WDay
         {
            Default:Run A_WorkingDir . "\Libraries\Time table\Monday.jpg", "Max"
            Case 3:Run A_WorkingDir . "\Libraries\Time table\Tuesday.jpg", "Max"
            Case 4:Run A_WorkingDir . "\Libraries\Time table\Wednesday.jpg", "Max"
            Case 5:Run A_WorkingDir . "\Libraries\Time table\Thursday.jpg", "Max"
            Case 6:Run A_WorkingDir . "\Libraries\Time table\Friday.jpg", "Max"
         }
      Case "monday":Run A_WorkingDir . "\Libraries\Time table\Monday.jpg", "Max"
      Case "tuesday":Run A_WorkingDir . "\Libraries\Time table\Tuesday.jpg", "Max"
      Case "wednesday":Run A_WorkingDir . "\Libraries\Time table\Wednesday.jpg", "Max"
      Case "thursday":Run A_WorkingDir . "\Libraries\Time table\Thursday.jpg", "Max"
      Case "friday":Run A_WorkingDir . "\Libraries\Time table\Friday.jpg", "Max"


      ;VS CODE
      ;—————————————————

      ;Important files
      Case "syntax":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\syntaxes\ahk.tmLanguage.json"
      Case "keybind":Run "C:\Users\serge\AppData\Roaming\Code\User\keybindings.json"
      Case "settings":Run "C:\Files\Programming\Personal\Backups\settings.json"
      Case "tasks":Run "C:\Users\serge\AppData\Roaming\Code\User\tasks.json"
      Case "extensions":Run "C:\Users\serge\.vscode\extensions"
      Case "package":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\package.json"

      ;Running tasks
      Case "format table to array":Format_Table_to_Array()
      Case "new project tasks":Run A_WorkingDir . "\Scripts\New project tasks.py"
   }
}

;Easy way to reactivate the previous window after using the quick add task of todoist
+!x::
{
   prevActWin := WinGetID("A")
   Send "^!+x"
   if WinWait("ahk_exe Todoist.exe",, 7)
      SetTimer ReactivatePrevActWin, 100 ;Bind by calling the function (works like this if no params)
   
   ;Waits for the quick add task window to disappear and as soon as it does, reactivates the window it was called from
   ReactivatePrevActWin() ;You can actually put it inside of the hotkey
   {
      if !WinActive("ahk_exe Todoist.exe") 
      {
         WinActivate "ahk_id " . prevActWin ;No need to make it a param, since same scope
         SetTimer ReactivatePrevActWin, 0
      }
   }
}

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




;MOUSE KEY INTERACTION ################################################################
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
XButton1 & LButton::(WinActive("ahk_exe Spotify.exe") ? Send(select) : Send("{BackSpace}"))
XButton1 & RButton::Delete

;Far side button with L and R buttons
XButton2 & RButton::PrintScreen
XButton2 & LButton::Enter




;SECTION GESTURES ####################################################################
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
            Case WinActive(" - YouTube") && !WinActive("Watch later") && !WinActive("Subscriptions"):Send "+n"
            Case WinActive("ahk_exe Spotify.exe"):Send "^{Right}"
            Case WinActive("ahk_exe KMPlayer64.exe"):Send "{PgDn}"
            Default:Send "{Media_Next}"
         }
      Case left:
         Switch
         {
            Case WinActive(" - YouTube") && !WinActive("Watch later") && !WinActive("Subscriptions"):Send "+p"
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
               Run A_WorkingDir . "\Test\Tests.ah2"
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
               ;Launches a script that counts how many tracks you've added to a playlist in spotify (meaning, right clicks) if it isn't already running, otherwise exits it by sending a button that is binded to an exitapp in that script
               static Discovery_add_PID := 0
               if ProcessExist(Discovery_add_PID)
                  Send "{Launch_App2}"
               else 
                  Run A_WorkingDir . "\Tools\Discovery add.ah2",,, &Discovery_add_PID
            Case left:
               ;Launches a scripts that counts how many tracks you've selected in spotify (meaning, controlclicks) if it isn't already running, otherwise exits it by sending a button that is binded to an exitapp in that script
               static Playlist_moving_PID := 0
               if ProcessExist(Playlist_moving_PID)
                  Send "{Launch_Mail}"
               else 
                  Run A_WorkingDir . "\Tools\Playlist moving.ahk",,, &Playlist_moving_PID
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
            Case right:Send "{Right}"
            Case left:Send "{Left}"
            Case down:ControlClick "X1434 Y964" ;Clicks the scroll button since shift PgDn doesn't work for some reason
            Case up:Telegram_Search("diary")
         }
      Case WinActive("ahk_group Whatiber"):
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right:Send "{Right}"
            Case left:Send "{Left}"
            Case down:ControlClick "X1878 Y961"
            Case up:return
         }
      Case WinActive("Todoist"): ;_todoist
         Switch
         {
            Default:Send "{Browser_Back}"
            Case right:Todoist_Search("unfinished")
            Case left:Todoist_Search("rappers")
            Case down:Todoist_Search("payments")
            Case up:Todoist_Search("inbox")
         }
   } 
}

#HotIf




;APP SPECIFIC MULTIPLE MAIN ###########################################################
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

;Single press is copy, double press will get current tab's link to clipboard
Volume_Down & XButton1::
{
   KeyWait "XButton1" 
   (KeyWait("XButton1", "D T0.1") ? (Send("{F6}"), Sleep("40"), Send("^c")) : Send("^c"))
}

;Opens a new tab
+!e::Send "^t"

#HotIf


#HotIf WinActive("YouTube") ;_youtube 

;Switch channel
XButton2 & Volume_Down::
{
   ControlClick "X1820 Y133"
   Sleep 300
   Send "{Tab 5}{Enter}"
}   

;Shift n to skip never made sense to begin with
$PgDn::Send "+n"
$PgUp::Send "+p"

#HotIf


#HotIf WinActive("Watch later") || WinActive("Subscriptions") || (WinActive("YouTube") && !WinActive(" - YouTube"))

;Close minimized window 
Escape::ControlClick "X1858 Y665"

;Pop out window
XButton1 & Volume_Down::i

#HotIf


#HotIf WinActive(" - YouTube") && !WinActive("Watch later") && !WinActive("Subscriptions")

;Picture in picture
+!r::ControlClick "X1579 Y73"

;Fullscreen
XButton1 & Volume_Down::f

;Seek farther
$Delete::l
$Insert::j

#HotIf


#HotIf WinActive("ahk_exe Spotify.exe") ;_spotify

;Slows down the selection of stuff in spotify so you don't accidentally drag stuff as often
^LButton::Send "^{Click}"

;Search (meaning filter)
!j::Send "^f"

;Go to liked
!h::Send "+!s"

;Shuffle
Volume_Down & XButton1::Send "^s"

;Like
Volume_Down & XButton2::Send "+!b"

;Playlists
$F1::Send "+!1" 

;Podcasts
$F2::Send "+!2" 

;Currently playing
$F3::Send "+!j"

;Skips
$PgDn::Send "^{Right}"
$PgUp::Send "^{Left}"

;Volume
$Up::Send "{Volume_Up}"
$Down::Send "{Volume_Down}"

;Seek
$Delete::Send "+{Right}"
$Insert::Send "+{Left}"

#HotIf


#HotIf WinActive("Todoist") ;_todoist

;Goes to the project or label or filter or your mom
Todoist_Search(projectToFind) {
   Send "f" . projectToFind . "{Down}{Enter}"
}

;Hotkeys to jump to different projects
$F1::Todoist_Search("inbox") 
$F2::Todoist_Search("rappers") 
$F3::Todoist_Search("unfinished")
$F4::Todoist_Search("payments")
$F5::Todoist_Search("desires")
$F6::Todoist_Search("shopping") 

;Gives the current task an unfinished label and lets you edit its description
+!e::Send " {#}unfinished — " ;Straight up doesn't work if you don't have a space before everything else, thankfully v2 makes it easier to incorporate

;Enter is always down enter
$Enter::Send select

#HotIf




;APP SPECIFIC MESSENGERS ##############################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("Messenger") ;_vk

;Clicks the scroll button bc shift pgdn doesn't work
+PgDn::ControlClick "X1750 Y903"

;Clicks the send button to either start recording or send a voice message
XButton2 & Volume_Down::ControlClick "X1757 Y1014"

;Notifications
XButton1 & Volume_Down::ControlClick "X788 Y126"

;Blank message
^m::Send "&{#}12288;"

;Makes sure the tab can't be closed by shift alt w which is now ctrl w
+!w::return

#HotIf 

;Reminds of the markdown syntax for reddit
#HotIf WinActive("Google Chrome") && !WinActive("Messenger")
^m::MsgBox "* italic *`n** bold **`n~~ strikethrough ~~`n>! spoiler !<`n[embed](link)`n^(superscript)`n`` code inline ```n # BIG TEXT", "MarkDown", "4096"
#HotIf


#HotIf WinActive("Telegram") ;_telegram

;Clicks the search bar for you to search for channels, finds and goes to the channel you want
Telegram_Search(channelToFind)
{
   ControlClick "X422 Y78"
   Send channelToFind . "{Down}{Enter}"
} 

;Shift pgdn scrolls down by clicking the scroll button
+PgDn::ControlClick "X1434 Y964"

;SYNTAX HOTKEYS
;--------------
;Spoiler
^p::Send "^+p" 
;Strikethrough
^n::Send "^+x"

;Clicks the send button to send a voice message
XButton2 & Volume_Down::ClickThenGoBack_Event("1452 1052")

;Press an F key -> go to a channel
$F1::Telegram_Search("diary")
$F2::Telegram_Search("texts")
$F3::Telegram_Search("transfer")
$F4::Telegram_Search("documents")
$F5::Telegram_Search("gallery")
$F6::Telegram_Search("мама")
$F7::Telegram_Search("кристина")
$F8::Telegram_Search("алена")

#HotIf 


#HotIf WinActive("Discord") ;_discord

;Emoji tab 
XButton1 & Volume_Down::Send "^e"

;Gif tab
XButton2 & Volume_Down::Send "^g"

;Reminds of the markdown syntax in discord
^m::MsgBox "__ underline __`n* italic *`n** bold **`n~~ strikethrough ~~`n|| spoiler ||`n`````` code ```````n`` code inline ```n_ nothing _", "Markdown", "4096"

#HotIf




;APP SPECIFIC TECH ####################################################################
;######################################################################################
;######################################################################################
;######################################################################################


#HotIf WinActive("ahk_exe Code.exe") ;_vscode 

;Shift click, but entirely on the mouse
XButton1 & Volume_Down::Send "+{Click}"

;Copies the most important setting files of vs code into the /Backups folder
^!u::Run A_WorkingDir . "\Scripts\Pull vs code settings.py"

;Gets the selected SC code by copying and shows you the key it references
XButton2 & Volume_Down::
{
   tempClip := A_Clipboard
   Send "^c"
   Sleep 100
   MsgBox Name_bySC[A_Clipboard], "Key name by SC key"
   A_Clipboard := tempClip
}

#HotIf


#HotIf WinActive("ahk_exe wps.exe") ;_wps

;Bullets
!6::ControlClick "X568 Y98"

;Save 
+!s::Send "^s"

;Switch between open documents
$!Tab::Send "^{Tab}"

#HotIf


#HotIf WinActive("ahk_exe KMPlayer64.exe")

;Skip opening
$End::Send "{Delete 6}{Right 4}"

;Volume
$Up::Send "{Volume_Up}"
$Down::Send "{Volume_Down}"

#HotIf


#HotIf WinActive("WatchMoviesHD")

;Change volume
Up::Send "{Volume_Up}"
Down::Send "{Volume_Down}"

;Fullscreen
XButton1 & Volume_Down::f

#HotIf


#HotIf WinActive("ahk_exe ScreenClippingHost.exe")

;In the screenshot tool there are three options that can be selected. Selects those options in a rotary manner, depending on direction
ScreenshotOptions(direction)
{
   MouseGetPos &initX, &initY
   static optionYoureOn := 1
   if (direction == "left")
      Switch optionYoureOn
      {
         Case 1:
            Click "959 27"
            optionYoureOn := 3
         Case 2:
            Click "839 28"
            optionYoureOn--
         Case 3:
            Click "897 31"
            optionYoureOn--
      }
   else 
      Switch optionYoureOn
      {
         Case 1:
            Click "897 31"
            optionYoureOn++
         Case 2:
            Click "959 27"
            optionYoureOn++
         Case 3:
            Click "839 28"
            optionYoureOn := 1
      }
   MouseMove initX, initY   
}

;Use the scroll wheel to choose among modes of the screenshot tool
WheelUp::ScreenshotOptions("left")
WheelDown::ScreenshotOptions("right")
MButton::ClickThenGoBack("1017 29") ;Takes a full-screen screenshot

#HotIf




;APP SPECIFIC SINGLE ##################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Search in docs
#HotIf WinActive("ahk_group AutoHotkey_Help")
!j::Send "!s"
#HotIf

;Voice message
#HotIf WinActive("ahk_group Whatiber")
XButton2 & Volume_Down::ControlClick "X1873 Y1047"
#HotIf

;Scroll to go between pics
#HotIf WinActive("ahk_group Media")
WheelUp::Send "{Left}"
WheelDown::Send "{Right}"
#HotIf




;TOOLS ################################################################################
;######################################################################################
;######################################################################################
;######################################################################################


;Gets current cursor's position and opens a gui giving you the options for formatting the parameters for different commands to put them into your Clipboard or to not copy them into your Clipboard at all and just exit the gui
+!f::Run A_WorkingDir . "\Tools\MouseGetPos.ahk"

;Opens an inputbox for you to input how many minutes to wait, plays a sound and opens a msgbox saying the time has passed after it has. Press the same hotkey while the timer is running to see when it will ring and three options: start a new timer, discarding the current one, continue on, exit the timer
#F6::Run A_WorkingDir . "\Tools\Basic timer.ahk"

;Get the root to the exe of the active window and put it into your clipboard
#F5::
{
   windowExe := WinGetProcessPath("A")
   if windowExe
      A_Clipboard := windowExe
}

;Get the name of the active window and put it into your clipboard
#F7::
{
   windowTitle := WinGetTitle("A")
   if windowTitle
      A_Clipboard := windowTitle
}

;Opens a msgbox showing the exact time
+!q::
{
   clock_time := FormatTime(, "H:mm")
   clock_weekDay := FormatTime(, "dddd")
   clock_date := FormatTime(, "d MMMM")
   MsgBox clock_time . "`n" . clock_weekDay . "`n" . clock_date, "Current time", "4096"
}

;Takes a random number out of 1 and 100000, says yes if it's even, no if it's odd
+!z::
{
   coinFlip := Random(1, 100000)
   ((Mod(coinFlip, 2)) ? (result := "Yes") : (result := "No"))
   MsgBox result
}

;Opens an inputbox for you to put in the name of the key to get its SC code into your clipboard
+!k::
{
   Try
      A_Clipboard := SC_byName[InputBox("Name of the key:", "SC code by key name").value]
   Catch Any
      MsgBox "Key not found!", "SC code by key name", "T0.7"
}




;APPS #################################################################################
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
   WinWait winTitle,, 10
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
      WinWait winTitle,, 10
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

;Command prompt
#F9::WindowsApp("ahk_exe cmd.exe", "cmd.exe")

;Python cmd
#F10::WindowsApp("ahk_exe py.exe", "py.exe")

;Monkeytype
<!u::WindowsApp_WinNum("Monkeytype", "4")

;Mail
<!SC033::WindowsApp_WinNum("Gmail", "1")

;Calendar
<!SC034::WindowsApp_WinNum("Google Calendar", "2")

;Calculator
<!SC035::WindowsApp("Calculator", "calc.exe")

;Autohotkey help file
<!SC028::WindowsApp("AutoHotkey Help", "C:\Program Files\Autohotkey\AutoHotkey.chm")

;Autohotkey v2 help file
<!SC027::WindowsApp("AutoHotkey v2 Help", "C:\Program Files\Autohotkey\v2\AutoHotkey.chm")

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

   if WinExist("ahk_group Game")
      MinMax("ahk_group Game")
   else
      (mainAppsExist ? (WinClose(chrome), WinClose(todoist), WinClose(telegram), WinClose(vscode), WinClose(discord), ifWinClose("Monkeytype"), ifWinClose("Google Calendar"), ifWinClose("AutoHotkey Help"), ifWinClose("AutoHotkey v2 Help"), WinActivate(spotify)) 
      : (ifWinClose(steam), ifRunApp(chrome, chrome_exe), ifRunApp(todoist, todoist_exe), ifRunApp("Telegram", telegram_exe), ifRunApp(vscode, vscode_exe), ifRunApp(discord, discord_exe), ifRunApp(spotify, spotify_exe)))
}


#HotIf !WinActive("ahk_group Game")

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
