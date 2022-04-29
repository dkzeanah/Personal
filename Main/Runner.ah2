+!l:: {
   O_Runner := InputBox("What do you want to run?", "Runner")
   if O_Runner.Result = "Cancel" 
      return
   Switch O_Runner.Value {

      ;WEBSITES
      ;——————————————————

      ;Reddit
      Case "reddit":F_RunLink("https://www.reddit.com/notifications")
      ;Instagram
      Case "inst", "instagram":F_RunLink("https://www.instagram.com/")
      ;Twitter
      Case "twit", "twitter":F_RunLink("https://twitter.com/home")
      ;Eкурсы
      Case "eku":F_RunLink("https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . TimeTable.tmt_Month())
      ;MyAnimeList
      Case "mal":F_RunLink("https://myanimelist.net/profile/Axlefublr")
      ;Metta
      Case "metta":F_RunLink("https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4")
      ;Weather
      Case "weather":F_RunLink("https://yandex.ru/pogoda/krasnoyarsk")
      ;Watch movies
      Case "movies":F_RunLink("https://watchmovieshd.ru/")
      ;Gogoanime
      Case "gogoanime":F_RunLink("https://gogoanime.fi/")
      ;Mvideo
      Case "mvideo":F_RunLink("https://www.mvideo.ru/")
      ;Steam keys
      Case "zaka", "zakazaka":F_RunLink("https://zaka-zaka.com/")
      ;Barbershop
      Case "barber":F_RunLink("https://b73723.yclients.com/company/89170/menu?o=")
      ;Emoji unicodes
      Case "emoji":F_RunLink("https://www.alt-codes.net/smiley_alt_codes.php")
      ;Share files
      Case "share files":F_RunLink("https://files.fm/")


      ;РАСПИСАНИЕ
      ;————————————————————

      Case "tom", "tomorrow":
         Switch A_WDay {
            Default:TimeTable.tmt_Day("Monday")
            Case 2:TimeTable.tmt_Day("Tuesday")
            Case 3:TimeTable.tmt_Day("Wednesday")
            Case 4:TimeTable.tmt_Day("Thursday")
            Case 5:TimeTable.tmt_Day("Friday")
         }
      Case "today":
         Switch A_WDay {
            Default:TimeTable.tmt_Day("Monday")
            Case 3:TimeTable.tmt_Day("Tuesday")
            Case 4:TimeTable.tmt_Day("Wednesday")
            Case 5:TimeTable.tmt_Day("Thursday")
            Case 6:TimeTable.tmt_Day("Friday")
         }
      Case "week":F_RunLink(TimeTable.tmt_Full)
      Case "monday":TimeTable.tmt_Day("Monday")
      Case "tuesday":TimeTable.tmt_Day("Tuesday")
      Case "wednesday":TimeTable.tmt_Day("Wednesday")
      Case "thursday":TimeTable.tmt_Day("Thursday")
      Case "friday":TimeTable.tmt_Day("Friday")


      ;VS CODE
      ;—————————————————

      Case "syntax":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\syntaxes\ahk.tmLanguage.json"
      Case "keybind":Run "C:\Users\serge\AppData\Roaming\Code\User\keybindings.json"
      Case "settings":Run "C:\Users\serge\AppData\Roaming\Code\User\settings.json"
      Case "tasks":Run "C:\Users\serge\AppData\Roaming\Code\User\tasks.json"
      Case "extensions":Run "C:\Users\serge\.vscode\extensions"
      Case "package":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\package.json"


      ;TASKS
      ;———————————————————

      Case "new project tasks":Run A_WorkingDir . "\Scripts\New project tasks.py"
      Case "click counter":Run A_WorkingDir . "\Tools\Click counter.ah2"
      Case "discovery add":Run A_WorkingDir . "\Tools\Discovery add.ah2"
      Case "add to playlist", "atp", "ytp":Run A_WorkingDir . "\Tools\Add to Playlist.ah2"
      Case "format table to array":Runner.nur_FormatTableToArray()
      Case "startup":Runner.nur_StartupRun()
      Case "coin flip":Runner.nur_CoinFlip()
      Case "converter", "conv":Runner.nur_Converter()
      Case "ytm":YTMusic.ytm_LinkConverter()
      Case "lib", "libload":Runner.nur_LibLoad()
      Case "artists count":Runner.nur_ArtistsCount()


      ;GITHUB
      ;————————————————————
      
      Case "gitpage", "gitfile", "gitlink":Runner.nur_GitPage("paste")
      Case "git":Runner.nur_GitPage("run")
      Case "github":F_RunLink("https://github.com/Axlefublr")

      ;Github nicknames
      Case "git Micha":F_ClipSend("@Micha-ohne-el")


      ;AHK 
      ;————————————————————————————————

      ;Tutorials
      Case "ahk yt startup":F_ClipSend("https://youtu.be/vjQIbagvkcs")
      Case "ahk yt arrow":F_ClipSend("https://youtu.be/nSTL3KND25c")

      ;Told often
      Case "ahk directories v1":F_ClipSend(Runner.nur_Directories_v1)


      ;MEMES
      ;————————————

      ;My source is that I made it the fuck up
      Case "I made it the fuck up", "I made it up":F_ClipSend("https://www.youtube.com/watch?v=r7l0Rq9E8MY")
      ;Funny mic
      Case "funny mic":F_ClipSend("https://www.youtube.com/watch?v=jfbKJy_ZuIU")
      ;Delay lama vs meowsynth
      Case "delay lama":F_ClipSend("https://www.youtube.com/watch?v=Np4iG7-se7I")
      ;I quickly became homophobic
      Case "I quickly became homophobic":F_ClipSend("https://www.youtube.com/watch?v=m2ksGuqf8eo")
      ;If you design a quest
      Case "if you design a quest":F_ClipSend("https://www.youtube.com/watch?v=chn0ggv9TdY")
      ;Zoro is racist 100% not even imo
      Case "zoro is racist":F_ClipSend("https://www.youtube.com/watch?v=kb_udP2ZeF8")
   }
}

;Easy way to reactivate the previous window after using the quick add task of todoist
+!x:: {
   prevActWin := WinGetID("A")
   Send "^+!x"
   (WinWait("ahk_exe Todoist.exe",, 7) 
      ? SetTimer(ReactivatePrevActWin, 200) : "")
   
   ;Waits for the quick add task window to disappear and as soon as it does, reactivates the window it was called from
   ReactivatePrevActWin() => (
      (!WinActive("ahk_exe Todoist.exe"))
         ? (WinActivate("ahk_id " . prevActWin),
            SetTimer(ReactivatePrevActWin, 0)) : ""
   ) 
}
