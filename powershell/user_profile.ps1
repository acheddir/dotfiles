# Prompt
Import-Module posh-git
oh-my-posh init pwsh --config "$env:USERPROFILE/.config/powershell/acheddir.omp.json" | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PSFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

# Aliases
function Touch-File() {
	$fileName = $args[0]
	# Check if the file exists
	if (-not(Test-Path $fileName)) {
		New-Item -ItemType File -Name $fileName
	} else {
		# It exists. Update the timestamp
		(Get-ChildItem $fileName).LastWriteTime = Get-Date
	}
}

if (-not(Test-Path -Path Alias:touch)) {
	New-Alias -Name touch Touch-File -Force
}

function Prune-Branches() {
  g co main
  g remote update origin --prune
  git branch -vv | Select-String -Pattern ": gone]" | % { $_.toString().Trim().Split(" ")[0]} | % {git branch -d $_}
}

if (-not(Test-Path -Path Alias:g-prune)) {
  New-Alias -Name g-prune Prune-Branches -Force
}

Set-Alias c clear
Set-Alias stv standard-version
Set-Alias vim nvim
Set-Alias v vim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias wget Invoke-WebRequest
Set-Alias k kubectl
