# Whats it for
Just used on other projects to time the building on them.

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
NOTE: it will not create folder that don't exists UNLESS you build with ENABLE_FILESYSTEM.

# Building::Filesystem
To allow the program to create directories for you add -DENABLE_FILESYSTEM at the end of the defines in the build.bat
This will result in a larger exe. (on my PC 28_KB to 41_KB)