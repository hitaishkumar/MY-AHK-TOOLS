#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.
#singleinstance force ;so you can only run 1 script at a time and it doens't bother you about it.




 #+c::                                       ;;;;; google search the highlighted text abd asks what to add
{

 Send, ^c
 Sleep 50
 FileRead,webshortcut, websearch.txt
 InputBox,UserInput, THE GRAND LAUNCHER by DAVYJONES, %webshortcut%`t`n WHAT YOU COPIED IS ::`t`n`t`n` %Clipboard%, ,500,500
	  if  (ErrorLevel == 0)
		{
			
					Haystack := UserInput
					google := "g|"
					ytsearch := "y|"
					
					
			;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;
			; SEARCH WEBSITES
			;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;
					
					IfInString, Haystack, %google%
						{
							string :=StrSplit(UserInput,"g|")
								GSEARCH := % string.2
								;~ MsgBox,% GSEARCH
						
							Run, http://www.google.com/search?q=%GSEARCH%
							return
						}
					IfInString, Haystack, g+
						{
							string :=StrSplit(UserInput,"g+")
								GCLIPSEARCH := % string.2
								;~ MsgBox,% GSEARCH
						
							Run, http://www.google.com/search?q=%Clipboard% %GCLIPSEARCH%
							return
						}
					
					IfInString, Haystack, %ytsearch%
						{
							string :=StrSplit(UserInput,"y|")
								YTSEARCH := % string.2
								;~ MsgBox, % YTSEARCH
							Run, https://www.youtube.com/results?search_query=%YTSEARCH%
							return
						}	
					IfInString, Haystack, y+
						{
							string :=StrSplit(UserInput,"y+")
								YCLIPSEARCH := % string.2
								;~ MsgBox,% GSEARCH
						
							Run,  https://www.youtube.com/results?search_query=%Clipboard% %YCLIPSEARCH%
							return
						}
					IfInString, Haystack, mail
						{
							Run https://mail.google.com/mail/u/0/#inbox ; will open mail in opera the default browser
							return
						
						}
					IfInString, Haystack, yy
						{
							Run, chrome.exe https://www.youtube.com	
							return
						
						}
					IfInString, Haystack, wp
						{
							run, chrome.exe https://web.whatsapp.com/ 
							return
						
						}
					IfInString, Haystack, insta
						{
							run, chrome.exe https://www.instagram.com/
							return
						
						}
					IfInString, Haystack, dr
						{
							Run, chrome.exe https://drive.google.com/drive/my-drive

							return
						
						}
						
						
						
						
						
						
						
						
						
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			; RUN EXPLORER WINDOWS AND FOLDER
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					IfInString, Haystack, e  ;; explorer is e
						{
							
							
							
									FileRead, explorershortcut, explorer.txt
									InputBox,folder, WINDOW FOLDER ME KAHA JANA HAI SAHAB, %explorershortcut%`t`n`t`n` ,, 500,500
									haystack := folder
									;~ if haystack is Integer
									
									;~ {
									;~ MsgBox, it works baby
									;~ return
									;~ }
									;~ else
									;~ {
									;~ MsgBox, it didnt works
									;~ }
										IfInString, haystack, down
										{
											;~ msgbox, it works
										 run C:\Users\%A_Username%\Downloads
											return
										}IfInString, haystack, desk
										{
											;~ msgbox, it works
										 run C:\Users\%A_Username%\Desktop
											return
										}
										IfInString, haystack, un
										{
											
											Run, 	rundll32.exe shell32.dll Control_RunDLL appwiz.cpl  ;;;  opens uninstall window
											
											return
										}
										
							

							return
						
						}
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;RUN PROGRAMS
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
			IfInString, Haystack, p  ;; explorer is e
						{
							
							
							
									FileRead, programshortcut, program.txt
									InputBox,program,KONSA SOFTWARE KHOLNA HAI SAHAB, %programshortcut%`t`n`t`n` ,,500,500
									soystack := program
										IfInString, soystack, c
										{
											;~ msgbox, it works
											Run "Chrome.exe"
											return
										}
										IfInString, soystack, spot
										{
											;~ msgbox, it works
											Run  C:\Users\%A_UserName%\AppData\Roaming\Spotify\Spotify.exe
											return
										}
										IfInString, soystack, wifi
										{
											;~ msgbox, it works
											Run, 	ms-settings:network-wifi
											
											return
										}
									

							return
						
						}
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			; PHILAL
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			return		
		}
		return
 } 
