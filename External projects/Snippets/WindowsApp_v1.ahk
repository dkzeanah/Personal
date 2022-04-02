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
MinMax(title) {
   (WinActive(title) ? WinMinimize(title) : WinActivate(title))
}

;If the window exists, minimize or maximize it depending on its state and return 1, otherwise return 0
ifMinMax(title)
{
   if WinExist(title)
   {
      MinMax(title)
      return 1
   }
   else
      return 0
}

;Run an exe, activate its window
RunApp(winTitle, exePath)
{
   Run, %exePath%,, Max
   WinWait %winTitle%,, 10
   WinActivate %winTitle%
} 

;If the app doesn't exist, launches it. If it does and is active, minimizes it. If it's minimized, activates it
WindowsApp(winTitle, exePath) 
{
   if !ifMinMax(winTitle)
      RunApp(winTitle, exePath)
}

