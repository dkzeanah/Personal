;Minimize for ternary 
WinMinimize(title)
{
   WinMinimize, %title%
}

;Active for ternary
WinActive(title)
{
   WinActivate, %title%
}

;Minimizes or maximizes the window depending on its state
F_MinMax(title) {
   (WinActive(title) ? WinMinimize(title) : WinActivate(title))
}

;If the window exists, minimize or maximize it depending on its state and return 1, otherwise return 0
F_ifMinMax(title)
{
   if WinExist(title)
   {
      F_MinMax(title)
      return 1
   }
   else
      return 0
}

;Run an exe, activate its window
F_RunApp(winTitle, exePath)
{
   Run, %exePath%,, Max
   WinWait %winTitle%,, 10
   WinActivate %winTitle%
} 

;If the app doesn't exist, launches it. If it does and is active, minimizes it. If it's minimized, activates it
F_WindowsApp(winTitle, exePath) 
{
   if !F_ifMinMax(winTitle)
      F_RunApp(winTitle, exePath)
}

