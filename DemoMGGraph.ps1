Connect-AzAccount -Identity
$token = Get-AzAccessToken -ResourceUrl https://graph.microsoft.com
Connect-MgGraph -AccessToken $token.Token
Get-MgGroup