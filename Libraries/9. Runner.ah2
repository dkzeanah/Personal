Class C_Runner {

   ;Takes a random number out of 1 and 100000, says yes if it's even, no if it's odd
   nur_CoinFlip() {
      coinFlip := Random(1, 100000),
      ((Mod(coinFlip, 2)) 
         ? (result := "Yes") 
         : (result := "No")),
      MsgBox(result)
   }

   ;Takes a multiline text and turns every line into a key in an array
   nur_FormatTableToArray() {
      A_Clipboard := "`"" . StrReplace(A_Clipboard, "`r`n", '", "') . "`"",
      MsgBox("Done formatting table to array")
   }

   ;Select a file to run on startup
   nur_StartupRun() {
      selectedFile := FileSelect("S", A_WorkingDir),
      SplitPath(selectedFile, &fileName),
      FileCreateShortcut(selectedFile, A_AppData . "\Microsoft\Windows\Start Menu\Programs\Startup\" . fileName . ".lnk")
   }

   nur_Converter() {
      O_Converter := InputBox("To convert: ", "Currency converter")
      if O_Converter.Result == "Cancel"
         return

      R_Currencies := ["r", "d"]
      for index in R_Currencies {
         num := StrReplace(O_Converter.Value, index, "")
         if num != O_Converter.Value {
            currency := index
            break
         }
      }

      ((currency == "r")
         ? (currency := "rubles", oppCurrency := "dollars")
      : (currency == "d")
         ? (currency := "dollars", oppCurrency := "rubles") : "")

      F_RunLink("https://www.google.com/search?q=" . num . "+" . currency . "+in+" . oppCurrency . "&oq=" . num . "+" . currency . "+in+" . oppCurrency . "&aqs=chrome..69i57.4182j1j9&sourceid=chrome&ie=UTF-8")
   }

   ;Clicks on all the libraries consequentially, loading them into Intellisense
   nur_LibLoad() {
      D_Libraries := Map(
         "1. Base",                         "X194 Y262",
         "2. KeyCodes",                     "X194 Y287",
         "3. Press",                        "X194 Y315",
         "4. RandomWords",                  "X194 Y346",
         "5. Win",                          "X194 Y370",
         "6. Global",                       "X194 Y396",
         "7. App",                          "X194 Y428",
         "8. Script",                       "X200 Y453",
         "9. Runner",                       "X209 Y475"
      )

      for key, value in D_Libraries 
         ControlClick(value, "ahk_exe Code.exe"), WinWait(key . ".ah2 - Personal - Visual Studio Code")
      Base.bsd_CloseTab()
   }

   ;Gets the github link to a file of your choosing
   nur_GitPage(doWhat) {

      programmingPath := "C:\Files\Programming\"

      fullPath := FileSelect("S", programmingPath)

      if !fullPath 
         return
      faultyLink := PathToLink(fullPath)

      ;Formats a full file path into a relative one
      PathToLink(fullPath) => (
         ;Removes the start of the path, since it's irrelevant in the link that just uses the project folder
         relativePath := StrReplace(fullPath, programmingPath, ""),
         ;Links use forward slashes while paths use backslashes
         relativePath := StrReplace(relativePath, "\", "/"),
         ;Spaces are replaced with %20 in links
         relativePath := StrReplace(relativePath, " ", "%20")
      )

      R_ProjectFolders := ["Python-tutorials/", "Other/", "Personal/"]

      for index in R_ProjectFolders {
         noIndex := StrReplace(faultyLink, index, "")
         if noIndex != faultyLink {
            workingLink := index . "blob/main/" . noIndex
            break
         }
      }

      fullLink := "https://github.com/Axlefublr/" . workingLink

      Switch doWhat {
         Case "run":  this.F_RunLink(fullLink)
         Case "paste":F_ClipSend(fullLink, "")
      }
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