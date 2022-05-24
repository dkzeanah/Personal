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
            Case 2: TimeTable.tmt_Day("Tuesday")
            Case 3: TimeTable.tmt_Day("Wednesday")
            Case 4: TimeTable.tmt_Day("Thursday")
            Case 5: TimeTable.tmt_Day("Friday")
         }
      Case "today":
         Switch A_WDay {
            Default:TimeTable.tmt_Day("Monday")
            Case 3: TimeTable.tmt_Day("Tuesday")
            Case 4: TimeTable.tmt_Day("Wednesday")
            Case 5: TimeTable.tmt_Day("Thursday")
            Case 6: TimeTable.tmt_Day("Friday")
         }
      Case "week":     RunLink(TimeTable.tmt_Full)
      Case "monday":   TimeTable.tmt_Day("Monday")
      Case "tuesday":  TimeTable.tmt_Day("Tuesday")
      Case "wednesday":TimeTable.tmt_Day("Wednesday")
      Case "thursday": TimeTable.tmt_Day("Thursday")
      Case "friday":   TimeTable.tmt_Day("Friday")


      ;VS CODE
      ;—————————————————

      Case "syntax":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\syntaxes\ahk.tmLanguage.json"
      Case "keybind":Run "C:\Users\serge\AppData\Roaming\Code\User\keybindings.json"
      Case "settings":Run "C:\Users\serge\AppData\Roaming\Code\User\settings.json"
      Case "tasks":Run "C:\Users\serge\AppData\Roaming\Code\User\tasks.json"
      Case "extensions":Run "C:\Users\serge\.vscode\extensions"
      Case "package":Run "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\package.json"
      Case "colors":Run A_WorkingDir . "\..\Other\Libraries v2\Ahk code coloring\color settings in settings.json.txt"


      ;TASKS
      ;———————————————————

      Case "new project tasks":    Run A_WorkingDir . "\Scripts\New project tasks.py"
      Case "click counter":        Run A_WorkingDir . "\Tools\Click counter.ah2"
      Case "discovery add":        Run A_WorkingDir . "\Tools\Discovery add.ah2"
      Case "atp":                  Run A_WorkingDir . "\Tools\Add to Playlist.ah2"
      Case "one piece download":   Run A_WorkingDir . "\Tools\One piece download.ah2"
      Case "format table to array":Runner.nur_FormatTableToArray()
      Case "startup":              Runner.nur_StartupRun()
      Case "coin flip":            Runner.nur_CoinFlip()
      Case "ytm":                  YTMusic.ytm_LinkConverter()
      Case "lib":                  Runner.nur_Lib()
      Case "load":                 Runner.nur_Load()
      Case "morse", "morse code":  Runner.nur_MorseCode()
      Case "regex string popper":  Runner.nur_RegexStringPopper()


      ;FOLDERS
      ;————————————————————————————————

      Case "sounds":Runner.nur_MemeFolder(Win.Sounds)
      Case "pictures":Runner.nur_MemeFolder(Win.Pictures)
      Case "one piece":Win.niw_App_Folders("C:\Files\Pictures\One Piece")

      ;NOTEPADS
      ;————————————————————————————————

      Case "lkpl r":Runner.nur_LastTrack("r")
      Case "dsc r":Runner.nur_LastDisc("r")


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
         Case RegexMatch(val, "(?<=(^r ))\d+", &num):try Runner.nur_Converter("r", num[0])
         Case RegexMatch(val, "(?<=(^d ))\d+", &num):try Runner.nur_Converter("d", num[0])
         Case RegexMatch(val, "(?<=(^p )).+", &linkName):try Runner.nur_PropServe("paste", linkName[0])
         Case RegexMatch(val, "(?<=(^o )).+", &linkName):try Runner.nur_PropServe("open", linkName[0])
         Case RegexMatch(val, "(?<=(^s )).+", &sound):try SoundPlay(A_WorkingDir "\Files\Sounds\" sound[0] ".mp3")
         Case RegexMatch(val, "(?<=(^lkpl w )).+", &text):try Runner.nur_LastTrack("w", text[0])
         Case RegexMatch(val, "(?<=(^dsc w )).+", &text):try Runner.nur_LastDisc("w", text[0])
         Case RegexMatch(val, "(run|copy|folder) (.*)", &match):try FileSearch(match[1], match[2])
      }         
   }
}

;Easy way to reactivate the previous window after using the quick add task of todoist
+!x:: {
   prevActWin := WinGetID("A")
   Send("^+!x")
   , WinWaitActive("ahk_exe Todoist.exe")
   , WinWaitNotActive("ahk_exe Todoist.exe")
   , WinActivate("ahk_id" prevActWin)
}
