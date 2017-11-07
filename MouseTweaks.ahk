/*
MouseTweaks.ahk
OSX-like mouse behaviour for MS Windows
Reverses mouse wheel scroll direction
Scrolls windows under mouse, even if inactive
Copyright 2014 Skag Rijsdijk
https://github.com/skagr
*/

applicationName := "MouseTweaks"
version := "v1.1"
reverseScroll := true

#SingleInstance,Force
#NoEnv
#MaxHotkeysPerInterval 1000
CoordMode, Mouse, Screen
;SendMode,Input
;DetectHiddenWindows,On
SetWinDelay,0
SetKeyDelay,0
SetControlDelay,0

Gosub,TRAYMENU
return

#N::
	MsgBox, Vorige hotkey: %A_PriorHotkey%

WheelUp::
	MouseGetPos, m_x, m_y, , m_control
	if(m_control = "msctls_trackbar321"){
		Gosub,SCROLLUP ;default scroll direction for Win volume slider
	}
	else if(reverseScroll = true){
		Gosub,SCROLLDOWN
	}
	else{
		Gosub,SCROLLUP
	}
return

WheelDown::
	MouseGetPos, m_x, m_y, , m_control
	if(m_control = "msctls_trackbar321"){
		Gosub,SCROLLDOWN ;default scroll direction for Win volume slider
	}
	else if(reverseScroll = true){
		Gosub,SCROLLUP
	}
	else{
		Gosub,SCROLLDOWN
	}
return

SCROLLUP:
	;MouseGetPos, m_x, m_y
	hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; WM_MOUSEWHEEL
	;	WHEEL_DELTA = 120
	SendMessage, 0x20A, 120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
return

SCROLLDOWN:
	;MouseGetPos, m_x, m_y
	hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; WM_MOUSEWHEEL
	;	WHEEL_DELTA = 120
	SendMessage, 0x20A, -120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
return

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,&About,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Default,&About
Menu,Tray,Tip,%applicationName%
return

ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Add,Picture,xm Icon1,%applicationName%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,%applicationName% %version%
Gui,99:Font
Gui,99:Add,Text,y+10,OSX-like mouse behaviour for MS Windows
Gui,99:Add,Text,y+10,Reverses mouse wheel scroll direction
Gui,99:Add,Text,y+10,Scrolls windows under mouse, even if inactive
Gui,99:Add,Text,y+20,Copyright 2014 Skag Rijsdijk
Gui,99:Add, Link,y+10, <a href="https://github.com/skagr">https://github.com/skagr</a>

Gui,99:Show,,%applicationName%
return

EXIT:
ExitApp