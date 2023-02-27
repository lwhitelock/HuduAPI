Build-Module
Remove-Module HuduAPI
Import-Module .\Output\HuduAPI\HuduAPI.psd1
New-MarkdownHelp -Module HuduAPI -OutputFolder .\Docs\ -Force