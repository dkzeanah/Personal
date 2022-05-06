+!l:: {
   O_RunBox := InputBox("What do you want to run?", "Runner")
   if O_RunBox.Result = "Cancel" 
      return
   val := O_RunBox.Value
   Switch val, 0 {

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
      Case "morse", "morse code":  Runner.nur_MorseCode()


      ;FOLDERS
      ;————————————————————————————————

      Case "sounds":Runner.nur_MemeFolder(Win.Sounds)


      ;GITHUB
      ;————————————————————
      
      Case "gitlink":Runner.nur_GitLink("paste")
      Case "gitopen":Runner.nur_GitLink("run")
      Case "github":RunLink("https://github.com/Axlefublr")

      ;Github nicknames
      Case "github Micha":ClipSend("@Micha-ohne-el")
      Case "github reiwa":ClipSend("@rbstrachan")


      Default:
      Switch {
         Case RegexMatch(val, "(?<=r )\d+", &num):Runner.nur_Converter("r", num[0])
         Case RegexMatch(val, "(?<=d )\d+", &num):Runner.nur_Converter("d", num[0])
         Case RegexMatch(val, "(?<=p ).+", &linkName):try Runner.nur_PropServe("paste", linkName[0])
         Case RegexMatch(val, "(?<=o ).+", &linkName):try Runner.nur_PropServe("open", linkName[0])
         Case RegexMatch(val, "(?<=s ).+", &sound):try SoundPlay(A_WorkingDir "\Files\Sounds\" sound[0] ".mp3")
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
