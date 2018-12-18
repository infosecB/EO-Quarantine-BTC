# EO-Quarantine-Sextortion
A PowerShell cmdlet that creates a transport rule in Exchange Online to quarantine [Sextortion-style messages](https://krebsonsecurity.com/2018/07/sextortion-scam-uses-recipients-hacked-passwords/).

## Introduction

## Usage

You must first [authenticate and connect to Exchange Online](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell) using an account with the [appropriate permissions](https://docs.microsoft.com/en-us/exchange/permissions-exo/permissions-exo). Here's the Powershell command you can use to connect to an Exchange Online instance that is not behind MFA here:

```powershell
Import-PSSession $(New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $(Get-Credential) -Authentication Basic -AllowRedirection) -DisableNameChecking
```
If you are required to authenticate against MFA, [follow Microsoft's instructions](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps).


