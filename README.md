# touchscreen-toggle
A UI to turn a laptop's touchscreen on and off
## Install
1. Download the touchToggle.ps1 file and place it a directory of your choice (one where it won't get deleted)
2. Create a new shortcut to file
3. Right Click on the new shortcut and select properties
4. Change the Target to:
```
C:\Windows\System32\cmd.exe /c start /min "" powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\your\path\here"
```
5. Go to advanced then check run as administrator
