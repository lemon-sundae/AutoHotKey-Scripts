#Requires AutoHotkey v2.0
#SingleInstance Force

; Run in the background
Persistent

currentLang := 1
global isCapsPressed := false

CapsLock::
{
    if (KeyWait("CapsLock", "T0.5"))
    {
        if(!isCapsPressed)
        {
            ; If CapsLock is on, turn off without IME switch
            if GetKeyState("CapsLock", "T")
            {
                SetCapsLockState "Off"
            }
            ; Switch IME when CapsLock is off
            else
            {
                Global currentLang
                if (currentLang = 1)
                {
                    ; Switch to CN
                    Send "!+{1}"
                    currentLang := 2
                }
                else
                {
                    Send "!+{2}"
                    currentLang := 1
                }
            }
        }
        global isCapsPressed := false
    }

    ; Switch CapsLock state when pressed for over 0.5s
    else
    {
        if(!isCapsPressed)
        {
            global isCapsPressed := true
            SetCapsLockState !GetKeyState("CapsLock", "T")
        }
    }
}
