Connect-AzAccount -Identity
get-azvm | stop-azvm -Verbose -Force -AsJob | Wait-Job | Receive-Job -Verbose