function Set-BTCTransportRule {
    param (
        [switch]$Test=$false,
        [switch]$Active=$false,
        [string]$Name='Quaratine BTC messages'
    )
    
    Try{

        Get-Mailbox | Select-Object -First 1

    }Catch{

        Write-Error "You are not connected to Exchange Online." -ErrorAction Stop

    }

    If($Test){

        New-TransportRule -Name $Name -Comments '' -Mode Audit -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true

    }Else{

        New-TransportRule -Name $Name -Comments '' -Mode Enforce -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true

    }   
}

function Edit-BTCTransportRule {
    param (
        [string]$Name,
        [switch]$Test,
        [switch]
    )
    
}

function Remove-BTCTransportRule {
    param(
        [Parameter()]
        [string]
        $Name='Quaratine BTC messages'
    )

    Remove-TransportRule -Identity $Name -Confirm:$false
}
