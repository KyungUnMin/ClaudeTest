# setup.ps1

# 이 ps1 파일과 같은 폴더
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 복사할 원본 파일
$source = Join-Path $scriptDir "Microsoft.PowerShell_profile.ps1"

# 실제 PowerShell 프로필 위치
$target = $PROFILE

# 원본 파일 존재 확인
if (-not (Test-Path $source)) {
    Write-Host "오류: 원본 프로필 파일이 없습니다."
    Write-Host "경로: $source"
    exit 1
}

# 기존 프로필이 존재하는 경우
if (Test-Path $target) {
    Write-Host ""
    Write-Host "PowerShell 프로필 파일이 이미 존재합니다."
    Write-Host "대상: $target"
    Write-Host ""

    $answer = Read-Host "현재 프로필을 덮어쓰시겠습니까? [Y/N]"

    if ($answer -notmatch "^[Yy]$") {
        Write-Host "복사를 취소했습니다."
        exit 0
    }
}

# 프로필 폴더가 없다면 생성
$targetDir = Split-Path -Parent $target

if (-not (Test-Path $targetDir)) {
    New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
}

# 복사 및 덮어쓰기
Copy-Item -Path $source -Destination $target -Force

Write-Host ""
Write-Host "PowerShell 프로필을 적용했습니다."
Write-Host "대상: $target"