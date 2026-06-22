# Build-Module
# Remove-Module HuduAPI
# Import-Module .\Output\HuduAPI\HuduAPI.psd1
# New-MarkdownHelp -Module HuduAPI -OutputFolder .\Docs\ -Force

remove-module huduapi -Force
IMPORT-MODULE C:\Users\Administrator\Documents\GitHub\hapidev\HuduAPI\HuduAPI.psd1

New-MarkdownHelp -Module HuduAPI -OutputFolder .\Docs\ -Force