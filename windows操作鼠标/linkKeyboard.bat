@echo off

chcp 65001

echo Removing paired device...
btpair -u

echo Searching for device...

start /B "" btpair -n "BT3.0 Keyboard" -p1234 
start "" cmd /c "C:\Users\Administrator\Desktop\mouse.bat"
