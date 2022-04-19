Class C_Runner {

   ;Runs the link and makes sure the browser is activated
   nur_RunLink(link) {
      Run(link), WinActivate("Google Chrome")
   }

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

   ;Googles how many rubles are there in a specified amount of dollars
   nur_DollarToRub() {
      O_DollarToRub := InputBox("How much in dollars?: ", "Currency converter")
      if O_DollarToRub.Result != "Cancel"
         this.nur_RunLink("https://www.google.com/search?q=" . O_DollarToRub.Value . "+dollars+in+rubles&oq=" . O_DollarToRub.Value . "+dollars+in+rubles&aqs=chrome..69i57.5947j0j7&sourceid=chrome&ie=UTF-8")
   }

   ;The thing above, but reversed
   nur_RubToDollar() {
      O_RubToDollar := InputBox("How much in rubles?: ", "Currency converter")
      if O_RubToDollar.Result != "Cancel"
         this.nur_RunLink("https://www.google.com/search?q=" . O_RubToDollar.Value . "+rubles+in+dollars&oq=" . O_RubToDollar.Value . "+rubles+in+dollars&aqs=chrome..69i57.4182j1j9&sourceid=chrome&ie=UTF-8")
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
      faultyLink := this.PathToLink(fullPath)

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
         Case "run":  this.nur_RunLink(fullLink)
         Case "paste":F_ClipSend(fullLink, "")
      }
   }
}
Runner := C_Runner()