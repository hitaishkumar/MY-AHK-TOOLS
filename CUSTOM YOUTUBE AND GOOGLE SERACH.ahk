#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.
#singleinstance force ;so you can only run 1 script at a time and it doens't bother you about it.



^+c::                                       ;;;;; google search the highlighted text
{
 Send, ^c
 Sleep 50
 Run, http://www.google.com/search?q=%Clipboard%
 Return
} 


 #+c::                                       ;;;;; google search the highlighted text and asks what to add
{

 Send, ^c
 Sleep 50
 InputBox,UserInputgoogle, GOOGLE IT BABY, %Clipboard% +, 640, 480
	  if  (ErrorLevel == 0)
		{
			Haystack := UserInputgoogle
			Needle := "|"
			IfInString, Haystack, %Needle%
				{
					string :=StrSplit(UserInputgoogle,"|")
						GSEARCH := % string.2
						;MsgBox,% GSEARCH
				
					Run, http://www.google.com/search?q=%GSEARCH%
					return
				
				}
			IfNotInString, Haystack, %Needle%
				{
					Run, http://www.google.com/search?q=%Clipboard% %UserInputgoogle%
					return
				
				}
					
		}
		
	  
 Return 
} 



^+v::                                       ;;;;; youutube search the highlighted text
{
 Send, ^c
 Sleep 50
 Run, https://www.youtube.com/results?search_query=%Clipboard%
 Return
}



#+v::                                       ;;;;; youutube search the highlighted text and asks what to add
{
 
 Send, ^c
 Sleep 50
InputBox,UserInputyoutube, YOUTUBE IT BABY, %Clipboard% +, 640, 480
	  if  (ErrorLevel == 0)
	{
			  Haystack := UserInputyoutube
				Needle := "|"
			IfInString, Haystack, %Needle%
				{
					string :=StrSplit(UserInputyoutube,"|")
					
						YTSEARCH := % string.2
						;~ MsgBox, % YTSEARCH
					
					Run, https://www.youtube.com/results?search_query=%YTSEARCH%
					return
				
				}
			IfNotInString, Haystack, %Needle%
				{
					Run, https://www.youtube.com/results?search_query=%Clipboard% %UserInputyoutube%
					return
				
				}
	}
 Return 
}