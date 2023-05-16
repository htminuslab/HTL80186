@ECHO OFF
@ECHO ----------------------------------------------------------------------
@ECHO Build 360Kbyte FLASH Image from Floppy Image
@ECHO Image can be edited with WinImage (http://www.winimage.com/)
@ECHO Resulting file loadflash0.dat	should be copied to simulation directory
@ECHO ----------------------------------------------------------------------
..\..\..\bin\bin2mem.exe disk360fd.img loadflash0.dat 0000:0000 
copy loadflash0.dat .. 
