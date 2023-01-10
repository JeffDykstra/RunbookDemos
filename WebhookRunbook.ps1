param  
(  
 [Parameter (Mandatory=$false)]  
 [object] $WebhookData,
 [string] $param2 = 'defaultValue'  
)


$WebhookData
$objs = $WebhookData.RequestBody | convertfrom-json
$objs | Select-Object *

"param 2 is: $param2"