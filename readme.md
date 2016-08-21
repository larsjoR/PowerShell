# Write-Slack incoming webhooks

Functions | Purpose
----------|--------
Write-Slack-Message | Write a simple Slack message to your channel
Write-Slack-Report | Write the results of a custom report to your Slack channel

**Examples**

`Write-Slack-Message -WebHookUrl $myWebHook -Message "My Slack message " -Botname "MyBotName" -Icon ":nerd_face:"`

`Write-Slack-Report -WebHookUrl $myWebHook 
		    -Botname "MyBotName" 
		    -ReportUrl "myReportUri" 
	            -AttachmentInfotext "This is a descriptive text" 
		    -ReportStatus "Poor" -Author "Testor IT"`

#### The Slack result of the Write-Slack-Message function call

![Capture1](/images/SlackBot2.PNG)

#### The Slack result of the Write-Slack-Report function call

![Capture2](/images/SlackBot1.PNG)
