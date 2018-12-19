# Quarantine-BTC-Messages
A PowerShell cmdlet that creates a transport rule in Exchange Online to quarantine [Sextortion-style messages](https://krebsonsecurity.com/2018/07/sextortion-scam-uses-recipients-hacked-passwords/).

## Usage

### Connect to Exchange Online

You must first authenticate and connect to Exchange Online using an account with the [appropriate permissions](https://docs.microsoft.com/en-us/exchange/permissions-exo/permissions-exo). Here's the Powershell command you can use to connect to an Exchange Online instance that is not behind MFA here:

```powershell
Import-PSSession $(New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $(Get-Credential) -Authentication Basic -AllowRedirection) -DisableNameChecking
```

If you are required to authenticate against MFA, this command will not work. [Follow Microsoft's special instructions here.](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps). If you are running PowerShell 5 or later, you can install the PowerShell module "ExchangeOnlineShell" from PowerShellGallery. This module contains the cmdlet "Connect-ExchangeOnlineShell" which will accomplish everything described in Microsoft's instructions linked above. Please use at your own discretion:

```powershell
Install-Module -Name ExchangeOnlineShell
```

### Set PowerShell execution policy to unrestricted

Run PowerShell as admin and run the following command to set the execution policy to unrestricted:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```

### Import the cmdlet

In PowerShell, navigate to the directory where you downloaded and extracted the script. Run the following command to to import the cmdlets:

```powershell
Import-Module .\QuarantineBTCMessages.ps1
```

### Create the transport rule in test mode

To create the transport rule in test mode, enter the following command. Setting the rule to test mode will only audit rule matches to message headers:

```powershell
Set-BTCTransportRule -Mode Test
```

### Create the transport rule in active mode

To create the transport rule in active/production mode, enter the following command. This transport rule will send any messages that match the rule to quarantine:

```powershell
Set-BTCTransportRule -Mode Active
```

### Switch the transport rule from test to active mode

To switch the rule from test to active and vice versa, simply rerun `Set-BTCTransportRule` and specify the appropriate mode.

### Remove the transport rule

Run the following command to remove the rule:

```powershell
Remove-BTCTransportRule
```



