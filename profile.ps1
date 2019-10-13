# for use with ConEmu 
## Dracula readline configuration. Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
<#
Set-PSReadlineOption -Color @{
    "Command"   = [ConsoleColor]::Green
    "Parameter" = [ConsoleColor]::Gray
    "Operator"  = [ConsoleColor]::Magenta
    "Variable"  = [ConsoleColor]::White
    "String"    = [ConsoleColor]::Yellow
    "Number"    = [ConsoleColor]::Blue
    "Type"      = [ConsoleColor]::Cyan
    "Comment"   = [ConsoleColor]::DarkCyan
}

#>


# Dracula Prompt Configuration
Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Cyan
#$GitPromptSettings.DefaultPromptSuffix.Text = '> ' # chevron unicode symbol
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta
# Dracula Git Status Configuration
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $false
#$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::DarkCyan
#$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::DarkCyan      
#$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::DarkCyan
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
