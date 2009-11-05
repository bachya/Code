;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Adam Pash <adam@lifehacker.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
InputBox, UserInput, DVD Name, Please enter the name of your DVD.
if ErrorLevel
{
	MsgBox, You cancelled the rip.
	Exit
}	
else
	Run "%PROGRAMFILES%\DVD Shrink\DVD Shrink 3.2.exe"
	WinWait, DVD Shrink 3.2
	if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
else
;	WinMinimize  ; Minimize the window found by WinWait.
	WinActivate, "DVD Shrink 3.2"
;	Sleep 5000
	Send, {Alt down}
	Send, {f}
	Send, {Alt up}
	Sleep 500
	Send, {d}
	Sleep 500
	Send, {Enter}
	WinMinimize
	WinMinimize ahk_class #32770
	WinWait, DVD Shrink 3.2 - E:\
	WinActivate, DVD Shrink 3.2 - E:\
	Sleep 500
	Send, {Ctrl Down}
	Send, {b}
	Send, {Ctrl Up}
	Sleep 600
	IfWinExist, Target Size Exceeded	
	{
		Send, {Tab}
		Sleep 200
		Send, {Enter}
	}
	WinWait, Backup DVD
	WinActivate, Backup DVD
	Sleep 200
	Send, {Tab}
	Sleep 100
	Send, {Ctrl Down}
	Send, {c}
	Send, {Ctrl Up}
	SplitPath, clipboard, name, dir
	Sleep 100
	Send, %dir%
	Sleep 100
	Send, \%UserInput%
	Sleep 100
	Send, {Enter}
	Sleep 800
	WinMinimize ahk_class #32770
	Sleep 5000
	WinWait, Backup Complete
	WinActivate, Backup Complete
	Sleep 500
	Send, {Enter}
	Sleep 500
	WinWait, DVD Shrink 3.2 - E:\
	WinActivate, DVD Shrink 3.2 - E:\
	WinClose, DVD Shrink 3.2 - E:\