# Write-Slack incoming web-hooks

Functions | Purpose
----------|--------
Write-Slack-Message | Write a simple Slack message to your channel
Write-Slack-Report | Write the results of a custom report to your Slack channel

**Examples**

`Write-Slack-Message -WebHookUrl $myWebHook -Message "My Slack message " -Botname "MyBotName" -Icon ":nerd_face:"`
`Write-Slack-Report -WebHookUrl $myWebHook -Botname "MyBotName" -ReportUrl "myReportUri" -AttachmentInfotext "This is a descriptive text" -ReportStatus "Poor" -Author "Testor IT"`

![Capture1](images/SlackBot2.png)
Format: ![Result of first function call]()

![Capture1](images/SlackBot1.png)
Format: ![Result of second function call]()