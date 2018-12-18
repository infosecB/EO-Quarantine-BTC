function New-STR {
    param (
        [switch]$Test=$false,
        [switch]$Promote=$false,
        [string]$Name='Quaratine sextortion messages'
    )
    
    Try{

        Get-Mailbox | Select-Object -First 1

    }Catch{

        Write-Error "You are not connected to Exchange Online." -ErrorAction Stop

    }

    If($Promote){

        Set-TransportRule -Identity $Name -Mode Enforce

    }ElseIf($Test){

        New-TransportRule -Name $Name -Comments '' -Mode Audit -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true

    }Else{

        New-TransportRule -Name $Name -Comments '' -Mode Enforce -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true

    }   
}

function Remove-STR {
    param(
        [Parameter()]
        [string]
        $Name='Quaratine sextortion messages'
    )

    Remove-TransportRule -Identity $Name -Confirm:$false
}
