#Requires AutoHotkey v2.0
#SingleInstance Force

; Run in the background
Persistent

Send "!+{1}"
CurrentLang := 1
SetCapsLockState "Off"
CapsState := false

CapsLock::
{
    if (KeyWait("CapsLock", "T0.5"))&&!WinActive("Parsec")
    {
        if(CapsState)
        ; If CapsLock is on, turn off without IME switch
        {
            SetCapsLockState "Off"
            global CapsState := false
        }
        else
        ; Switch IME when CapsLock is off
        {
            global CurrentLang
            if (CurrentLang = 1)
            {
                Send "!+{2}"
                CurrentLang := 2
            }
            else
            {
                Send "!+{1}"
                CurrentLang := 1
            }
        }
    }

    ; Switch CapsLock state when pressed for over 0.5s or when Parsec is active
    else
    {
        SetCapsLockState !CapsState
        global CapsState := !CapsState
    }
}
