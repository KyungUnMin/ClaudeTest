### 파워쉘 설정 파일 확인
```
notepad++ $PROFILE
```

### 파워쉘 설정 파일 만들기
```
New-Item -Path $PROFILE -ItemType File -Force
```

### 파워쉘 설정 파일 경로확인
```
$PROFILE
```

### 파워쉘 설정 파일 존재 여부
```
Test-Path $PROFILE
```