+!l:: {
   O_RunBox := InputBox("What do you want to run?", "Runner")
   if O_RunBox.Result = "Cancel" 
      return
   val := O_RunBox.Value
   Switch val {

      ;WEBSITES
      ;——————————————————

      Case "reddit":                 RunLink("https://www.reddit.com/notifications")
      Case "inst", "instagram":      RunLink("https://www.instagram.com/")
      Case "twit", "twitter":        RunLink("https://twitter.com/home")
      Case "eku":                    RunLink("https://e.sfu-kras.ru/calendar/view.php?view=month&time=" . TimeTable.tmt_Month())
      Case "mal":                    RunLink("https://myanimelist.net/profile/Axlefublr")
      Case "metta":                  RunLink("https://mettalife.ru/pl/my?gcmes=5779290672&gcmlg=-4")
      Case "weather":                RunLink("https://yandex.ru/pogoda/krasnoyarsk")
      Case "movies":                 RunLink("https://watchmovieshd.ru/")
      Case "gogoanime":              RunLink("https://gogoanime.fi/")
      Case "mvideo":                 RunLink("https://www.mvideo.ru/")
      Case "zaka", "zakazaka":       RunLink("https://zaka-zaka.com/")
      Case "barber":                 RunLink("https://b73723.yclients.com/company/89170/menu?o=")
      Case "emoji":                  RunLink("https://www.alt-codes.net/smiley_alt_codes.php")
      Case "share files":            RunLink("https://files.fm/")
      Case "bcs", "better call Saul":RunLink("https://watchmovieshd.ru/series/better-call-saul-82zxv/6-3")
      Case "regex":                  RunLink("https://regex101.com/")


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
      Case "week":RunLink(TimeTable.tmt_Full)
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

      Case "new project tasks":    Run A_WorkingDir . "\Scripts\New project tasks.py"
      Case "click counter":        Run A_WorkingDir . "\Tools\Click counter.ah2"
      Case "discovery add":        Run A_WorkingDir . "\Tools\Discovery add.ah2"
      Case "atp":                  Run A_WorkingDir . "\Tools\Add to Playlist.ah2"
      Case "one piece download":   Run A_WorkingDir . "\Tools\Download One Piece.ah2"
      Case "format table to array":Runner.nur_FormatTableToArray()
      Case "startup":              Runner.nur_StartupRun()
      Case "coin flip":            Runner.nur_CoinFlip()
      Case "ytm":                  YTMusic.ytm_LinkConverter()
      Case "lib":                  Runner.nur_LibLoad()
      Case "artists count":        Runner.nur_ArtistsCount()


      ;GITHUB
      ;————————————————————
      
      Case "gitlink":Runner.nur_GitLink("paste")
      Case "gitopen":Runner.nur_GitLink("run")
      Case "github":RunLink("https://github.com/Axlefublr")

      Case "gitlink runner":ClipSend("https://github.com/Axlefublr/Personal/blob/main/Main/Runner.ah2")

      ;Github nicknames
      Case "github Micha":ClipSend("@Micha-ohne-el")


      ;AHK 
      ;————————————————————————————————

      Case "ahk yt run on reboot":ClipSend("https://youtu.be/vjQIbagvkcs")
      Case "ahk yt arrow":ClipSend("https://youtu.be/nSTL3KND25c")


      ;MEMES
      ;————————————

      ;My source is that I made it the fuck up
      Case "I made it the fuck up", "I made it up":ClipSend("https://www.youtube.com/watch?v=r7l0Rq9E8MY")
      ;Funny mic
      Case "funny mic":ClipSend("https://www.youtube.com/watch?v=jfbKJy_ZuIU")
      ;Delay lama vs meowsynth
      Case "delay lama":ClipSend("https://www.youtube.com/watch?v=Np4iG7-se7I")
      ;I quickly became homophobic
      Case "I quickly became homophobic":ClipSend("https://www.youtube.com/watch?v=m2ksGuqf8eo")
      ;If you design a quest
      Case "if you design a quest":ClipSend("https://www.youtube.com/watch?v=chn0ggv9TdY")
      ;Zoro is racist 100% not even imo
      Case "zoro is racist":ClipSend("https://www.youtube.com/watch?v=kb_udP2ZeF8")


      Default:
      Switch {
         Case RegexMatch(val, "(?<=r )\d+", &num):Runner.nur_Converter("r", num[0])
         Case RegexMatch(val, "(?<=d )\d+", &num):Runner.nur_Converter("d", num[0])
      }         
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
