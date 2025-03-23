#Requires AutoHotkey v2.0
#SingleInstance Force

; Run in the background
Persistent

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
            ; Switch IME with Win+Space when CapsLock is off
            else
            {
                ; 
                Send "#{Space}"
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
