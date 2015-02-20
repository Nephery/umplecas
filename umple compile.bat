@echo off
echo ===Umple Compilation Automation Script===
echo ---Created by Kenneth C.---
echo ---Licensed under GPLv3---
set umplejar=Umple.jar
set graphvizdir=GraphVizDirectory

echo 1- Dialog Search
echo 2- Command Line Search
set /p select="Select an Umple code search method: "

if %select% == 1 (for /f "delims=" %%A in ( ' java UmpleCodeFinder ' ) do set source=%%A
					goto Next)
if %select% == 2 (set /p source="Input source file name: "
					goto Next)
goto:eof

:Next
echo 1- Class Diagram
echo 2- State Diagram
echo 3- Java source
echo 4- Generate one-click batch file for this source file
set /p option0="Select an option: "

if %option0% == 1 goto Class
if %option0% == 2 goto State
if %option0% == 3 goto Java
if %option0% == 4 goto Batch
goto:eof

:Batch
echo 1- Class Diagram
echo 2- State Diagram
echo 3- Java source
set /p option1="Select an option: "

if %option1% == 1 goto GenClass
if %option1% == 2 goto GenState
if %option1% == 3 goto GenJava
goto:eof

:GenJava
set batname=%source%.javagen.bat
echo @echo off >> %batname%
echo echo Generating Java source from Umple.... >> %batname%
echo java -jar %umplejar% %source% -g Java >> %batname%
goto GenDone

:GenClass
set batname=%source%.classgen.bat
echo @echo off >> %batname%
echo echo Compiling Umple source to GraphViz class diagram.... >> %batname%
echo java -jar %umplejar% %source% -g GvClassDiagram >> %batname%
for /f "tokens=* delims=" %%P in (%source%) do ( 
	set source=%%P
)
set source=%source:~0,-4%
goto GenGraphvizclass

:GenState
set batname=%source%.stategen.bat
echo @echo off >> %batname%
echo echo Compiling Umple source to GraphViz state diagram.... >> %batname%
echo java -jar %umplejar% %source% -g GvStateDiagram >> %batname%
for /f "tokens=* delims=" %%P in (%source%) do (
	set source=%%P
)
set source=%source:~0,-4%
goto GenGraphvizstate

:GenGraphvizclass
echo echo Generating diagram image.... >> %batname%
echo "%graphvizdir%\release\bin\dot.exe" -Tpng "%source%cd.gv" -o "%source%.png" >> %batname%
goto GenDelete

:GenGraphvizstate
echo echo Generating diagram image.... >> %batname%
echo "%graphvizdir%\release\bin\dot.exe" -Tpng "%source%.gv" -o "%source%.png" >> %batname%
goto GenDelete

:GenDelete
echo echo Deleting GraphViz file.... >> %batname%
if %option1% == 1 echo del "%source%cd.gv" >> %batname%
if %option1% == 2 echo del "%source%.gv" >> %batname%
goto GenDone

:GenDone
echo echo Completed >> %batname%
echo echo This batch was generated using the Umple Compilation Automation Script >> %batname%
echo pause >> %batname%
goto Done

:Java
echo Generating Java source from Umple....
java -jar %umplejar% %source% -g Java
goto Done

:Class
echo Compiling Umple source to GraphViz class diagram....
java -jar %umplejar% %source% -g GvClassDiagram
for /f "tokens=* delims=" %%P in (%source%) do (
    set source=%%P
)
set source=%source:~0,-4%
goto Graphvizclass

:State
echo Compiling Umple source to GraphViz state diagram....
java -jar %umplejar% %source% -g GvStateDiagram
for /f "tokens=* delims=" %%P in (%source%) do (
    set source=%%P
)
set source=%source:~0,-4%
goto Graphvizstate

:Graphvizclass
echo Generating diagram image....
"%graphvizdir%\release\bin\dot.exe" -Tpng "%source%cd.gv" -o "%source%.png"
goto Delete

:Graphvizstate
echo Generating diagram image....
"%graphvizdir%\release\bin\dot.exe" -Tpng "%source%.gv" -o "%source%.png"
goto Delete

:Delete
echo Deleting GraphViz file....
if %option0% == 1 del "%source%cd.gv"
if %option0% == 2 del "%source%.gv"
goto Done

:Done
echo Completed
pause
goto:eof