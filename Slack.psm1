Function Write-SlackReport {
      <# 
       .SYNOPSIS 
       This function can be used for status updates on reports executed by scripts. 
       .DESCRIPTION 
       This function attaches a status report update, and you can choose to alter the color 
       of the attachment bar, based on the keywords "Good", "Poor" or "Bad" which are passed in as the parameter "ReportStatus".
       Also you can alter the name of the bot, the text content and author of the post. You can modify your report look by adding
       urls to .png icons wherever you want. 

       All fields are mandatory, except 'AttachmentPretext', 'AttachmentImageUrl' and 'FooterIconUrl'.
       .EXAMPLE 
       Write-Slack-Report -WebHookUrl $WBH `
                   -Botname "RoBot" `
                   -ReportUrl "http://myurl.com" `
                   -AttachmentInfotext "Scanned 43 objects" `
                   -ReportStatus "Poor" `
                   -Author "Botroic Reporting Inc." `
                   -PostIcon "http://urlToMyPng.com/pic.png" `
                   -AttachmentTitle "Status report" `
                   -AttachmentPretext "Issued by Server" `
                   -AttachmentImageUrl "http://urlTomyAttachmentImg.com/pig.png" `
                   -FooterIconUrl "http://urlTomyFooterImg.com/pog.png"
       .EXAMPLE 
       Write-Slack-Report -WebHookUrl $WBH `
                   -Botname "Matax" `
                   -ReportUrl "#" `
                   -AttachmentInfotext $InfoText `
                   -ReportStatus "Bad" `
                   -Author "Matralax Reporting Inc." `
                   -PostIcon $PostIcon `
                   -AttachmentTitle "Status report" `
                   -AttachmentPretext $AttachmentPretext `
                   -AttachmentImageUrl $AttImgUrl `
                   -FooterIconUrl $FooterIconUrl

       .PARAMETER WebHookUrl 
       The URL to the Slack incoming-webhook
       .PARAMETER Botname 
       The name of reporting BOT
       .PARAMETER ReportUrl
       The URI of the report you wish to link to 
       .PARAMETER AttachmentInfoText
       The text that will appear as info in the attachment
       .PARAMETER ReportStatus
       String parameter, valid values are: "Good", "Poor" and "Bad". Will decide the color of the output (green, yellow and red).
       .PARAMETER Author
       The name of the author of the report 
       .PARAMETER PostIcon
       The url of the icon for the posting bot - .png format. Slack emoji formats are accepted as well.
       .PARAMETER AttachmentTitle 
       The title of the attachment
        .PARAMETER AttachmentPretext
       The descriptive pretext of the attachment
       .PARAMETER AttachmentImageUrl
       The url of the image for the attachment (company brand etc.) .png format. Slack emoji formats accepted.
       .PARAMETER FooterIconUrl
       The thumbnail appearing before the signature field in the attachment. (.png or slack emoji format)
      #> 


    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$WebHookUrl,
        [Parameter(Mandatory = $true)]
        [String]$Botname,
        [Parameter(Mandatory = $true)]
        [String]$ReportUrl,
        [Parameter(Mandatory = $true)]
        [String]$AttachmentInfotext,
        [Parameter(Mandatory = $true)]
        [String]$ReportStatus,
        [Parameter(Mandatory = $true)]
        [String]$Author,
        [Parameter(Mandatory = $true)]
        [String]$PostIcon,
        [Parameter(Mandatory = $true)]
        [String]$AttachmentTitle,
        [Parameter(Mandatory = $false)]
        [String]$AttachmentPretext,
        [Parameter(Mandatory = $false)]
        [String]$AttachmentImageUrl,
        [Parameter(Mandatory = $false)]
        [String]$FooterIconUrl
    )

    BEGIN {

        $Red = "#FF0000"
        $Yellow = "#FFFF00"
        $Green = "#36a64f"
        $Color = ""

        $FooterMessage = "Brought to you by -" + $Botname + " BOT-"

        Switch ($ReportStatus) {
            "Good" { $Color = $Green }
            "Poor" { $Color = $Yellow }
            "Bad"  { $Color = $Red }
            default { $Color = "#D4CDCC"}
        }


        $AttachmentFields = @{
                            title = "Status";
                            value = $ReportStatus;
                            short = "false";  
                          } 

        $Attachments = @{
                          fallback = "This is the fallback";
                          color = $Color;
                          pretext = $AttachmentPretext;
                          author_name = $Author;
                          author_link = "#";
                          author_icon = ":grinning:";
                          title = $AttachmentTitle;
                          title_link = $ReportUrl;
                          text = $AttachmentInfotext;
                          fields = @( $AttachmentFields )
                          image_url = $AttachmentImageUrl;
                     #     thumb_url = $AttachmentThumbUrl;
                          footer = $FooterMessage
                          footer_icon = $FooterIconUrl
                          } 


        $Payload = @{    text ="Automatic PowerShell reporting cycle completed";
                         username = $Botname; 
                         icon_emoji = $PostIcon;
                         attachments = @( $Attachments ); 
                         mrkdwn = $true 
                     } | ConvertTo-Json -Depth 5
        
    }

    PROCESS {
    
         Invoke-WebRequest -Uri $WebHookUrl -ContentType application/json -Method POST -Body $Payload -UseBasicParsing | Out-Null
    }

    END {

         Write-Host "Message posted to Slack"
    }
}


Function Write-SlackMessage {
    <# 
      .SYNOPSIS
      This function allows you to post a simple slack message into a channel, based on a web-hook url.
      .DESCRIPTION
      Use this function to send a simple slack message to a channel.
      .EXAMPLE
      Write-Slack-Message -WebHookUrl $myWebHookUrl -Message "This is a simple message" -Botname "Matrix" -Icon ":8ball:"
      .PARAMETER WebHookUrl
      The Url of the Slack incoming-webhook
      .PARAMETER Message
      The simple message you want to post
      .PARAMETER Botname
      The name of the bot
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$WebHookUrl,
        [Parameter(Mandatory = $true)]
        [String]$Message, 
        [Parameter(Mandatory = $true)]
        [String]$Botname,
        [Parameter(Mandatory = $false)]
        [String]$Icon 

    )

    BEGIN {
        $Payload = @{ text = $Message; username = $Botname; icon_emoji = $icon } | ConvertTo-Json
    }

    PROCESS {
        Invoke-WebRequest -Uri $WebHookUrl -ContentType application/json -Method POST -Body $Payload  -UseBasicParsing | Out-Null 
    }

    END {
        Write-Host -Message "Message posted to Slack"
    }
}

Export-ModuleMember Write-SlackReport
Export-ModuleMember Write-SlackMessage 