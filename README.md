# Account-lockout-notification
Powershell script send email notification when account being locked on Windows domain controller<br>
This script should be schedule on each domain controller on your windows domain. <br>
<br>
## How to use:<br>
1. Create new task from Windows schedule tasks
1. On General tab, configure running task with SYSTEM account
1. On Trigger tab, configure trigger on event - log security - sources Microsoft Window Security Audit - Eent ID 4740
1. On Action tab, configure run program: powershell.exe -nologo -File "Account_Lockout.ps1"
1. Save the schedule task. 
1. Update Account_Lockout.ps1 with email from, email to and mailhost variable.



