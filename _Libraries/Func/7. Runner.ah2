Class C_Runner {

   ;Sends an emoji using its unicode
   nur_Emoji(emojiName) {
      Send("{" . D_KeyCodes_In[emojiName] . "}")
   }

   ;Sends a random word from your specified array
   nur_RandomWord(whichArray) {
      Send("{BackSpace 6}")
      , i := Random(1, 3000)
      , Send(whichArray[i])
   }

   ;Takes a random number out of 1 and 100000, says yes if it's even, no if it's odd
   nur_CoinFlip() {
      coinFlip := Random(1, 100000)
      , ((Mod(coinFlip, 2)) 
         ? (result := "Yes") 
         : (result := "No"))
      , MsgBox(result)
   }

   ;Takes a multiline text and turns every line into a key in an array
   nur_FormatTableToArray() {
      A_Clipboard := "`"" . StrReplace(A_Clipboard, "`r`n", '", "') . "`""
      , MsgBox("Done formatting table to array",, "T1")
   }

   ;Select a file to run on startup
   nur_StartupRun() {
      selectedFile := FileSelect("S", A_WorkingDir)
      , SplitPath(selectedFile, &fileName)
      , FileCreateShortcut(selectedFile, A_AppData . "\Microsoft\Windows\Start Menu\Programs\Startup\" . fileName . ".lnk")
   }

   nur_Converter(currency, num) {
      
      ((currency == "r")
         ? (currency := "rubles", oppCurrency := "dollars")
      : (currency == "d")
         ? (currency := "dollars", oppCurrency := "rubles") : "")

      , RunLink("https://www.google.com/search?q=" . num . "+" . currency . "+in+" . oppCurrency . "&oq=" . num . "+" . currency . "+in+" . oppCurrency . "&aqs=chrome..69i57.4182j1j9&sourceid=chrome&ie=UTF-8")
   }

   ;Clicks on all the libraries consequentially, loading them into Intellisense
   nur_Lib() {
      D_Libraries := Map(
         "1. Base",                         "X204 Y177",
         "2. Press",                        "X204 Y205",
         "3. Global",                       "X204 Y233",
         "4. Win",                          "X204 Y255",
         "5. App",                          "X204 Y286",
         "6. Script",                       "X204 Y310",
         "7. Runner",                       "X204 Y338"
      )
      
      for key, value in D_Libraries 
         ControlClick(value, "ahk_exe Code.exe"), WinWait(key . ".ah2 - Personal - Visual Studio Code")
      Base.bsd_CloseTab()
   }

   nur_Load() {

      nur_Load_ColorPreset()
      , nur_Load_ColorTest()
      , nur_Load_Docs()
      , nur_Load_tmLanguage(A_WorkingDir "\Backups\ahk.tmLanguage.json")
      , nur_Load_tmLanguage(A_WorkingDir "\..\Other\Libraries v2\Ahk code coloring\tmLanguage.json")
      , nur_Load_AhkSnippets()

      nur_Load_ColorPreset() => (
         ;Get the whole settings file
         settingsJson := FileOpen(A_AppData . "\Code\User\settings.json", "r"),
         settingsJson.Seek(, 0),
         text := settingsJson.Read(),
         settingsJson.Close(),

         ;Find the color preset part
         regex := "ms)`"editor.tokenColorCustomizations`":.*`"fontStyle`": `".*`"\s*}\s*}\s*]\s*},",
         RegexMatch(text, regex, &colorSettings),

         ;Write it over the existing color settings preset
         colorPreset := FileOpen(A_WorkingDir . "\..\Other\Libraries v2\Ahk code coloring\color settings preset.txt", "w"),
         colorPreset.Write(colorSettings[0]),
         colorPreset.Close()
      )

      nur_Load_ColorTest() => (
         coloringPersonal := A_WorkingDir . "\Test\coloring.ah2",
         coloringOther := A_WorkingDir . "\..\Other\Libraries v2\Ahk code coloring\coloring book.ah2",
         FileCopy(coloringPersonal, coloringOther, 1)
      )

      nur_Load_Docs() => (
         docsPersonal := A_WorkingDir . "\Docs\syntax docs.md",
         docsOther := A_WorkingDir . "\..\Other\Libraries v2\Ahk code coloring\documentation.md",
         FileCopy(docsPersonal, docsOther, 1)
      )

      nur_Load_tmLanguage(where) => (
         tmLanguageOrigin := "C:\Users\serge\.vscode\extensions\mark-wiemer.vscode-autohotkey-plus-plus-2.8.1\syntaxes\ahk.tmLanguage.json",
         FileCopy(tmLanguageOrigin, where, 1)
      )

      nur_Load_AhkSnippets() => (
         AhkSnippetsOrigin := A_AppData . "\Code\User\snippets\ahk.json",
         AhkSnippetsOther := A_WorkingDir . "\..\Other\Files\ahk.json",
         FileCopy(AhkSnippetsOrigin, AhkSnippetsOther, 1)
      )

   }

   ;Gets the github link to a file of your choosing
   nur_GitLink(doWhat) {

      programmingPath := "C:\Files\Programming\"

      , fullPath := FileSelect("S", programmingPath)

      if !fullPath 
         return
      faultyLink := PathToLink(fullPath)

      ;Formats a full file path into a relative one
      , PathToLink(fullPath) => (
         ;Removes the start of the path, since it's irrelevant in the link that just uses the project folder
         relativePath := StrReplace(fullPath, programmingPath, ""),
         ;Links use forward slashes while paths use backslashes
         relativePath := StrReplace(relativePath, "\", "/"),
         ;Spaces are replaced with %20 in links
         relativePath := StrReplace(relativePath, " ", "%20")
      )

      , R_ProjectFolders := ["Python-tutorials/", "Other/", "Personal/"]

      for index in R_ProjectFolders {
         noIndex := StrReplace(faultyLink, index, "")
         if noIndex != faultyLink {
            workingLink := index . "blob/main/" . noIndex
            break
         }
      }

      fullLink := "https://github.com/Axlefublr/" . workingLink

      Switch doWhat {
         Case "run":  RunLink(fullLink)
         Case "paste":ClipSend(fullLink, "")
      }
   }

   nur_ArtistsCount() {
      ;Gets the artists into the clipboard
      prevClip := A_Clipboard
      , Base.bsd_SelectAll(), Base.bsd_Cut()

      ;Counts the amount of artists
      , Artists := StrReplace(A_Clipboard, "`r`n", "`r`n",, &ArtistsCount)

      ;Possible last number of artists, that could be in the artists text
      , R_PossibleNumbers := [-8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8]
      
      ;Removes the possible numbers that might be in the text 
      for index in R_PossibleNumbers {
         Artists := StrReplace(Artists, " " . ArtistsCount+index)
      }
      A_Clipboard := Artists . " " . ArtistsCount+1

      ;Pastes them back, reverts your previous clipboard
      , Base.bsd_Paste()
      , SetTimer(() => A_Clipboard := prevClip, -200)
   }

   nur_PropServe(flag, linkName) {
      propName := StrLower(linkName)
      , propName := StrReplace(propName, " ", "_")
      , ((flag == "paste")
         ? ClipSend(Links.%propName%)
      : (flag == "open") 
         ? RunLink(Links.%propName%) : "")
   }

   nur_MorseCode() {
      D_Morse_To := Map(
         "a", "·-  ",
         "b", "-···  ",
         "c", "-·-·  ",
         "d", "-··  ",
         "e", "·  ", 
         "f", "··-·  ", 
         "g", "--·  ", 
         "h", "····  ", 
         "i", "··  ", 
         "j", "·---  ", 
         "k", "-·-  ", 
         "l", "·-··  ", 
         "m", "--  ", 
         "n", "-·  ", 
         "o", "---  ", 
         "p", "·--·  ", 
         "q", "--·-  ", 
         "r", "·-·  ", 
         "s", "···  ", 
         "t", "-  ", 
         "u", "··-  ", 
         "v", "···-  ", 
         "w", "·--  ", 
         "x", "-··-  ", 
         "y", "-·--  ", 
         "z", "--··  ", 
         " ", "    ", 
         "`n", "`n",
         "`t", "`t",
         "0", "-----  ", 
         "1", "·----  ", 
         "2", "··---  ", 
         "3", "···--  ", 
         "4", "····-  ", 
         "5", "·····  ", 
         "6", "-····  ", 
         "7", "--···  ", 
         "8", "---··  ", 
         "9", "----·  "
      )

      text := StrLower(A_Clipboard)
      , noSpecialText := RegexReplace(text, "[^\w\d\s]+")
      , R_noSpecialSymbols := StrSplit(noSpecialText)
      for value in R_noSpecialSymbols
         try morseText .= D_Morse_To[value]
      ClipSend(morseText)
   }
   
   nur_MemeFolder(fullPath) {
      Run(fullPath), Win.niw_CloseOnceInactive(fullPath . " ahk_exe explorer.exe")
   }

   nur_LastTrack(param, text := "") {
      file := FileOpen(A_WorkingDir . "\Files\Innit\Last track.txt", param)
      , file.Seek(, 0)
      , ((param = "w") 
         ? file.Write(text)
      : (param = "r")
         ? MsgBox(file.Read()) : "")
      , file.Close()
   }

   nur_LastDisc(param, text := "") {
      file := FileOpen(A_WorkingDir . "\Files\Innit\Last discovery.txt", param)
      , file.Seek(, 0)
      , ((param = "w") 
         ? file.Write(text)
      : (param = "r")
         ? MsgBox(file.Read()) : "")
      , file.Close()
   }

   nur_RegexStringPopper() {

      #Include "%A_ScriptDir%\..\_Libraries\Var\4. Regex string.ah2"
      if !R_Array.Length {
         MsgBox("Regex array is empty",, "T1")
         return 
      }

      Loop R_Array.Length {
         Send(R_Array[-1] . "{Enter}")
         , R_Array.Pop()
         , Sleep(500)
      }
      MsgBox("Done!")
   }

}
Runner := C_Runner()

Class C_TimeTable {

   tmt_Day(weekDay) {
      Run A_WorkingDir . "\Files\Pictures\Time table\" . weekDay . ".jpg", "Max"
   }

   tmt_Full => "https://edu.sfu-kras.ru/timetable?group=%D0%98%D0%9A21-08%D0%91+%28%D0%BF%D0%BE%D0%B4%D0%B3%D1%80%D1%83%D0%BF%D0%BF%D0%B0+2%29"

   
   tmt_Month() {
      ;Time part of the ekursы link
      Switch A_MMMM {
         Case "April":ekursTime := 1648746000
         Case "May":ekursTime := 1651338000
         Case "June":ekursTime := 1654016400
         Case "July":ekursTime := 1656608400
         Case "August":ekursTime := 1659286800
         Case "September":ekursTime := 1661965200
         Case "October":ekursTime := 1664557200
         Case "November":ekursTime := 1667235600
         Case "December":ekursTime := 1669827600
      }
      return ekursTime
   }
}
TimeTable := C_TimeTable()