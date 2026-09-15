Set-Alias ll Get-ChildItem

function find {
    param(
        [string]$Path = ".",
        [string]$Option,
        [string]$Name
    )

    if ($Option -eq "-name") {
        Get-ChildItem -Path $Path -Recurse -Filter $Name
    }
    else {
        Get-ChildItem -Path $Path -Recurse
    }
}

function grep {
    param(
        [string]$Pattern
    )

    process {
        $_ | Out-String | Select-String -Pattern $Pattern
    }
}

# touch
function touch {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Path
    )

    foreach ($file in $Path) {
        if (Test-Path $file) {
            # 기존 파일의 수정 시간을 현재 시간으로 변경
            (Get-Item $file).LastWriteTime = Get-Date
        }
        else {
            # 파일이 없으면 새로 생성
            New-Item -ItemType File -Path $file | Out-Null
        }
    }
}

# oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\jandedobbeleer.omp.json" | Invoke-Expression

function prompt {
    $path = (Get-Location).Path
    $esc = [char]27
    "$esc[48;5;238m$esc[97m $path $esc[0m`nPS> "
}


