@echo off
echo ���b���˸m%1�i��w��
for %%i in (*.apk) do adb -s %1 install -r %%i