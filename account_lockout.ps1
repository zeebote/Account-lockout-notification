Function Send-OSCLockOutUser
{
	param
	(
		
		[Parameter(Mandatory=$true,Position=0)]
	    [String]$From,
		[Parameter(Mandatory=$true,Position=1)]
	    [String[]]$To,
		[Parameter(Mandatory=$true,Position=2)]
	    [String]$SMTPServer
	)
	try
	{	
		#Get newest event 4740
		$Event = Get-EventLog -LogName Security -InstanceId 4740 -Newest 1
		
		$LockedAccount = $($Event.ReplacementStrings[0])
	
		$AccountLockOutEventTime = $Event.TimeGenerated
		#Store the newest log into email boy
		$EmailBody= "Account $LockedAccount was locked out on $AccountLockOutEventTime.`n`nEvent Details:`n`n" + $Event.Message
		#Email subject
		$EmailSubj= "Account Locked Out: $LockedAccount" 
		#Create SMTP client
		$SMTPClient = New-Object Net.Mail.SMTPClient($SmtpServer)  
		#Create mailmessage object 
		$emailMessage = New-Object System.Net.Mail.MailMessage
		$emailMessage.From = "$From"
		Foreach($EmailTo in $To)
		{
		 $emailMessage.To.Add($EmailTo)
		}
		$emailMessage.Subject = $EmailSubj
		$emailMessage.Body = $EmailBody
		#Send email
		$SMTPClient.Send($emailMessage)
	}
	Catch
	{
		Write-Error $_
	}

}
$EmailFrom = fromemail@yourdomain.com
$EmailTo = toEmail@yourdomain.com
$mailhost = yourSMTPserverhost.com
Send-OSCLockOutUser -From $EmailFrom -To $EmailTo -SMTPServer $mailhost
