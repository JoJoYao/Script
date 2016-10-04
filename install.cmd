@echo off
echo 正在給裝置%1進行安裝
for %%i in (*.apk) do adb -s %1 install -r %%i