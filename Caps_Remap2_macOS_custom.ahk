#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
Persistent

Send "!+{1}"
CurrentLang := 1
CapsState := false

; CapsLock remapped to RWin on keyboard
RWin::
{
    global CapsState := false
    SetCapsLockState 0
    global CurrentLang
    if CurrentLang == 1
    {
        Send "!+{2}"        ;Alt+Shift+2 ENG
        CurrentLang := 2
    }
    else
    {
        Send "!+{1}"        ;Alt+Shift+1 Pinyin
        CurrentLang := 1
    }
}

~^Space::       ;Switch to ENG when Ctrl+Space
{
    Sleep 100
    global CurrentLang := 2
    Send "!+{2}"
}
