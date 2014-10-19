on run
	closeNotifications()
end run

on closeNotifications()
	try
		-- This function closes all currently displaying notification alerts. It used to also return the titles of each notification, which I have commented out to disable.
		tell application "System Events"
			tell process "Notification Center"
				set theseWindows to every window whose subrole is "AXNotificationCenterAlert" or subrole is "AXNotificationCenterBanner"
				--set theseTitles to {}
				repeat with thisWindow in theseWindows
					try
						-- Save the title of each alert window:
						--set thisTitle to the value of static text 1 of scroll area 1 of thisWindow
						--set the end of theseTitles to thisTitle
						
						-- Close each alert:
						click button "Close" of thisWindow
					end try
				end repeat --"theseWindows"
				--return theseTitles
			end tell -- "NotCenter"
		end tell -- "SysEvents"
		
	on error errorMessage number errorNumber
		if errorNumber is errorNumber then
			my addAppletToAccessibilityList()
			error number -128
		end if
	end try
end closeNotifications

on addAppletToAccessibilityList()
	-- This function gets the user to enable Accessibility, for scripting the UI interface (hitting buttons etc.)
	set thisAppletFile to (path to me)
	tell application "Finder" to reveal thisAppletFile
	tell application "System Preferences"
		launch
		activate
		
		reveal anchor "Privacy_Assistive" of pane id "com.apple.preference.security"
		
		activate
		
		display alert Â
			"Add Applet to Accessibility" message "In order to respond to user clicks on Notification panels and alerts, this applet must be added to the lost of apps approved to use accessibility controls of the OS." & return & return & Â
			"To add this app:" & return & return & Â
			"1) Click the lock icon (if it is locked) and enter your password." & return & return & Â
			"2) If 'SystemUIServer.app' is in the list, check the box next to it's name." & return & return & Â
			"Otherwise, if the applet's name is in the list, check the box next to it's name. If it's not in the list, drag the applet (currently shown in the Finder) into the list area." & return & return & Â
			"3) Click the lock to re-lock the preference pane, close System Preferences."
	end tell
end addAppletToAccessibilityList
