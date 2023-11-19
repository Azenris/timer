# Status
![Build Windows](https://github.com/Azenris/timer/actions/workflows/build-windows.yml/badge.svg)

![Build Ubuntu](https://github.com/Azenris/timer/actions/workflows/build-ubuntu.yml/badge.svg)

# Whats it for
Just used on other projects to time the building on them.
I use it for `personal` projects.

# How To Use
Call the exe once with start "timer.exe start".
Call the exe again with end "timer.exe end".
It will output something like "Elapsed time: 5900036 microseconds (5.90004 seconds)".

# Tips
You can shorten start to s, and end to e.
You can add another argument to change the file used to store the temporary data.
By default it is "TEMP/build_time_data.bin". Relative to the current directory.
Example.
	timer.exe s "Somewhere/else/f.bin"

# How to build the build system using Cmake
```
cmake -S . -B build
cmake --build build --config=Release
cmake --build build --config=Debug
```
```
You can check the build.bat as an example.
```