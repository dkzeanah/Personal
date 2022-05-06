Class C_Script {
   
   ;Reloads the script
   scr_Reload() {
      Run(A_ScriptFullPath), this.scr_BeepReload()
   }

   ;Hard reloads the script: exits the script and then runs it, instead of just running over itself like scr_Reload does
   scr_HardReload() {
      OnExit((ExitReason, ExitCode) => (
         ExitReason == "Exit" 
         ? (Run(A_ScriptFullPath), this.scr_BeepHardReload())
         : "")) 
      , ExitApp()
   }

   ;Exits the script
   scr_ExitApp() {
      this.scr_BeepExitapp(), ExitApp()
   }

   ;Suspends or unsuspends the script
   scr_Suspend() {
      A_IsSuspended 
         ? (Suspend(False), this.scr_BeepUnSuspend()) 
         : (Suspend(True), this.scr_BeepSuspend())
   }

   ;Run test script
   scr_Test(extension:=".ah2") {
      this.scr_BeepLaunch(), Run(A_WorkingDir . "\Test\Tests" . extension,,, &testPID)
      return testPID
   }

   ;Run test script if it doesn't exist, send the exiapp hotkey to it if it does
   scr_ToggleTest(exitHotkey := "!{Pause}", extension := ".ah2") {
      static testPID := 0
      ((!testPID)
         ? testPID := this.scr_Test(extension)
         : (Send(exitHotkey), testPID := 0))
   }

   ;Reboot
   scr_Reboot() {
      Shutdown(2)
   }


   ;Sounds
   ;————————————————————————————————

   scr_BeepReload() {
      SoundBeep(800, 200)
   }

   scr_BeepExitapp() {
      SoundBeep(300, 200)
   }

   scr_BeepHardReload() {
      SoundBeep(600, 200)
   }

   scr_BeepLaunch() {
      SoundBeep(1000, 200)
   }

   scr_BeepUnSuspend() {
      SoundBeep(800, 100), SoundBeep(900, 100)
   }

   scr_BeepSuspend() {
      SoundBeep(800, 100), SoundBeep(700, 100)
   }
}
Script := C_Script()
