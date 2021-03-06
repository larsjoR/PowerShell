# A small PowerShell module for Slack webhook messages.

Functions | Purpose
----------|--------
Write-SlackMessage | Write a simple Slack message to your channel
Write-SlackReport | Write the results of a small customized report to your Slack channel

Type `Get-Help -Name <Function name>` for more info and parameter listing. The functions are documented. 

**Examples**
```PowerShell
Write-SlackMessage -WebHookUrl $myWebHook -Message "My Slack message " -Botname "MyBotName" -Icon ":nerd_face:"
````
````PowerShell
Write-SlackReport -WebHookUrl $WBH 
                   -Botname "RoBot" 
                   -ReportUrl "http://myurl.com" 
                   -AttachmentInfotext "Scanned 43 objects" 
                   -ReportStatus "Poor" 
                   -Author "Botroic Reporting Inc."
                   -PostIcon "http://urlToMyPng.com/pic.png" 
                   -AttachmentTitle "Status report" 
                   -AttachmentPretext "Issued by Server" 
                   -AttachmentImageUrl "http://urlTomyAttachmentImg.com/pig.png" 
                   -FooterIconUrl "http://urlTomyFooterImg.com/pog.png" 
``` 
#### An example result of the Write-SlackMessage function call

![Capture1](/images/SlackBot2.PNG)

#### An example result of Write-SlackReport function call

![Capture2](/images/SlackBot1.PNG)
