#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
Persistent

Send "!+{1}"
CurrentLang := 1
; Initialize Keyboard state to "SC" (1=SC 2=EN 3=JP 4=TC)

SetCapsLockState 0
CapsState := false
; Initialize CapsLock state to OFF

; "Caps" key already remapped to "RWin" on physical keyboard
; Hotkeys for switching to certain Keyboard should be set in Windows "language bar options"
RWin::
{
    SetCapsLockState 0      ; Turn "CapsLock" off
    global CapsState := false
    global CurrentLang
    if CurrentLang == 1
    {
        Send "!+{2}"        ; "Alt+Shift+2"-"EN"
        CurrentLang := 2
    }
    else
    {
        Send "!+{1}"        ; "Alt+Shift+1"-"SC"
        CurrentLang := 1
    }
}

~^Space::       ; Switch to EN when "Ctrl+Space"(when calling out "Command Palette" or other Spotlight-like interfaces)
{
    Sleep 100       ; Wait to avoid the following key event be ignored
    Send "!+{2}"
    global CurrentLang := 2
}

~Lwin & ~Space::       ; When manual keyboard switch with "Win(hold)+Space" detected, Update the "CurrentLang" var
{
    global CurrentLang
    if CurrentLang == 4
        CurrentLang := 1
    else
        CurrentLang++
    SendInput "" CurrentLang
}
