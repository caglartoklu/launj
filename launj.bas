#lang "fblite"

option explicit

#include "vbcompat.bi"

' compile:
' fbc.exe -s gui launj.bas launj.rc

function DetectOs () as string
    ' Detects the operating system and returns a string accordingly.
    ' return "windows" or "linux".

    dim result as string

    #ifdef __fb_win32__
    result = "windows"
    #endif

    #ifdef __fb_linux__
    result = "linux"
    #endif

    DetectOs = result
end function


function PathSeparator () as string
    ' Returns the path separator, "/" or "\".
    ' Requires : DetectOs()
    dim result as string
    result = "/" ' this is the default.
    if DetectOs() = "windows" then
        result = chr(92)
    end if
    PathSeparator = result
end function


function LastPosition (haystack as string, needle as string) as integer
    ' print LastPosition("123123123", "2") ' 8
    ' print LastPosition("123123123", "12") ' 7
    ' print LastPosition("123123123", "x") ' 0

    dim position as integer
    dim maxPosition as integer
    do
        position = instr(position + 1, haystack, needle)
        if position > 0 then
            maxPosition = position
        end if
    loop until position = 0
    LastPosition = maxPosition
end function


function FindJarFileFromConfig () as string
    ' TODO: 5 find the config file and read the jar file from it.
    dim result as string
    FindJarFileFromConfig = result
end function


function ExeDirectory() as string
    ' built-in exepath function returns the directory on FreeBASIC.
    ' custom ExePath() in QB64 returns its full path with executable name.
    ' so, this function is a wrapper to make sure that directory is returned.
    ExeDirectory = exepath
end function


function ExeFileName() as string
    ' returns the exe file name only, no paths.
    ' command(0) returns the exe file name.
    ' but if it is launched from another directory as in:
    '   C:\projects\launcj\launj.exe
    ' it will return that one with directory.

    dim result as string
    dim arg as string

    arg = command(0)
    if instr(arg, chr(92)) > 0 then
        result = right(arg, len(arg) - lastposition(arg, chr(92)))
    else
        result = arg
    end if
    ExeFileName = result
end function


function ExeFileFullName() as string
    ' returns the full directory and file name of the exe file.
    dim result as string
    result = ExeDirectory + PathSeparator + ExeFileName
    ExeFileFullName = result
end function


function FindJarFileWithSameName as string
    ' Return the jar file with the same name as the exe file.
    ' it looks for the directory where the exe file resides.
    ' if the name of the exe file is myfile1.exe, it looks for myfile1.jar
    ' Otherwise, return "".

    dim possibleJarFileName as string
    dim result as string

    ' remove the ".exe" part from the end of the file, and add ".jar" instead.
    possibleJarFileName = left(ExeFileFullName, len(ExeFileFullName) - 4) + ".jar"
    if fileexists(possibleJarFileName) then
        result = possibleJarFileName
    else
        result= ""
    end if
    FindJarFileWithSameName = result
end function


function FindJarFileInSameDir() as string
    ' Find the jar file, if there is only one jar file in the directory.
    ' TODO: 5 FindJarFileInSameDir
    FindJarFileInSameDir = ""
end function


function FindJarFile as string
    ' Returns the .jar file to be launched.
    ' To do that, a list of candidates are examined.

    dim jarFile as string
    jarFile = FindJarFileFromConfig

    if jarFile = "" then
        jarFile = FindJarFileWithSameName
    end if

    FindJarFile = chr(34) + jarFile + chr(34)
end function


function FindJava as string
    ' Find java.exe by looking to path, environments etc
    ' TODO: 5 find java executable.
    FindJava = "java"
end function


sub Main
    dim i as integer
    dim cmd as string
    dim args as string
    dim arg as string

    i = 1
    do
        arg = command(i)
        if len(arg) = 0 then
            exit do
        end if
        args = args + " " + chr(34) + arg + chr(34)
        i=i+1
    loop

    cmd = FindJava + " -jar " + FindJarFile + args
    print cmd

    shell cmd

end sub

call main
