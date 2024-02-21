# Transitientprompt
Function Invoke-Starship-TransientFunction {
    &starship module character
}

# Functions

# Deletes command history jic
Function dieHist {
    Remove-Item -Recurse -Force $env:appdata\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
    Write-Output "History removed"
}

# Git shit

# Remove git repo
Function degit {
    $dir = $args[0]
    if ($null -eq $dir) {
        Write-Output "No directory supplied"
        break
    }
    Remove-Item -Recurse -Force "$dir/.git"
    if ("." -eq $dir) {
        Write-Output "Removed Git Repository at the current directory"
    } else {
        Write-Output "Removed Git Repository at $dir"
    }
}

# Sync git repo
Function gitsync {
    git push --quiet
    git pull --quiet
    Write-Output "Done"
}

# Touch thing
Function touch {
    $files = $args
    if ($null -eq $files) {
        Write-Output "No filename(s) supplied"
        break
    }

    foreach ($file in $files) {
        try {
            New-Item -ItemType file $file
        }
        catch {
            Write-Output "File already exists"
        }
    }
}

Function clean_dir {
    $dir = $args[0]
    if ($null -eq $dir) {
        Write-Output "No directory supplied"
        break
    }

    $files = Get-ChildItem "$dir"

    foreach ($file in $files) {
        $work = Get-Location
        $filePath = $file.ToString().Replace($work.ToString(), "").Replace("\", "/")
        
        Write-Output "Deleted $filePath"
        Remove-Item -Recurse -Force $file
    }
}

# Aliases
Set-Alias grep findstr         # findstr is grep
Set-Alias bash sh              # MINGW shell alias
Set-Alias make mingw32-make    # MINGW make alias
Set-Alias zip Compress-Archive # So i can just fukin type "zip" instead of fukmfna "Compress-Archive"

# Expressions
Invoke-Expression (&starship init powershell) # Prompt

# Transitientprompt
Enable-TransientPrompt
