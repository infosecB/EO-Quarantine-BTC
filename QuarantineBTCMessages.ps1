function Set-BTCTransportRule {
    param (
        [string]$Name='Quaratine BTC messages',
        [Parameter(Mandatory=$true)]
        [ValidateSet('Test','Active')]
        [string]$Mode
    )
    
    Try{

        Get-Command New-TransportRule

    }Catch{

        Write-Error "You are not connected to Exchange Online." -ErrorAction Stop

    }

    If($Mode -eq 'Test'){

        New-TransportRule -Name $Name -Comments '' -Mode Audit -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true

    }Elseif($Mode -eq 'Active'){

        New-TransportRule -Name $Name -Comments '' -Mode Enforce -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true

    }   
}
function Remove-BTCTransportRule {
    param(
        [Parameter()]
        [string]
        $Name='Quaratine BTC messages'
    )

    Remove-TransportRule -Identity $Name -Confirm:$false
}
