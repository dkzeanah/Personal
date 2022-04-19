;Reloads the script
F_Reload() => (Run(A_ScriptFullPath), SoundPlay("*-1"))

;Hard reloads the script: exits the script and then runs it, instead of just running over itself like F_Reload does
F_HardReload() => (
   OnExit((ExitReason, ExitCode) => (
      ExitReason == "Exit" 
      ? (Run(A_ScriptFullPath), SoundPlay("*-1")) 
      : "")), 
   SoundPlay("*16"), ExitApp()
)

;Exits the script
F_ExitApp() => (SoundPlay("*16"), ExitApp())

;Suspends or unsuspends the script
F_Suspend() => (
   A_IsSuspended 
   ? (Suspend(False), SoundPlay("*-1")) 
   : (Suspend(True), SoundPlay("*16"))
)

;Run test script
F_Test(extension:=".ah2") => (SoundPlay("*-1"), Run(A_WorkingDir . "\Test\Tests" . extension))

;Reboot
F_Reboot() => Shutdown(2)