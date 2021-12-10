<#
Disable 365 spam filter on all mailboxes

Adapted from:

1) https://docs.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps
2) https://social.technet.microsoft.com/Forums/ie/en-US/a48b455e-0114-424f-8b0f-a8c0b88dfb0f/exchange-powershell-loop-through-all-usersmailboxes-and-run-an-exchange-command-on-the-mailbox?forum=winserverpowershell
3) https://www.nuttyabouthosting.co.uk/knowledgebase/article/how-to-set-junkmail-office365-powershell

Connection parameter assumes using delegated permissions.

#>


Connect-ExchangeOnline -DelegatedOrganization TENANTNAME.onmicrosoft.com

$mbxs = Get-Mailbox

foreach ($mbx in $mbxs) {

    Set-MailboxJunkEmailConfiguration –Enabled $False -Identity "$($mbx.Alias)"

}