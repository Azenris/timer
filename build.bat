@echo OFF
cls

:: Automatically runs C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat
if NOT defined VSCMD_ARG_TGT_ARCH (
	call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
)

:: -O2					= Creates fast code.
:: -Ot					= Favors fast code.
:: -GF					= Enables string pooling.
:: -GR-					= Disable RTTI.
:: -Z7					= Produces object files that also contain full symbolic debugging information.
:: -Zc:preprocessor		= Use the new conforming preprocessor.
:: -Zc:strictStrings	= Disable string-literal to char*
:: -MD					= Compiles to create a multithreaded DLL, by using MSVCRT.lib.
:: -MDd					= Compiles to create a debug multithreaded DLL, by using MSVCRTD.lib.
:: -LD					= Creates a dynamic-link library.
:: -W0 -W1 -W2 -W3 -W4 	= Set output warning level.
:: -wd<Number> 			= Disable a specific warning.
:: -WX 					= Treat warnings as errors.
:: -FC 					= Displays the full path of source code files passed to cl.exe in diagnostic text.

:: To allow the program to create directories for you. Add -DENABLE_FILESYSTEM at the end of the defines
:: This will result in a larger exe.

SET debugMode=0
SET name=timer
SET buildDir=TEMP\
SET objectDir=%buildDir%Objects\
SET warnings=-WX -W4 -wd4100 -wd4201 -wd4706
SET includes=-Ithird_party\
SET defines=-DC_PLUS_PLUS -D_CRT_SECURE_NO_WARNINGS
SET links=
SET flags=-std:c++20 -Zc:preprocessor -Zc:strictStrings -GR- -EHsc

if %debugMode% == 1 (
	SET defines=%defines% -DDEBUG
	SET flags=%flags% -Z7 -FC -MDd
) else (
	SET flags=%flags% -MD -O2 -Ot -GF
)

if not exist %buildDir% ( mkdir %buildDir% )
if not exist %objectDir% ( mkdir %objectDir% )

del %buildDir%*.pdb > NUL 2> NUL

SET commands=-nologo %flags% %warnings% %defines% %math%

cl %commands% -Fe%buildDir%%name%.exe -Fo%objectDir% src\main.cpp %includes% %links% -INCREMENTAL:NO
if not %ERRORLEVEL% == 0 ( goto build_failed )

:build_success
echo Build success!
goto build_end

:build_failed
echo Build failed.
goto build_end

:build_end