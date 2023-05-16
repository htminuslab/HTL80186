@REM *********************************************
@REM        Assemble ROM file for I80186
@REM       Create loadsraml and loadsramh
@REM        copy files to work directory
@REM *********************************************
nasm -f bin -l %1.lst -o rom.bin %1.asm
bin2memw.exe rom.bin loadprom 0000:0000  
copy loadproml.dat ..\Modelsim
copy loadpromh.dat ..\Modelsim
