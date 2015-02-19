@echo off
echo ===Umple Compilation Automation Script===
echo ---Created by Kenneth C.---
echo ---Licensed under GPLv3---
set umplejar=umple.jar
set /p source="Input source file name: "
echo 1- Class Diagram
echo 2- State Diagram
echo 3- Java source
echo 4- Generate one-click batch file for this source file
set /p option="Select an option: "

if %option% == 1 goto Class
if %option% == 2 goto State
if %option% == 3 goto Java
if %option% == 4 goto Batch
goto:eof

:Batch
echo 1- Class Diagram
echo 2- State Diagram
echo 3- Java source
set /p option="Select an option: "

if %option% == 1 goto GenClass
if %option% == 2 goto GenState
if %option% == 3 goto GenJava
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
set source=%source:~0,-4%
goto GenGraphvizclass

:GenState
set batname=%source%.stategen.bat
echo @echo off >> %batname%
echo echo Compiling Umple source to GraphViz state diagram.... >> %batname%
echo java -jar %umplejar% %source% -g GvStateDiagram >> %batname%
set source=%source:~0,-4%
goto GenGraphvizstate

:GenGraphvizclass
echo echo Generating diagram image.... >> %batname%
echo .\release\bin\dot.exe -Tpng "%source%cd.gv" -o "%source%.png" >> %batname%
goto GenDone

:GenGraphvizstate
echo echo Generating diagram image.... >> %batname%
echo .\release\bin\dot.exe -Tpng "%source%.gv" -o "%source%.png" >> %batname%
goto GenDone

:GenDone
echo echo Completed >> %batname%
echo echo This batch was generated using the Umple Generation Automation Script >> %batname%
echo pause >> %batname%
goto Done

:Java
echo Generating Java source from Umple....
java -jar %umplejar% %source% -g Java
goto Done

:Class
echo Compiling Umple source to GraphViz class diagram....
java -jar %umplejar% %source% -g GvClassDiagram
set source=%source:~0,-4%
goto Graphvizclass

:State
echo Compiling Umple source to GraphViz state diagram....
java -jar %umplejar% %source% -g GvStateDiagram
set source=%source:~0,-4%
goto Graphvizstate

:Graphvizclass
echo Generating diagram image....
.\release\bin\dot.exe -Tpng "%source%cd.gv" -o "%source%.png"
goto Done

:Graphvizstate
echo Generating diagram image....
.\release\bin\dot.exe -Tpng "%source%.gv" -o "%source%.png"
goto Done

:Done
echo Completed
pause
goto:eof