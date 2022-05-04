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
      , MsgBox("Done formatting table to array")
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
   nur_LibLoad() {
      D_Libraries := Map(
         "1. Base",                         "X196 Y149",
         "2. KeyCodes",                     "X196 Y178",
         "3. Press",                        "X196 Y203",
         "4. RandomWords",                  "X196 Y232",
         "5. Win",                          "X196 Y257",
         "6. Global",                       "X196 Y285",
         "7. App",                          "X196 Y313",
         "8. Script",                       "X196 Y343",
         "9. Runner",                       "X196 Y368"
      )
      
      for key, value in D_Libraries 
         ControlClick(value, "ahk_exe Code.exe"), WinWait(key . ".ah2 - Personal - Visual Studio Code")
      Base.bsd_CloseTab()
      , Run(A_WorkingDir . "\Scripts\Pull vs code settings.py")
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
         Case "run":  this.RunLink(fullLink)
         Case "paste":ClipSend(fullLink, "")
      }
   }

   nur_ArtistsCount() {
      ;Gets the artists into the clipboard
        prevClip := A_Clipboard
      , Base.bsd_SelectAll(), Base.bsd_Cut()
      , Sleep(60)

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
      , propName:= StrReplace(propName, " ", "_")
      , ((flag == "paste")
         ? ClipSend(Links.%propName%)
      : (flag == "open") 
         ? RunLink(Links.%propName%) : "")
   }

   nur_MorseCode() {
      D_Morse_To := Map(
         "a", "· -   ",
         "b", "- · · ·   ",
         "c", "- · - ·   ",
         "d", "- · ·   ",
         "e", "·   ", 
         "f", "· · - ·   ", 
         "g", "- - ·   ", 
         "h", "· · · ·   ", 
         "i", "· ·   ", 
         "j", "· - - -   ", 
         "k", "- · -   ", 
         "l", "· - · ·   ", 
         "m", "- -   ", 
         "n", "- ·   ", 
         "o", "- - -   ", 
         "p", "· - - ·   ", 
         "q", "- - · -   ", 
         "r", "· - ·   ", 
         "s", "· · ·   ", 
         "t", "-   ", 
         "u", "· · -   ", 
         "v", "· · · -   ", 
         "w", "· - -   ", 
         "x", "- · · -   ", 
         "y", "- · - -   ", 
         "z", "- - · ·   ", 
         " ", "     ", 
         "`n", "`n ",
         "`t", "`t ",
         "0", "- - - - -   ", 
         "1", "· - - - -   ", 
         "2", "· · - - -   ", 
         "3", "· · · - -   ", 
         "4", "· · · · -   ", 
         "5", "· · · · ·   ", 
         "6", "- · · · ·   ", 
         "7", "- - · · ·   ", 
         "8", "- - - · ·   ", 
         "9", "- - - - ·   "
      )

      text := StrLower(A_Clipboard)
      , noSpecialText := RegexReplace(text, "[^\w\d\s]+")
      , R_noSpecialSymbols := StrSplit(noSpecialText)
      for value in R_noSpecialSymbols
         try morseText .= D_Morse_To[value]
      ClipSend(morseText)
   }
}
Runner := C_Runner()

Class C_TimeTable {

   tmt_Day(weekDay) {
      Run A_WorkingDir . "\Files\Time table\" . weekDay . ".jpg", "Max"
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