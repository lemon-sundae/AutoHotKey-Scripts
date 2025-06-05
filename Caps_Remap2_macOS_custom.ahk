#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; Run in the background
Persistent

Send "!+{1}"
CurrentLang := 1
SetCapsLockState "Off"
CapsState := false


CapsLock::
{
    if KeyWait("CapsLock", "T0.5")&&!WinActive("Parsec")
    {
        if !CapsState
        {
            if GetKeyState("CapsLock", "T")
            {
                SetCapsLockState "Off"
            }
            else
            ; Switch IME when CapsLock is off
            {
                global CurrentLang
                if CurrentLang == 2
                {
                    Send "!+{1}"
                    CurrentLang := 1
                }
                else
                {
                    Send "!+{2}"
                    CurrentLang := 2
                }
            }
        }
        global CapsState := false
    }

    ; Switch CapsLock state when pressed for over 0.5s or when Parsec is active
    else
    {
        if(!CapsState)
        {
            global CapsState := true
            SetCapsLockState !GetKeyState("CapsLock", "T")
        }
    }
}
