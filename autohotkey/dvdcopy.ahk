;
; DVD Copy v. 1
;
; AutoHotkey Version: 2.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Aaron Bach <bachya1208@googlemail.com>
;

; Path Variables
IniRead, dvdFabPath, dvdcopy.ini, DVDFab, path
IniRead, dvdShrinkPath, dvdcopy.ini, DVDShrink, path
IniRead, imgBurnPath, dvdcopy.ini, ImgBurn, path

CoordMode, Mouse, Relative

Run, "%PROGRAMFILES%\%dvdFabPath%"
WinWait, Welcome to DVDFab
if ErrorLevel {
	MsgBox, DVDFab entry screen timed out.
	return
}
else {
	WinActivate, Welcome to DVDFab
	Send {Tab}
	Send {Enter}
	WinWait, Open DVD source
	if ErrorLevel {
		MsgBox, Loading DVD timed out.
	}
	else {
		WinWaitClose, Open DVD source
		WinActivate, DVDFab HD Decrypter
		MouseMove 350, 460
		Click 2
		Send {^c}
		ClipWait
		MsgBox, %clipboard%
		WinClose, DVDFab HD Decrypter
		Exit
	}
}