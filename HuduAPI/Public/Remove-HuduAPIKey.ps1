function Remove-HuduAPIKey {
	[CmdletBinding()]
	Param()
	Set-Variable -Name "Int_HuduAPIKey" -Value $null -Visibility Private -Scope script -Force
}