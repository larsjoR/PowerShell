Function Push-Git {
 Param(
 [CmdletBinding()]
    [Parameter(Mandatory = $true)]
    [String]$Dir,
    [Parameter(Mandatory = $true)]
    [String]$Message
)

cd $Dir 
git add *
git commit -m $Message
git push -u origin master

}


Export-ModuleMember -Function Push-Git