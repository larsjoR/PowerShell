# A small PowerShell module for Slack webhook messages.

Functions | Purpose
----------|--------
Write-SlackMessage | Write a simple Slack message to your channel
Write-SlackReport | Write the results of a custom report to your Slack channel

Type `Get-Help -Name <Function name>` for more info. The functions are documented. 

**Examples**

`Write-SlackMessage -WebHookUrl $myWebHook -Message "My Slack message " -Botname "MyBotName" -Icon ":nerd_face:"`

`Write-Slack-Report -WebHookUrl $WBH 
                    -Botname "RoBot" 
                    -ReportUrl "http://myurl.com" 
                    -AttachmentInfotext "Scanned 43 objects" 
                    -ReportStatus "Poor" 
                    -Author "Botroic Reporting Inc."
                    -PostIcon "http://urlToMyPng.com/pic.png" 
                    -AttachmentTitle "Status report" 
                    -AttachmentPretext "Issued by Server" 
                    -AttachmentImageUrl "http://urlTomyAttachmentImg.com/pig.png" 
                    -FooterIconUrl "http://urlTomyFooterImg.com/pog.png" `

#### An example result of the Write-SlackMessage function call

![Capture1](/images/SlackBot2.PNG)

#### An example result of Write-SlackReport function call

![Capture2](/images/SlackBot1.PNG)
