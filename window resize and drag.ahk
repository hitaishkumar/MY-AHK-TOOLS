#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
/*

 _  _______  ______          _         _
| |/ /  __ \|  ____|        | |       | |
| ' /| |  | | |__ ______ ___| |_ _   _| | ___
|  < | |  | |  __|______/ __| __| | | | |/ _ \
| . \| |__| | |____     \__ \ |_| |_| | |  __/
|_|\_\_____/|______|    |___/\__|\__, |_|\___|
__          ___           _       __/ |
\ \        / (_)         | |     |___/
 \ \  /\  / / _ _ __   __| | _____      __
  \ \/  \/ / | | '_ \ / _` |/ _ \ \ /\ / /
   \  /\  /  | | | | | (_| | (_) \ V  V /
    \/  \/   |_|_| |_|\__,_|\___/ \_/\_/
 _____                        _
|  __ \                      (_)
| |  | |_ __ __ _  __ _  __ _ _ _ __   __ _
| |  | | '__/ _` |/ _` |/ _` | | '_ \ / _` |
| |__| | | | (_| | (_| | (_| | | | | | (_| |
|_____/|_|  \__,_|\__, |\__, |_|_| |_|\__, |
                   __/ | __/ |         __/ |
                  |___/ |___/         |___/


This script was made to improve the way you work
with your windows, by introducing KDE-style window
dragging and resizing, as well as some new
functions that should make things easier for you!

None of these actions require the window they're
working on to be active. Since they all use the
mouse (unless you change it via preference), they
all work on the window currently under it.

2Alt = Two Alt's in rapid succession, like a double click.

Alt + Left Click   : Drag window.
Alt + Right Click  : Resize window.
2Alt + Left Click  : Minimize window.
2Alt + Right Click : Maximize/Restore window.
2Alt + Middle      : Close window.

Or, set the Alternate variable to true for this set:

Alt + Left Click   : Drag Window.
Alt + Right Click  : Resize window.
Left + Right Click : Minimize window.
Right + Left Click : Maximize/Restore window.
Either + Middle    : Close Window.

As a side note, big kudos to Chris for the built-in
boolean variables. They reduced the Var = 0 | 1
type stuff in this script to about zero. If anyone
else thought those things were super annoying, high five.

))) Requires NT/2000/XP and AutoHotkey v1.0.25.7 or later (((

*/

;==============================================================
Alternate := false ; Set to true for the alternate set. I bet
                   ; that was tough to figure out, huh?
SetWinDelay,2 ; The lower, the faster. Keep in mind that faster
              ; doesn't necessarily mean better.
;==============================================================

; If you like having fun breaking scripts, remove
; the line below. I haven't tried it yet. ;-D
CoordMode,Mouse
If Alternate
{
	Hotkey,!LButton,Alternate1
	Hotkey,!RButton,Alternate2
	Hotkey,!MButton,off
	Hotkey,~Alt,off
}
Else
{
	Hotkey,~RButton & LButton,off
	Hotkey,~LButton & RButton,off
	Hotkey,~MButton & RButton,off
	Hotkey,~MButton & LButton,off
	Hotkey,~RButton & MButton,off
	Hotkey,~LButton & MButton,off
}
return

!LButton::
If DoubleAlt ; Remember, this is saying, "If DoubleAlt is true"
{
	; The below is equivalent to WinMinimize. I
	; used this version to work around a reported bug.
     MouseGetPos,,,KDE_id
	PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
	DoubleAlt := false ; Re-initialize it.
	return
}
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
; The code below checks if the window's
; maximized. Obviously, it terminates
; if it is.
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
	return
WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
Loop ; I took the timer off. For some reason I like loops better.
{
	GetKeyState,KDE_Button,LButton,P                  ; 1
	If KDE_Button = U                                 ; 2
		break                                        ; 3
	MouseGetPos,KDE_X2,KDE_Y2                         ; 4
	KDE_X2 -= KDE_X1                                  ; 5
	KDE_Y2 -= KDE_Y1                                  ; 6
	KDE_WinX2 := (KDE_WinX1 + KDE_X2)                 ; 7
	KDE_WinY2 := (KDE_WinY1 + KDE_Y2)                 ; 8
	WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%  ; 9
	; WHOA, right? I'll try to explain:
	; 1-3: Check the LButton state. If up, break.
	; 4: Grab the current mouse position.
	; 5-6: Subtract the current mouse position from the original one.
	;   This generates an offset from the current position.
	; 7-8: Add the offset to the original position of the window.
	; 9: The only part that actually does something. Guess what it is.
}
return

; This is the above code without the unused double-alt.
Alternate1:
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
	return
WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
Loop
{
	GetKeyState,KDE_Button,LButton,P
	If KDE_Button = U
		break
	MouseGetPos,KDE_X2,KDE_Y2
	KDE_X2 -= KDE_X1
	KDE_Y2 -= KDE_Y1
	KDE_WinX2 := (KDE_WinX1 + KDE_X2)
	KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
	WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%
}
return

!RButton::
If DoubleAlt
{
	; Fairly self-explanatory. Gets the ID of
	; the hovered window, then checks whether
	; it's restored or maxed, acting accordingly.
     MouseGetPos,,,KDE_id
	WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
	If KDE_Win
		WinRestore,ahk_id %KDE_id%
	Else
		WinMaximize,ahk_id %KDE_id%
	DoubleAlt := false
	return
}
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
; Again, just checking if it's already
; maximized. I'm surprised none of this
; script's predecessors had this.
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
	return
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; Ok, now we're checking to see what corner the mouse is
; in. This basically sets up 4 "regions" in the window and
; lets the Loop formula below know which one to act in.
; Translation of formula: If Mouse X is less than Window X
; and half of Window Width.
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
	KDE_WinLeft := true
Else
	KDE_WinLeft := false
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
	KDE_WinUp := true
Else
	KDE_WinUp := false

Loop
{
	GetKeyState,KDE_Button,RButton,P    ; 1
	If KDE_Button = U                   ; 2
		break                          ; 3
	MouseGetPos,KDE_X2,KDE_Y2           ; 4
	WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%  ; 5
	KDE_X2 -= %KDE_X1%                  ; 6
	KDE_Y2 -= %KDE_Y1%                  ; 7
	If KDE_WinLeft                      ; 8
	{                                   ; 9
		KDE_WinX1 += %KDE_X2%          ; 10
		KDE_WinW -= %KDE_X2%           ; 11
	}                                   ; 12
	Else                                ; 13
		KDE_WinW += %KDE_X2%           ; 14
	If KDE_WinUp                        ; 15
	{                                   ; 16
		KDE_WinY1 += %KDE_Y2%          ; 17
		KDE_WinH -= %KDE_Y2%           ; 18
	}                                   ; 19
	Else                                ; 20
		KDE_WinH += %KDE_Y2%           ; 21
	WinMove,ahk_id %KDE_id%,,%KDE_WinX1%,%KDE_WinY1%,%KDE_WinW%,%KDE_WinH% ; 22
	KDE_X1 := (KDE_X2 + KDE_X1)         ; 23
	KDE_Y1 := (KDE_Y2 + KDE_Y1)         ; 24
	; Ya, um... ok. Wow. This was hard to
	; wade through and figure out at first,
	; but eventually I got this working.
	; I'll TRY to explain:
	; 1-3: Check the RButton state. If up, break.
	; 4-5: Grabs the necessary info. If you don't think it's necessary
	;   to grab the WinPos again, well, you might be right. Just be
	;   prepared to make some big changes to the formula below it.
	; 6-7: Subtract to get an offset from the current position.
	; 8-12: If the mouse was found to be on the left side,
	;   subtract the offset from the width (to reverse it.)
	;   Then, add the offset to the X axis to correct the
	;   window's position. If you don't think that's necessary,
	;   screw with this a little and see for yourself.
	; 13-14: If not, add the offset to the width. No correction
	;   is necessary.
	; 15-19: Same as above, but for the Y axis and height.
	; 20-21: Ditto.
	; 22: Move the window to it's new size, and yes: position.
	;   As shown above, it requires a correction if the offset
	;   was reversed. Hope it makes sense. :-/
	; 23-24: Set the current mouse position to "old" for the
	;   next iteration. I changed it to this expression-based
	;   version to avoid adding yet another variable.
}
return

Alternate2:
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
	return
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
	KDE_WinLeft := true
Else
	KDE_WinLeft := false
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
	KDE_WinUp := true
Else
	KDE_WinUp := false
Loop
{
	GetKeyState,KDE_Button,RButton,P
	If KDE_Button = U
		break
	MouseGetPos,KDE_X2,KDE_Y2
	WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
	KDE_X2 -= %KDE_X1%
	KDE_Y2 -= %KDE_Y1%
	If KDE_WinLeft
	{
		KDE_WinX1 += %KDE_X2%
		KDE_WinW -= %KDE_X2%
	}
	Else
		KDE_WinW += %KDE_X2%
	If KDE_WinUp
	{
		KDE_WinY1 += %KDE_Y2%
		KDE_WinH -= %KDE_Y2%
	}
	Else
		KDE_WinH += %KDE_Y2%
	WinMove,ahk_id %KDE_id%,,%KDE_WinX1%,%KDE_WinY1%,%KDE_WinW%,%KDE_WinH%
	KDE_X1 := (KDE_X2 + KDE_X1)
	KDE_Y1 := (KDE_Y2 + KDE_Y1)
}
return

!MButton::
If DoubleAlt
{
	MouseGetPos,,,KDE_id
	WinClose,ahk_id %KDE_id%
	DoubleAlt := false
	return
}
return

~Alt::              ; Runs when Alt is pressed alone.
DoubleAlt := false  ; Re-initialize it to false,
KeyWait,Alt         ; Wait for Alt to be released,
KeyWait,Alt,D T0.6  ; Wait for it to be pressed again;
If Errorlevel       ; If the above line took too long,
	return           ; terminate.
DoubleAlt := true   ; Otherwise, set DoubleAlt to true.
return

; Urk. Yes, I know the pass-through is
; superbly annoying, but I swear I tried
; for at least half an hour, tweaking with
; these darn combos and this is the best
; working stuff I got. Either think up
; different combos or make this work right
; if you're too annoyed to live with it.
~RButton & LButton::
MouseGetPos,,,KDE_id
PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
return

~LButton & RButton::
MouseGetPos,,,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
	WinRestore,ahk_id %KDE_id%
Else
	WinMaximize,ahk_id %KDE_id%
return

~MButton & RButton::
~MButton & LButton::
~RButton & MButton::
~LButton & MButton::
MouseGetPos,,,KDE_id
WinClose,ahk_id %KDE_id%
return