ClickThenGoBack(coordinates) {
     MouseGetPos(&initX, &initY)
   , Click(coordinates)
   , MouseMove(initX, initY)
}

;Clicks as an event for extra fucky things
ClickThenGoBack_Event(coordinates) {
     MouseGetPos(&initX, &initY)
   , SendEvent("{Click " . coordinates . "}")
   , MouseMove(initX, initY)
} 

;A faster send. Sending stuff can take too long, but if you copy and paste it, it's much faster. Retains your clipboard as well
ClipSend(toSend, endChar := " ", isClipReverted := 1, untilRevert := 200) {
     ((isClipReverted) ? prevClip := ClipboardAll() : "")
   , A_Clipboard := toSend . endChar
   , Send("^v")
   , ((isClipReverted) 
      ? SetTimer(() => A_Clipboard := prevClip, -untilRevert) 
      : "")
}

RunLink(link) {
   Run(link), WinActivate("Google Chrome ahk_exe chrome.exe")
}

WaitUntilImage(image) {
   var := 0
   imageFile := A_WorkingDir . "\Files\Images\" . image . ".png"
   While !var {
      var := ImageSearch(&imgX, &imgY, 0, 0, A_ScreenWidth, A_ScreenHeight, imageFile)
   }
   return [imgX, imgY]
}

WaitClick(image) {
   coords := WaitUntilImage(image)
   , ControlClick("X" . coords[1] . " Y" . coords[2], "A")
}

WindowGetter() {

   ;Getting the current window's info
   winTitle := WinGetTitle("A")
   , winExePath := WinGetProcessPath("A")
   , winExe := WinGetProcessName("A")
   
   ;Gui creation
   G_WinGet := Gui("AlwaysOnTop", "WindowGetter")
   , G_WinGet.Show("Center H200 W1000")
   , G_WinGet.SetFont("S20")
   
   ;Show the window's info
   G_WinGet_WinTitle := G_WinGet.Add("Text", "Center", winTitle)
   , G_WinGet_WinExePath := G_WinGet.Add("Text", "Center", winExePath)
   , G_WinGet_WinExe := G_WinGet.Add("Text", "Center", winExe)

   ;This function copies the text you clicked to your clipboard and destroys the gui right after
   ToClip(text) => (
      A_Clipboard := text,
      FlushHotkeys()
   )

   ;Destroys the gui as well as every previously created hotkeys
   FlushHotkeys() => (
      Hotkey("F1", "Off"),
      Hotkey("F2", "Off"),
      Hotkey("F3", "Off"),
      Hotkey("Escape", "Off"),
      G_WinGet.Destroy()
   )

   ;Making the func objects to later call in two separate instances
   ToClip_Title := (*) => ToClip(winTitle) ;We pass the params of winSmth
   , ToClip_Path := (*) => ToClip(winExePath) ;To copy it, disable the hotkeys and destroy the gui
   , ToClip_Exe := (*) => ToClip(winExe) 

   Hotkey("F1", ToClip_Title, "On")
   , Hotkey("F2", ToClip_Path, "On")
   , Hotkey("F3", ToClip_Exe, "On")
   , Hotkey("Escape", (*) => FlushHotkeys(), "On")

   G_WinGet_WinTitle.OnEvent("Click", ToClip_Title)
   , G_WinGet_WinExePath.OnEvent("Click", ToClip_Path)
   , G_WinGet_WinExe.OnEvent("Click", ToClip_Exe)
   , G_WinGet.OnEvent("Close", (*) => FlushHotkeys()) ;Destroys the gui when you close the X button on it

}

CoordGetter() {

   ;We get all the coordinates and the pixel color at absolute coords
   CoordMode("Mouse", "Screen")
   , MouseGetPos(&locScrX, &locScrY)

   , CoordMode("Mouse", "Client")
   , MouseGetPos(&locCliX, &locCliY)

   , CoordMode("Mouse", "Window")
   , MouseGetPos(&locWinX, &locWinY)

   , CoordMode("Pixel", "Screen")
   , pixel := PixelGetColor(locScrX, locScrY, "Alt Slow") ;Haven't used pixelgetcolor so using the slowest method for safety

   ;Creation of the gui
   G_CrdGet := Gui("AlwaysOnTop", "Coord Getter")
   , G_CrdGet.Show("Center H440 W300")
   , G_CrdGet.SetFont("S30")

   ;Adding all the text for the gui
   G_CrdGet_CtrlFormat := G_CrdGet.Add("Text",, "X = " . locCliX . "`nY = " . locCliY)
   , G_CrdGet_Screen := G_CrdGet.Add("Text",, "Screen")
   , G_CrdGet_Client := G_CrdGet.Add("Text", "y+15", "Client")
   , G_CrdGet_Window := G_CrdGet.Add("Text", "y+15", "Window") ;The 'word' text is visually more grouped together
   , G_CrdGet_Pixel := G_CrdGet.Add("Text", "y+35", pixel)
   
   ;Destroys the gui as well as every previously created hotkey
   ;You can also append defining arrow functions, but there has to be nothing after them (on the same line). Otherwise that next thing is considered as the second value for => to return, which is an error. To go around this, you can wrap the whole arrow definition into () and then it's all good. But at that point, what are you doing (we draw the line right below what we believe)
   FlushHotkeys() => (
      Hotkey("F1", "Off"),
      Hotkey("F2", "Off"),
      Hotkey("F3", "Off"),
      Hotkey("F4", "Off"),
      Hotkey("F5", "Off"),
      Hotkey("Escape", "Off"),
      G_CrdGet.Destroy()
   )

   ;This function copies the text you clicked to your clipboard and destroys the gui right after
   ToClip(text) => (A_Clipboard := text, FlushHotkeys())

   ;Defining all the function objects that we're gonna call by hotkeys and buttons. (*) takes care of Hotkey and OnEvent requiring parameters we aren't gonna use
   ;If you keep appending lines for too long, it overflows the memory and gives an error — this is why there's no , here. Plus, harder to debug because ahk sees it as one line. The positive is that it's around 35% faster. Be careful with this tradeoff (you can remove all the ,'s at starts of lines if you want)
   ToClip_CtrlFormat := (*) => ToClip("`"X" locCliX " Y" locCliY "`"") ;You get the formatting that you can just paste into your controlclick without having to change anything
   , ToClip_Screen := (*) => ToClip(locScrX " " locScrY)
   , ToClip_Client := (*) => ToClip(locCliX " " locCliY)
   , ToClip_Window := (*) => ToClip(locWinX " " locWinY) ;Pure coords with no formatting for the other options
   , ToClip_Pixel := (*) => ToClip(pixel)
   , FlushHotkey := (*) => FlushHotkeys() ;Seems stupid and it kinda is, but this takes care of Hotkey and OnEvent requiring parameters we aren't gonna use

   ;Press a hotkey to activate its func object
   Hotkey("F1", ToClip_CtrlFormat, "On")
   , Hotkey("F2", ToClip_Screen, "On")
   , Hotkey("F3", ToClip_Client, "On")
   , Hotkey("F4", ToClip_Window, "On")
   , Hotkey("F5", ToClip_Pixel, "On")
   , Hotkey("Escape", FlushHotkey, "On")
   
   ;Click the text to activate its func object (same as with hotkeys)
   G_CrdGet_CtrlFormat.OnEvent("Click", ToClip_CtrlFormat)
   , G_CrdGet_Screen.OnEvent("Click", ToClip_Screen)
   , G_CrdGet_Client.OnEvent("Click", ToClip_Client)
   , G_CrdGet_Window.OnEvent("Click", ToClip_Window)
   , G_CrdGet_Pixel.OnEvent("Click", ToClip_Pixel)
   , G_CrdGet.OnEvent("Close", FlushHotkey) ;The gui isn't automatically destroyed when you click X by default, you'd have to do `guiObj.OnEvent("Close", (*) => guiObj.Destroy())` usually

}

TransAndProud(whatCrement) {
   howTrans := WinGetTransparent("A")

   if !howTrans 
      howTrans := 255

   etgServer := howTrans + whatCrement

   Switch {
      Case etgServer >= 255:etgServer := "Off"
      Case etgServer <= 1:  etgServer := 1
   }
   
   Try WinSetTransparent(etgServer, "A")
}

TransPeek(keyName, transParency := 140) {
   WinSetTransparent(transParency, "A")
   KeyWait(keyName, "U")
   WinSetTransparent("Off", "A")
}

ToolPeek(text, timeout := 1000) {
   ToolTip(text)
   SetTimer(() => ToolTip(), -timeout)
}

Clock() {

   ;Get the time variables
   clock_Time := FormatTime(, " HH:mm:ss")
   , clock_Week := FormatTime(, "dddd")
   , clock_Date := FormatTime(, "d MMMM")

   ;Create the gui
   G_Clock := Gui("AlwaysOnTop", "Clock")
   G_Clock.Show("Center W350 H320")

   ;Add text
   G_Clock.SetFont("S40")
   G_Clock_Time := G_Clock.Add("Text", "y+40", clock_Time) ;We only need the time gui to change its text property later

   G_Clock.SetFont("S30")
   G_Clock.Add("Text", "y+35 Center W237", clock_Week)

   G_Clock.SetFont("S26")
   G_Clock.Add("Text", "Center W237", clock_Date)

   ;The func obj is separate because we'll need to disable the timer outside of it
   seconds := () => (G_Clock_Time.Text := FormatTime(, " HH:mm:ss"))

   ;Change the time text every half a second for better accuracy
   SetTimer(seconds, 500)

   ;Takes care of all the trash
   Destruction := (*) => ( ;the * takes care of the required parameters for hotkey and onevent
      SetTimer(seconds, 0), ;Since it references a function object, it can be outside of the settimer's thread
      Hotkey("Escape", "Off"),
      G_Clock.Destroy()
   )

   Hotkey("Escape", Destruction, "On")
   G_Clock.OnEvent("Close", Destruction)
}

FileSearch(shouldOpen := True, fileNameTip := True, caseSense := "Off") { ;fileNameTip shows you a small boxie around your cursor after opening the file's folder to remind you of the name of the file you're tryig to find. This is simply because I don't know how to make it highlight the file itself :(. Case sense is off by default, but may need to be changed to locale if you intend to search for files named not in English
   
   folder := DirSelect("C:\",, "What folder do you want to search?:")
   if !folder 
      return

   search := InputBox("What file do you want to search for?:", "File Search")
   if search.Result = "Cancel" 
      return

   if RegexMatch(search.Value, "[а-яА-Я]") && caseSense != "Locale" ;If your search request you just did contains russian, caseSense for the search in InStr() is automatically made to Locale, so it actually *is* case insensitive. Likely the same case for other languages with different writing systems and doesn't matter for stuff like spanish and french (just a baseless hunch)
      caseSense := "Locale"

   g_found := Gui("AlwaysOnTop", "These files match your search:")
   g_found_list := g_found.Add("ListView", "W1480 H500", ["Full file path"]) ;The width of both texts and listviews needs to be slightly smaller than the gui itself, so it actually looks like it's supposed to. The third parameter requires an array object, so you can read it as Array("Full file path")

   g_found.OnEvent("Close", (*) => g_found.Destroy()) ;The gui doesn't get destroyed automatically when you close it, so we have to do it ourselves. I don't even remember if "close" has required parameters, but I take care of them with * (meaning "and any other parameters") if it does have them.
   g_found_list.OnEvent("DoubleClick", openFolder.Bind(shouldOpen, fileNameTip))

   g_found_list.Opt("-Redraw") ;With the "+Redraw" that comes later, we speed up the process of adding rows to the ListView, since it doesn't need to refresh the new row every single time and instead just ends up showing what we got in the end

   Loop Files folder . "\*.*", "R" { ;R means recursion. If the loop sees a folder, it goes into it. This way we search everything within the folder that was initially picked
      if InStr(A_LoopFileName, search.Value, caseSense) ;Despite what you may think, ternary *isn't* faster here. At least, mostly isn't. A ternary with a : False is usually slower than an if check with no else
         g_found_list.Add(, A_LoopFileFullPath)
   }

   g_found_list.Opt("+Redraw")

   g_found.Show("W1500 H500")

   openFolder(shouldOpen, fileNameTip, g_found_list, RowNumber) { ;Despite that we didn't manually put in any of the two parameters, the onEvent automatically passes them into the function object of openFolder that we're using. 
      path := g_found_list.GetText(RowNumber)
      A_Clipboard := path
      g_found.Destroy()

      if shouldOpen {
         SplitPath(path, &fileName, &dir)  
         Run(dir)
         if fileNameTip { ;So you remember what file you want to find after its folder has been opened, there will be a small boxie with the name of the file, until you close or minimize the explorer window
            WinWaitActive(dir)
            ToolTip(fileName, 10, 10)
            WinWaitNotActive(dir)
            ToolTip()
         }
      }
   } ;You can decide whether you just copy the path or also open the file's folder when you double click on it, by changing the shouldOpen parameter of FileSearch

}

