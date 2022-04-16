;Reloads the script
F_Reload() {
   Run(A_ScriptFullPath), SoundPlay("*-1")
}

;Exits the script
F_ExitApp() {
   SoundPlay("*16"), ExitApp()
}

;Suspends or unsuspends the script
F_Suspend() {
   if A_IsSuspended
      Suspend(False), SoundPlay("*-1")
   else 
      Suspend(True), SoundPlay("*16")
}

;Run test script
F_Test(version:=".ah2") {
   SoundPlay("*-1"), Run(A_WorkingDir . "\Test\Tests" . version) 
}

;Reboot
F_Reboot() {
   Shutdown 2
}