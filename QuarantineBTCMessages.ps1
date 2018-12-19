function Set-BTCTransportRule {
    param (
        [string]$Name = 'Quaratine BTC messages',
        [Parameter(Mandatory = $true)]
        [ValidateSet('Test', 'Active')]
        [string]$Mode
    )
    
    Try {

        Get-Command New-TransportRule | Out-Null

    }
    Catch {

        Write-Error "You are not connected to Exchange Online." -ErrorAction Stop

    }

    If ($Mode -eq 'Test') {

        If (Get-TransportRule -Identity $Name -ErrorAction SilentlyContinue) {

            Set-TransportRule -Identity $Name -Mode Audit

            Write-Host "The rule '$name' was updated to run in test mode."

        }
        Else {

            New-TransportRule -Name $Name -Comments '' -Mode Audit -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true
            Write-Host "The rule '$name' was created to run in test mode."
        
        }

    }
    Elseif ($Mode -eq 'Active') {
        
        If (Get-TransportRule -Identity $Name -ErrorAction SilentlyContinue) {

            Set-TransportRule -Identity $Name -Mode Enforce

        }
        Else {
        
            New-TransportRule -Name $Name -Comments '' -Mode Enforce -SubjectOrBodyContainsWords 'bitcoin', 'btc' -SubjectOrBodyMatchesPatterns '([13][a-km-zA-HJ-NP-Z0-9]{26,33})' -SetAuditSeverity 'Low' -Quarantine $true
        }   
    }
}

function Remove-BTCTransportRule {
    param(
        [Parameter()]
        [string]
        $Name = 'Quaratine BTC messages'
    )

    Try {

        Get-Command New-TransportRule | Out-Null

    }
    Catch {

        Write-Error "You are not connected to Exchange Online." -ErrorAction Stop

    }
    
    If (Get-TransportRule -Identity $Name -ErrorAction SilentlyContinue) {

        Try {
            
            Remove-TransportRule -Identity $Name -Confirm:$false
            Write-Host "The rule '$Name' was removed successfully."

        }
        Catch {

            Write-Error "Could not remove the rule" -ErrorAction Stop

        }
    }
    Else {

        Write-Error "The rule '$Name' does not exist" -ErrorAction Stop

    }
}
