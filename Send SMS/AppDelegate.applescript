--
--  AppDelegate.applescript
--  Send SMS
--
--  Created by Thomas Verschoren on 09/03/16.
--  Copyright © 2016 Thomas Verschoren. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value
    property phoneNumber: missing value
    property daveReference: missing value
    property resultMessage: missing value
    property radioTypeService: missing value
    property radioTypeiPhone: missing value
    property radioTypeRetail: missing value
    property radioNoorderlaan: missing value
    property radioGent: missing value
    property radioLatem: missing value
    property radioHasselt: missing value
    property radioGenk: missing value
    property radioLier: missing value
    property radioOostende: missing value
    property radioTheater: missing value
    property radioWaasland: missing value
    property radioWijnegem: missing value

on buttonClicked_(Sender)
    #Set Type Value
    set typeString to ""
    set conditions to ""
    #Service
    set serviceValue to ""
    set serviceValue to radioTypeService's stringValue as string
    if serviceValue = "1"
    set typeString to "herstelling"
    end
    #Retail
    set retailValue to ""
    set retailValue to radioTypeRetail's stringValue as string
    if retailValue = "1"
    set typeString to "bestelling"
    set conditions to ". Het toestel wordt 5 of 10 dagen voor je gereserveerd zoals vermeld in de mail."
    end
    #iPhone7
    set iphoneValue to ""
    set iphoneValue to radioTypeiPhone's stringValue as string
    if iphoneValue = "1"
    set typeString to "bestelling van een iPhone 7"
    set conditions to ". Het toestel wordt 5 dagen voor je gereserveerd"
    end

    #Set Location Toggle
        set location to ""
        #Genk
        set genkValue to ""
        set genkValue to radioGenk's stringValue as string
        if genkValue = "1"
        set location to "Genk"
    end
    #Gent
    set gentValue to ""
    set gentValue to radioGent's stringValue as string
    if gentValue = "1"
    set location to "Gent"
end
#hasselt
set hasseltValue to ""
set hasseltValue to radioHasselt's stringValue as string
if hasseltValue = "1"
set location to "Hasselt"
end
#latem
set latemValue to ""
set latemValue to radioLatem's stringValue as string
if latemValue = "1"
set location to "Latem"
end
#lier
set lierValue to ""
set lierValue to radioLier's stringValue as string
if lierValue = "1"
set location to "Lier"
end
#noorderlaan
set noorderlaanValue to ""
set noorderlaanValue to radioNoorderlaan's stringValue as string
if noorderlaanValue = "1"
set location to "Noorderlaan"
end
#oostende
set oostendeValue to ""
set oostendeValue to radioOostende's stringValue as string
if oostendeValue = "1"
set location to "Oostende"
end
#theater
set theaterValue to ""
set theaterValue to radioTheater's stringValue as string
if theaterValue = "1"
set location to "Theater"
end
#wijnegem
set wijnegemValue to ""
set wijnegemValue to radioWijnegem's stringValue as string
if wijnegemValue = "1"
set location to "Wijnegem"
end
#waasland
set waaslandValue to ""
set waaslandValue to radioWaasland's stringValue as string
if waaslandValue = "1"
set location to "Waasland"
end


set theFullNumber to "0032" & (stringValue() of phoneNumber)
set theShortNumber to (do shell script "echo \"" & theFullNumber & "\" | sed 's/00320/0032/g'")

#SetXML
set theXMLString to "<MESSAGES><AUTHENTICATION><PRODUCTTOKEN>your-token</PRODUCTTOKEN></AUTHENTICATION><MSG><FROM>Company</FROM><TO>" & theShortNumber & "</TO><BODY>Je " & typeString & " (" & (stringValue() of daveReference) & ") is beschikbaar te Shop " & location & conditions & ". Mvg</BODY><REFERENCE>" & (stringValue() of daveReference) & "</REFERENCE></MSG></MESSAGES>"
        set curl_command to "curl -i https://sgw01.cm.nl/gateway.ashx -X POST -H \"Content-type: application/xml\" -d  \"" & theXMLString & "\""
        
        try
            --display dialog theXMLString
            do shell script curl_command
            set textFieldValue to "Je bericht werd succesvol verzonden.   " & theXMLString
        on error error_message
             set textFieldValue to "Er liep iets mis: " & error_message
        end try
    resultMessage's setString_(textFieldValue)
    --delay 15
    --set resetFieldValue to ""
    --resultMessage's setString_(resetFieldValue)
return theXMLString

end buttonClicked_

    on radioClicked_(Sender)
    end radioClicked_

    on radioTypeClicked_(Sender)
    end radioTypeClicked_

	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script
