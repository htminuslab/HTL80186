@REM *********************************************
@REM        Assemble RAM file for I80186
@REM       Create loadsraml and loadsramh
@REM        copy files to work directory
@REM *********************************************
nasm -f bin -l %1.lst -o %1.com %1.asm
bin2memw.exe %1.com loadsram 0080:0100  
copy loadsraml.dat ..\Modelsim
copy loadsramh.dat ..\Modelsim
