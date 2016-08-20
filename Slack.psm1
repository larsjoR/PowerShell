Function Write-Slack-Report {
      <# 
       .SYNOPSIS 
       This function can be used for status updates on reports executed by scripts. 
       .DESCRIPTION 
       This function attaches a status report update, and you can choose to alter the color 
       of the attachment bar, based on the keywords "Good", "Poor" or "Bad" which are passed in as the parameter "ReportStatus".
       Also you can alter the name of the bot, the text content and author of the post. 
       .EXAMPLE 
       Write-Slack-Report -WebHookUrl $myUrl -Botname $myBotname -ReportUrl $myReportUrlSource 
                          -AttachmentInfoText "Report completed in $time seconds" -ReportStatus "Good/Poor/Bad" -Author "Timolein"
       .EXAMPLE 
       Write-Slack-Report -WebHookUrl "http://..." -Botname "Tarner" -ReportUrl "C:\reports\rep.html" -AttachmentInfoText "Manual text"
                          -ReportStatus "Good/Poor/Bad" -Author "Jumbotron" 
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
        [String]$Author

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
                          pretext = "Please read the attached status";
                          author_name = $Author;
                          author_link = "#";
                          author_icon = ":ghost:";
                          title = "See full status report";
                          title_link = $ReportUrl;
                          text = $AttachmentInfotext;
                          fields = @( $AttachmentFields )
                          image_url = "http://vignette2.wikia.nocookie.net/thecreatures/images/4/48/Yoshi.png/revision/latest?cb=20150109223009";
                          thumb_url = "https://d1tmir783i2ibf.cloudfront.net/media/p/23x23/1418047564/tmmaster_ikon.png";
                          footer = $FooterMessage
                         
                          } 


        $Payload = @{    text ="Automatic PowerShell reporting cycle completed";
                         username = $Botname; 
                         icon_emoji = ":8ball:";
                         attachments = @( $Attachments ) 
                     } | ConvertTo-Json -Depth 5
        
    }

    PROCESS {
    
         Invoke-WebRequest -Uri $WebHookUrl -ContentType application/json -Method POST -Body $Payload -UseBasicParsing | Out-Null
    }

    END {

         Write-Verbose "Message posted to Slack"
    }
}


Function Write-Slack-Message {
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
        Write-Host -Message "Slack message sent"
    }
}

Export-ModuleMember Write-Slack-Report
Export-ModuleMember Write-Slack-Message 