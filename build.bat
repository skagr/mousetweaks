rem Creates a standalone executable version of MouseTweaks
rem Note that the script works just fine without this, except you don't get the Mickey icon
rem Requirements:
rem   Autohotkey installed on PATH
rem   Ahk2Exe in a Tools directory above current (adjust accordingly)

mkdir dist
"../Tools/Ahk2Exe/Ahk2Exe" /in MouseTweaks.ahk /out dist/MouseTweaks.exe /icon MouseTweaks.ico
