#IfWinActive ahk_class Chrome_WidgetWin_1 
^F10::  ;; ctrl + F10
{ 
	Haystack := Clipboard
    Needle := "youtu"
IfInString, Haystack, %Needle%
	{
		url:= Clipboard
		StringLen, youtubecode, url
		;~ MsgBox, The length of url is %youtubecode%.
		if (youtubecode > 35)              
		{
			String := Clipboard
							
				screenshotcode :=StrSplit(url,"=")
				videocode := % screenshotcode.2
				yz := StrSplit(videocode, "&")
				ccodycode:= % yz.1
				
				;~ MsgBox, % Format("URL>35:`t{}`nCCODYCODE:`t{}", String, ccodycode)
																																						
			Run, https://img.youtube.com/vi/%ccodycode%/maxresdefault.jpg
			return
			
		
		}	
		if (youtubecode <  35)            
		{
			String := Clipboard
																			
				screenshotcode :=StrSplit(url,"/")                         ; 1st breaks the string at " b " takes the second part and then again breaks the second part at "/" to get the last code 
				videocode := % screenshotcode.4
				sabselastcode:= StrSplit(videocode,"&")
				codycode:= % sabselastcode.1
		
				;~ MsgBox, % Format("URL<35:`t{}`nCODYCODE:`t{}", String, codycode)

			Run, https://img.youtube.com/vi/%codycode%/maxresdefault.jpg
				return
	
		}
	return
	}
	
IfNotInString, Haystack, %Needle% 
		{
			MsgBox, , NOT A YOUTUBE LINK,  what you copied is not a youtube link, 3
			MsgBox, , WHAT YOU COPIED,  %Clipboard% 
			
			return
		}
	return
}
																			

}
