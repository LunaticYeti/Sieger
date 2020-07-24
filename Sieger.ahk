#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Add, Launch Rainbow Six Siege, SiegeLabel
DetectHiddenWindows, On
Script_Hwnd := WinExist("ahk_class AutoHotkey ahk_pid " DllCall("GetCurrentProcessId"))
DetectHiddenWindows, Off

HexToDec(Hex)
{
	if (InStr(Hex, "0x") != 1)
		Hex := "0x" Hex
	return, Hex + 0
}

DllCall("RegisterShellHookWindow", "uint", Script_Hwnd)
OnMessage(DllCall("RegisterWindowMessage", "str", "SHELLHOOK"), "ShellEvent")

ShellEvent(wParam, lParam) {
	WinGet, active_id, ID, Rainbow Six
	active_id := HexToDec(active_id)
    if (wParam = 0x8006 && lParam = active_id) ; HSHELL_FLASH
    {   ; lParam contains the ID of the window which flashed:
        WinActivate, ahk_id %active_id%
    }
}

SiegeLabel:
	Run, cmd /c start steam://rungameid/359550