-------------------------------------------------------------------------------
--  HTL80186 - CPU core                                                      --
--                                                                           --
--  https://github.com/htminuslab                                            --  
--                                                                           --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Please review the terms of the license agreement before using this file.  --
-- If you are not an authorized user, please destroy this source code file   --
-- and notify HT-Lab immediately that you inadvertently received an un-      --
-- authorized copy.                                                          --
-------------------------------------------------------------------------------
-- Project       : I8086/I80186                                              --
-- Module        : Register bits Location Table                              --
-- Library       : I8088                                                     --
--                                                                           --
-- Scantable3, rev 0.9 format [Opcode][Mod-Reg-RM] => dout <= value          --
--                                                                           --
--               : 1.1  07/05/2023   Uploaded to github under MIT license.   --
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
entity r_table is
  port ( addr  : in std_logic_vector(15 downto 0);
         dout  : out std_logic_vector(2 downto 0));
end r_table;


architecture rtl of r_table is
begin
  process(addr)
  begin 
    case addr is 
       when "1110101100000000" => dout <= "000"; -- jmp  l1                       
       when "1110100100000000" => dout <= "000"; -- jmp long l1                   
       when "1111111111100000" => dout <= "001"; -- jmp  bx                       
       when "1111111100100110" => dout <= "001"; -- jmp  [0cdefh]                 
       when "1111111100100000" => dout <= "001"; -- jmp  [bx]                     
       when "1111111101100000" => dout <= "001"; -- jmp  12h[bx]                  
       when "1111111110100000" => dout <= "001"; -- jmp  1234h[bx]                
       when "1110101000000000" => dout <= "000"; -- jmp  01234h:0cdefh            
       when "1111111100101110" => dout <= "001"; -- jmp  far [0cdefh]             
       when "1111111100101000" => dout <= "001"; -- jmp  far [bx]                 
       when "1111111101101000" => dout <= "001"; -- jmp  far 12h[bx]              
       when "1111111110101000" => dout <= "001"; -- jmp  far 1234h[bx]            
       when "1110100000000000" => dout <= "000"; -- call l1                       
       when "1111111111010000" => dout <= "001"; -- call bx                       
       when "1111111100010110" => dout <= "001"; -- call [0cdefh]                 
       when "1111111100010000" => dout <= "001"; -- call [bx]                     
       when "1111111101010000" => dout <= "001"; -- call 12h[bx]                  
       when "1111111110010000" => dout <= "001"; -- call 01234h[bx]               
       when "1001101000000000" => dout <= "000"; -- call 01234h:0cdefh            
       when "1111111100011110" => dout <= "001"; -- call far ptr [l2]             
       when "1111111100011000" => dout <= "001"; -- call far ptr [bx]             
       when "1111111101011000" => dout <= "001"; -- call far ptr 012h[bx]         
       when "1111111110011000" => dout <= "001"; -- call far ptr 01234h[bx]       
       when "1100001100000000" => dout <= "000"; -- ret                           
       when "1100001000000000" => dout <= "000"; -- ret  0cdefh                   
       when "1100101100000000" => dout <= "000"; -- retf                          
       when "1100101000000000" => dout <= "000"; -- retf 0cdefh                   
       when "0111010000000000" => dout <= "000"; -- je    l2                      
       when "0111110000000000" => dout <= "000"; -- jl   l2                       
       when "0111111000000000" => dout <= "000"; -- jle  l2                       
       when "0111001000000000" => dout <= "000"; -- jb    l2                      
       when "0111011000000000" => dout <= "000"; -- jbe   l2                      
       when "0111101000000000" => dout <= "000"; -- jp    l2                      
       when "0111000000000000" => dout <= "000"; -- jo    l2                      
       when "0111100000000000" => dout <= "000"; -- js    l2                      
       when "0111010100000000" => dout <= "000"; -- jne   l2                      
       when "0111110100000000" => dout <= "000"; -- jnl   l2                      
       when "0111111100000000" => dout <= "000"; -- jnle l2                       
       when "0111001100000000" => dout <= "000"; -- jnb   l2                      
       when "0111011100000000" => dout <= "000"; -- jnbe l2                       
       when "0111101100000000" => dout <= "000"; -- jnp   l2                      
       when "0111000100000000" => dout <= "000"; -- jno   l2                      
       when "0111100100000000" => dout <= "000"; -- jns   l2                      
       when "1110001100000000" => dout <= "000"; -- jcxz l2                       
       when "1110001000000000" => dout <= "000"; -- loop l2                       
       when "1110000100000000" => dout <= "000"; -- loopz l2                      
       when "1110000000000000" => dout <= "000"; -- loopnz l2                     
       when "1100110100000000" => dout <= "000"; -- int  0cfh                     
       when "1100110000000000" => dout <= "000"; -- int  3                        
       when "1100111000000000" => dout <= "000"; -- into                          
       when "1100111100000000" => dout <= "000"; -- ret                          
       when "1111100000000000" => dout <= "000"; -- clc                           
       when "1111010100000000" => dout <= "000"; -- cmc                           
       when "1111100100000000" => dout <= "000"; -- stc                           
       when "1111110000000000" => dout <= "000"; -- cld                           
       when "1111110100000000" => dout <= "000"; -- std                           
       when "1111101000000000" => dout <= "000"; -- cli                           
       when "1111101100000000" => dout <= "000"; -- sti                           
       when "1111010000000000" => dout <= "000"; -- hlt                           
       when "1001101100000000" => dout <= "000"; -- wait                          
       when "1111000000000000" => dout <= "000"; -- lock                          
       when "1001000000000000" => dout <= "000"; -- nop                           
       when "0010011000000000" => dout <= "000"; -- db   026h                     
       when "0010111000000000" => dout <= "000"; -- db   02Eh                     
       when "0011011000000000" => dout <= "000"; -- db   036h                     
       when "0011111000000000" => dout <= "000"; -- db   03Eh                     
       when "1000100011000000" => dout <= "001"; -- mov  bl,bl                    
       when "1000100000000000" => dout <= "001"; -- mov  [bx],bl                  
       when "1000100001000000" => dout <= "001"; -- mov  12h[bx],bl               
       when "1000100010000000" => dout <= "001"; -- mov  1234h[bx],bl             
       when "1000100000000110" => dout <= "001"; -- mov  [1234h],bl               
       when "1000100111000000" => dout <= "001"; -- mov  bx,bx                    
       when "1000100100000000" => dout <= "001"; -- mov  [bx],bx                  
       when "1000100101000000" => dout <= "001"; -- mov  12h[bx],bx               
       when "1000100110000000" => dout <= "001"; -- mov  1234h[bx],bx             
       when "1000100100000110" => dout <= "001"; -- mov  [1234h],bx               
       when "1000101011000000" => dout <= "001"; -- mov  bl,al                    
       when "1000101000000000" => dout <= "001"; -- mov  bl,[bx]                  
       when "1000101001000000" => dout <= "001"; -- mov  bl,12h[bx]               
       when "1000101010000000" => dout <= "001"; -- mov  bl,1234h[bx]             
       when "1000101000000110" => dout <= "001"; -- mov  bl,[1234h]               
       when "1000101111000000" => dout <= "001"; -- mov  bx,ax                    
       when "1000101100000000" => dout <= "001"; -- mov  bx,[bx]                  
       when "1000101101000000" => dout <= "001"; -- mov  bx,12h[bx]               
       when "1000101110000000" => dout <= "001"; -- mov  bx,1234h[bx]             
       when "1000101100000110" => dout <= "001"; -- mov  bx,[1234h]               
       when "1100011000000000" => dout <= "001"; -- mov  byte ptr [bx],0abh       
       when "1100011001000000" => dout <= "001"; -- mov  byte ptr 12h[bx],0abh    
       when "1100011010000000" => dout <= "001"; -- mov  byte ptr 1234h[bx],0abh  
       when "1100011000000110" => dout <= "001"; -- mov  byte ptr [1234h],0abh    
       when "1100011011000000" => dout <= "001"; -- db   0c6h,0c3h,012h           
       when "1100011100000000" => dout <= "001"; -- mov  [bx],0abcdh              
       when "1100011101000000" => dout <= "001"; -- mov  12h[bx],0abcdh           
       when "1100011110000000" => dout <= "001"; -- mov  1234h[bx],0abcdh         
       when "1100011100000110" => dout <= "001"; -- mov  word ptr [1234h],0abcdh  
       when "1100011111000000" => dout <= "001"; -- db   0c7h,0c3h,034h,012h      
       when "1011000000000000" => dout <= "010"; -- mov  al,012H                  
       when "1011000100000000" => dout <= "010"; -- mov  cl,012H                  
       when "1011001000000000" => dout <= "010"; -- mov  dl,012H                  
       when "1011001100000000" => dout <= "010"; -- mov  bl,012H                  
       when "1011010000000000" => dout <= "010"; -- mov  ah,012H                  
       when "1011010100000000" => dout <= "010"; -- mov  ch,012H                  
       when "1011011000000000" => dout <= "010"; -- mov  dh,012H                  
       when "1011011100000000" => dout <= "010"; -- mov  bh,012H                  
       when "1011100000000000" => dout <= "010"; -- mov  ax,012H                  
       when "1011100100000000" => dout <= "010"; -- mov  cx,012H                  
       when "1011101000000000" => dout <= "010"; -- mov  dx,012H                  
       when "1011101100000000" => dout <= "010"; -- mov  bx,012H                  
       when "1011110000000000" => dout <= "010"; -- mov  sp,012H                  
       when "1011110100000000" => dout <= "010"; -- mov  bp,012H                  
       when "1011111000000000" => dout <= "010"; -- mov  si,012H                  
       when "1011111100000000" => dout <= "010"; -- mov  di,012H                  
       when "1010000000000000" => dout <= "011"; -- mov  al,[0cdefh]              
       when "1010000100000000" => dout <= "011"; -- mov  ax,[0cdefh]              
       when "1010001000000000" => dout <= "011"; -- mov  [0cdefh],al              
       when "1010001100000000" => dout <= "011"; -- mov  [0cdefh],ax              
       when "1000111011000000" => dout <= "001"; -- mov  ds,bx                    
       when "1000111000000000" => dout <= "001"; -- mov  ds,[bx]                  
       when "1000111001000000" => dout <= "001"; -- mov  ds,12h[bx]               
       when "1000111010000000" => dout <= "001"; -- mov  ds,1234h[bx]             
       when "1000111000000110" => dout <= "001"; -- mov  ds,[1234h]               
       when "1000110011000000" => dout <= "001"; -- mov  bx,ds                    
       when "1000110000000000" => dout <= "001"; -- mov  [bx],ds                  
       when "1000110001000000" => dout <= "001"; -- mov  12h[bx],ds               
       when "1000110010000000" => dout <= "001"; -- mov  1234h[bx],ds             
       when "1000110000000110" => dout <= "001"; -- mov  [1234h],ds               
       when "1111111100110000" => dout <= "001"; -- push [bx]                     
       when "1111111101110000" => dout <= "001"; -- push 12h[bx]                  
       when "1111111110110000" => dout <= "001"; -- push 1234h[bx]                
       when "1111111100110110" => dout <= "001"; -- push [1234h]                  
       when "1111111111110000" => dout <= "001"; -- db   0ffh,0f3h                    
       when "0101000000000000" => dout <= "010"; -- push ax                       
       when "0101000100000000" => dout <= "010"; -- push cx                       
       when "0101001000000000" => dout <= "010"; -- push dx                       
       when "0101001100000000" => dout <= "010"; -- push bx                       
       when "0101010000000000" => dout <= "010"; -- push sp                       
       when "0101010100000000" => dout <= "010"; -- push bp                       
       when "0101011000000000" => dout <= "010"; -- push si                       
       when "0101011100000000" => dout <= "010"; -- push di                       
       when "0000011000000000" => dout <= "011"; -- push es                       
       when "0000111000000000" => dout <= "011"; -- push cs                       
       when "0001011000000000" => dout <= "011"; -- push ss                       
       when "0001111000000000" => dout <= "011"; -- push ds                       
       when "1000111100000000" => dout <= "001"; -- pop [bx]                      
       when "1000111101000000" => dout <= "001"; -- pop 12h[bx]                   
       when "1000111110000000" => dout <= "001"; -- pop 1234h[bx]                 
       when "1000111100000110" => dout <= "001"; -- pop [1234h]                   
       when "1000111111000000" => dout <= "001"; -- db  08Fh,0c3h                 
       when "0101100000000000" => dout <= "010"; -- pop ax                        
       when "0101100100000000" => dout <= "010"; -- pop cx                        
       when "0101101000000000" => dout <= "010"; -- pop dx                        
       when "0101101100000000" => dout <= "010"; -- pop bx                        
       when "0101110000000000" => dout <= "010"; -- pop sp                        
       when "0101110100000000" => dout <= "010"; -- pop bp                        
       when "0101111000000000" => dout <= "010"; -- pop si                        
       when "0101111100000000" => dout <= "010"; -- pop di                        
       when "0000011100000000" => dout <= "011"; -- pop es                        
       when "0001011100000000" => dout <= "011"; -- pop ss                        
       when "0001111100000000" => dout <= "011"; -- pop ds                        
       when "1000011011000000" => dout <= "001"; -- xchg bl,bl                    
       when "1000011000000000" => dout <= "001"; -- xchg [bx],bl                  
       when "1000011001000000" => dout <= "001"; -- xchg 12h[bx],bl               
       when "1000011010000000" => dout <= "001"; -- xchg 1234h[bx],bl             
       when "1000011000000110" => dout <= "001"; -- xchg [1234h],bl               
       when "1000011111000000" => dout <= "001"; -- xchg bx,bx                    
       when "1000011100000000" => dout <= "001"; -- xchg [bx],bx                  
       when "1000011101000000" => dout <= "001"; -- xchg 12h[bx],bx               
       when "1000011110000000" => dout <= "001"; -- xchg 1234h[bx],bx             
       when "1000011100000110" => dout <= "001"; -- xchg [1234h],bx               
       when "1001000100000000" => dout <= "010"; -- xchg cx,ax                    
       when "1001001000000000" => dout <= "010"; -- xchg dx,ax                    
       when "1001001100000000" => dout <= "010"; -- xchg bx,ax                    
       when "1001010000000000" => dout <= "010"; -- xchg sp,ax                    
       when "1001010100000000" => dout <= "010"; -- xchg bp,ax                    
       when "1001011000000000" => dout <= "010"; -- xchg si,ax                    
       when "1001011100000000" => dout <= "010"; -- xchg di,ax                    
       when "1110010000000000" => dout <= "000"; -- in   al,0efh                  
       when "1110010100000000" => dout <= "000"; -- in   ax,0efh                  
       when "1110110000000000" => dout <= "000"; -- in   al,dx                    
       when "1110110100000000" => dout <= "000"; -- in   ax,dx                    
       when "1110011000000000" => dout <= "000"; -- out  0efh,al                  
       when "1110011100000000" => dout <= "000"; -- out  0efh,ax                  
       when "1110111100000000" => dout <= "000"; -- out  dx,ax                    
       when "1110111000000000" => dout <= "000"; -- out  dx,al                    
       when "1101011100000000" => dout <= "000"; -- xlat                          
       when "1001111100000000" => dout <= "000"; -- lahf                          
       when "1001111000000000" => dout <= "000"; -- sahf                          
       when "1001110000000000" => dout <= "000"; -- pushf                         
       when "1001110100000000" => dout <= "000"; -- popf                          
       when "1000110100000110" => dout <= "001"; -- lea  bx,12h                   
       when "1000110100000000" => dout <= "001"; -- lea  bx,[bx]                  
       when "1000110101000000" => dout <= "001"; -- lea  bx,12h[bx]               
       when "1000110110000000" => dout <= "001"; -- lea  bx,1234h[bx]             
       when "1100010100000110" => dout <= "001"; -- lds  si,01234h                
       when "1100010100000000" => dout <= "001"; -- lds  si,[bx]                  
       when "1100010101000000" => dout <= "001"; -- lds  si,12h[bx]               
       when "1100010110000000" => dout <= "001"; -- lds  si,1234h[bx]             
       when "1100010000000110" => dout <= "001"; -- les  si,12h                   
       when "1100010000000000" => dout <= "001"; -- les  si,[bx]                  
       when "1100010001000000" => dout <= "001"; -- les  si,12h[bx]               
       when "1100010010000000" => dout <= "001"; -- les  si,1234h[bx]             
       when "0000000011000000" => dout <= "001"; -- add  bl,cl                    
       when "0000000000000110" => dout <= "001"; -- add  [0cdefh],bl              
       when "0000000000000000" => dout <= "001"; -- add  [bx],bl                  
       when "0000000001000000" => dout <= "001"; -- add  12h[bx],bl               
       when "0000000010000000" => dout <= "001"; -- add  1234h[bx],bl             
       when "0000000111000000" => dout <= "001"; -- add  bx,cx                    
       when "0000000100000110" => dout <= "001"; -- add  [0cdefh],bx              
       when "0000000100000000" => dout <= "001"; -- add  [bx],bx                  
       when "0000000101000000" => dout <= "001"; -- add  12h[bx],bx               
       when "0000000110000000" => dout <= "001"; -- add  1234h[bx],bx             
       when "0000001011000000" => dout <= "001"; -- add  bl,bl                    
       when "0000001000000110" => dout <= "001"; -- add  bl,[0cdefh]              
       when "0000001000000000" => dout <= "001"; -- add  bl,[bx]                  
       when "0000001001000000" => dout <= "001"; -- add  bl,12h[bx]               
       when "0000001010000000" => dout <= "001"; -- add  bl,1234h[bx]             
       when "0000001111000000" => dout <= "001"; -- add  bx,bx                    
       when "0000001100000110" => dout <= "001"; -- add  bx,[0cdefh]              
       when "0000001100000000" => dout <= "001"; -- add  bx,[bx]                  
       when "0000001101000000" => dout <= "001"; -- add  bx,12h[bx]               
       when "0000001110000000" => dout <= "001"; -- add  bx,1234h[bx]             
       when "1000000011000000" => dout <= "001"; -- add  bl,0cdh                  
       when "1000000000000110" => dout <= "001"; -- add  byte ptr [0cdefh],0abh   
       when "1000000000000000" => dout <= "001"; -- add  byte ptr [bx],0abh       
       when "1000000001000000" => dout <= "001"; -- add  byte ptr 12h[bx],0abh    
       when "1000000010000000" => dout <= "001"; -- add  byte ptr 1234h[bx],0abh  
       when "1000000111000000" => dout <= "001"; -- add  bx,0abcdh                
       when "1000000100000110" => dout <= "001"; -- add  [0cdefh],0abcdh          
       when "1000000100000000" => dout <= "001"; -- add  [bx],0abcdh              
       when "1000000101000000" => dout <= "001"; -- add  12h[bx],0abcdh           
       when "1000000110000000" => dout <= "001"; -- add  1234h[bx],0abcdh         
       when "1000001111000000" => dout <= "001"; -- add  bx,05bh                  
       when "1000001100000110" => dout <= "001"; -- add  word ptr [0cdefh],05bh   
       when "1000001100000000" => dout <= "001"; -- add  word ptr [bx],05bh       
       when "1000001101000000" => dout <= "001"; -- add  word ptr 12h[bx],05bh    
       when "1000001110000000" => dout <= "001"; -- add  word ptr 1234h[bx],05bh  
       when "0000010000000000" => dout <= "000"; -- add  al,0cdh                  
       when "0000010100000000" => dout <= "000"; -- add  ax,0abcdh                
       when "0001000011000000" => dout <= "001"; -- adc  bl,cl                    
       when "0001000000000110" => dout <= "001"; -- adc  [0cdefh],bl              
       when "0001000000000000" => dout <= "001"; -- adc  [bx],bl                  
       when "0001000001000000" => dout <= "001"; -- adc  12h[bx],bl               
       when "0001000010000000" => dout <= "001"; -- adc  1234h[bx],bl             
       when "0001000111000000" => dout <= "001"; -- adc  bx,cx                    
       when "0001000100000110" => dout <= "001"; -- adc  [0cdefh],bx              
       when "0001000100000000" => dout <= "001"; -- adc  [bx],bx                  
       when "0001000101000000" => dout <= "001"; -- adc  12h[bx],bx               
       when "0001000110000000" => dout <= "001"; -- adc  1234h[bx],bx             
       when "0001001011000000" => dout <= "001"; -- adc  bl,bl                    
       when "0001001000000110" => dout <= "001"; -- adc  bl,[0cdefh]              
       when "0001001000000000" => dout <= "001"; -- adc  bl,[bx]                  
       when "0001001001000000" => dout <= "001"; -- adc  bl,12h[bx]               
       when "0001001010000000" => dout <= "001"; -- adc  bl,1234h[bx]             
       when "0001001111000000" => dout <= "001"; -- adc  bx,bx                    
       when "0001001100000110" => dout <= "001"; -- adc  bx,[0cdefh]              
       when "0001001100000000" => dout <= "001"; -- adc  bx,[bx]                  
       when "0001001101000000" => dout <= "001"; -- adc bx,12h[bx]                
       when "0001001110000000" => dout <= "001"; -- adc  bx,1234h[bx]             
       when "1000000011010000" => dout <= "001"; -- adc  bl,0cdh                  
       when "1000000000010110" => dout <= "001"; -- adc  byte ptr [0cdefh],0abh   
       when "1000000000010000" => dout <= "001"; -- adc  byte ptr [bx],0abh       
       when "1000000001010000" => dout <= "001"; -- adc  byte ptr 12h[bx],0abh    
       when "1000000010010000" => dout <= "001"; -- adc  byte ptr 1234h[bx],0abh  
       when "1000000111010000" => dout <= "001"; -- adc  bx,0abcdh                
       when "1000000100010110" => dout <= "001"; -- adc  [0cdefh],0abcdh          
       when "1000000100010000" => dout <= "001"; -- adc  [bx],0abcdh              
       when "1000000101010000" => dout <= "001"; -- adc  12h[bx],0abcdh           
       when "1000000110010000" => dout <= "001"; -- adc  1234h[bx],0abcdh         
       when "1000001111010000" => dout <= "001"; -- adc  bx,05bh                  
       when "1000001100010110" => dout <= "001"; -- adc  word ptr [0cdefh],05bh   
       when "1000001100010000" => dout <= "001"; -- adc  word ptr [bx],05bh       
       when "1000001101010000" => dout <= "001"; -- adc  word ptr 12h[bx],05bh    
       when "1000001110010000" => dout <= "001"; -- adc  word ptr 1234h[bx],05bh  
       when "0001010000000000" => dout <= "000"; -- adc  al,0cdh                  
       when "0001010100000000" => dout <= "000"; -- adc  ax,0abcdh                
       when "0010100011000000" => dout <= "001"; -- sub  bl,cl                    
       when "0010100000000110" => dout <= "001"; -- sub  [0cdefh],bl              
       when "0010100000000000" => dout <= "001"; -- sub  [bx],bl                  
       when "0010100001000000" => dout <= "001"; -- sub  12h[bx],bl               
       when "0010100010000000" => dout <= "001"; -- sub  1234h[bx],bl             
       when "0010100111000000" => dout <= "001"; -- sub  bx,cx                    
       when "0010100100000110" => dout <= "001"; -- sub  [0cdefh],bx              
       when "0010100100000000" => dout <= "001"; -- sub  [bx],bx                  
       when "0010100101000000" => dout <= "001"; -- sub  12h[bx],bx               
       when "0010100110000000" => dout <= "001"; -- sub  1234h[bx],bx             
       when "0010101011000000" => dout <= "001"; -- sub  bl,bl                    
       when "0010101000000110" => dout <= "001"; -- sub  bl,[0cdefh]              
       when "0010101000000000" => dout <= "001"; -- sub  bl,[bx]                  
       when "0010101001000000" => dout <= "001"; -- sub  bl,12h[bx]               
       when "0010101010000000" => dout <= "001"; -- sub  bl,1234h[bx]             
       when "0010101111000000" => dout <= "001"; -- sub  bx,bx                    
       when "0010101100000110" => dout <= "001"; -- sub  bx,[0cdefh]              
       when "0010101100000000" => dout <= "001"; -- sub  bx,[bx]                  
       when "0010101101000000" => dout <= "001"; -- sub  bx,12h[bx]               
       when "0010101110000000" => dout <= "001"; -- sub  bx,1234h[bx]             
       when "1000000011101000" => dout <= "001"; -- sub  bl,0cdh                  
       when "1000000000101110" => dout <= "001"; -- sub  byte ptr [0cdefh],0abh   
       when "1000000000101000" => dout <= "001"; -- sub  byte ptr [bx],0abh       
       when "1000000001101000" => dout <= "001"; -- sub  byte ptr 12h[bx],0abh    
       when "1000000010101000" => dout <= "001"; -- sub  byte ptr 1234h[bx],0abh  
       when "1000000111101000" => dout <= "001"; -- sub  bx,0abcdh                
       when "1000000100101110" => dout <= "001"; -- sub  [0cdefh],0abcdh          
       when "1000000100101000" => dout <= "001"; -- sub  [bx],0abcdh              
       when "1000000101101000" => dout <= "001"; -- sub  12h[bx],0abcdh           
       when "1000000110101000" => dout <= "001"; -- sub  1234h[bx],0abcdh         
       when "1000001111101000" => dout <= "001"; -- sub  bx,05bh                  
       when "1000001100101110" => dout <= "001"; -- sub  word ptr [0cdefh],05bh   
       when "1000001100101000" => dout <= "001"; -- sub  word ptr [bx],05bh       
       when "1000001101101000" => dout <= "001"; -- sub  word ptr 12h[bx],05bh    
       when "1000001110101000" => dout <= "001"; -- sub  word ptr 1234h[bx],05bh  
       when "0010110000000000" => dout <= "000"; -- sub  al,0cdh                  
       when "0010110100000000" => dout <= "000"; -- sub  ax,0abcdh                
       when "0001100011000000" => dout <= "001"; -- sbb  bl,cl                    
       when "0001100000000110" => dout <= "001"; -- sbb  [0cdefh],bl              
       when "0001100000000000" => dout <= "001"; -- sbb  [bx],bl                  
       when "0001100001000000" => dout <= "001"; -- sbb  12h[bx],bl               
       when "0001100010000000" => dout <= "001"; -- sbb  1234h[bx],bl             
       when "0001100111000000" => dout <= "001"; -- sbb  bx,cx                    
       when "0001100100000110" => dout <= "001"; -- sbb  [0cdefh],bx              
       when "0001100100000000" => dout <= "001"; -- sbb  [bx],bx                  
       when "0001100101000000" => dout <= "001"; -- sbb  12h[bx],bx               
       when "0001100110000000" => dout <= "001"; -- sbb  1234h[bx],bx             
       when "0001101011000000" => dout <= "001"; -- sbb  bl,bl                    
       when "0001101000000110" => dout <= "001"; -- sbb  bl,[0cdefh]              
       when "0001101000000000" => dout <= "001"; -- sbb  bl,[bx]                  
       when "0001101001000000" => dout <= "001"; -- sbb  bl,12h[bx]               
       when "0001101010000000" => dout <= "001"; -- sbb  bl,1234h[bx]             
       when "0001101111000000" => dout <= "001"; -- sbb  bx,bx                    
       when "0001101100000110" => dout <= "001"; -- sbb  bx,[0cdefh]              
       when "0001101100000000" => dout <= "001"; -- sbb  bx,[bx]                  
       when "0001101101000000" => dout <= "001"; -- sbb  bx,12h[bx]               
       when "0001101110000000" => dout <= "001"; -- sbb  bx,1234h[bx]             
       when "1000000011011000" => dout <= "001"; -- sbb  bl,0cdh                  
       when "1000000000011110" => dout <= "001"; -- sbb  byte ptr [0cdefh],0abh   
       when "1000000000011000" => dout <= "001"; -- sbb  byte ptr [bx],0abh       
       when "1000000001011000" => dout <= "001"; -- sbb  byte ptr 12h[bx],0abh    
       when "1000000010011000" => dout <= "001"; -- sbb  byte ptr 1234h[bx],0abh  
       when "1000000111011000" => dout <= "001"; -- sbb  bx,0abcdh                
       when "1000000100011110" => dout <= "001"; -- sbb  [0cdefh],0abcdh          
       when "1000000100011000" => dout <= "001"; -- sbb  [bx],0abcdh              
       when "1000000101011000" => dout <= "001"; -- sbb  12h[bx],0abcdh           
       when "1000000110011000" => dout <= "001"; -- sbb  1234h[bx],0abcdh         
       when "1000001111011000" => dout <= "001"; -- sbb  bx,05bh                  
       when "1000001100011110" => dout <= "001"; -- sbb  word ptr [0cdefh],05bh   
       when "1000001100011000" => dout <= "001"; -- sbb  word ptr [bx],05bh       
       when "1000001101011000" => dout <= "001"; -- sbb  word ptr 12h[bx],05bh    
       when "1000001110011000" => dout <= "001"; -- sbb  word ptr 1234h[bx],05bh  
       when "0001110000000000" => dout <= "000"; -- sbb  al,0cdh                  
       when "0001110100000000" => dout <= "000"; -- sbb  ax,0abcdh                
       when "1111111011000000" => dout <= "001"; -- inc  cl                       
       when "1111111000000110" => dout <= "001"; -- inc  byte ptr [0cdefh]        
       when "1111111000000000" => dout <= "001"; -- inc  byte ptr [bx]            
       when "1111111001000000" => dout <= "001"; -- inc  byte ptr 12h[bx]         
       when "1111111010000000" => dout <= "001"; -- inc  byte ptr 1234h[bx]       
       when "1111111100000110" => dout <= "001"; -- inc  word ptr [0cdefh]        
       when "1111111100000000" => dout <= "001"; -- inc  word ptr [bx]            
       when "1111111101000000" => dout <= "001"; -- inc  word ptr 12h[bx]         
       when "1111111110000000" => dout <= "001"; -- inc  word ptr 1234h[bx]       
       when "0100000000000000" => dout <= "010"; -- inc  ax                       
       when "0100000100000000" => dout <= "010"; -- inc  cx                       
       when "0100001000000000" => dout <= "010"; -- inc  dx                       
       when "0100001100000000" => dout <= "010"; -- inc  bx                       
       when "0100010000000000" => dout <= "010"; -- inc  sp                       
       when "0100010100000000" => dout <= "010"; -- inc  bp                       
       when "0100011000000000" => dout <= "010"; -- inc  si                       
       when "0100011100000000" => dout <= "010"; -- inc  di                       
       when "1111111111000000" => dout <= "001"; -- db  0FFh, 0C0h                
       when "1111111011001000" => dout <= "001"; -- dec  cl                       
       when "1111111000001110" => dout <= "001"; -- dec  byte ptr [0cdefh]        
       when "1111111000001000" => dout <= "001"; -- dec  byte ptr [bx]            
       when "1111111001001000" => dout <= "001"; -- dec  byte ptr 12h[bx]         
       when "1111111010001000" => dout <= "001"; -- dec  byte ptr 1234h[bx]       
       when "1111111100001110" => dout <= "001"; -- dec  word ptr [0cdefh]        
       when "1111111100001000" => dout <= "001"; -- dec  word ptr [bx]            
       when "1111111101001000" => dout <= "001"; -- dec  word ptr 12h[bx]         
       when "1111111110001000" => dout <= "001"; -- dec  word ptr 1234h[bx]       
       when "0100100000000000" => dout <= "010"; -- dec  ax                       
       when "0100100100000000" => dout <= "010"; -- dec  cx                       
       when "0100101000000000" => dout <= "010"; -- dec  dx                       
       when "0100101100000000" => dout <= "010"; -- dec  bx                       
       when "0100110000000000" => dout <= "010"; -- dec  sp                       
       when "0100110100000000" => dout <= "010"; -- dec  bp                       
       when "0100111000000000" => dout <= "010"; -- dec  si                       
       when "0100111100000000" => dout <= "010"; -- dec  di                       
       when "1111111111001000" => dout <= "001"; -- db  0FFh, 0C8h                
       when "0011101011000000" => dout <= "001"; -- cmp  bl,bl                    
       when "0011101000000110" => dout <= "001"; -- cmp  bl,[0cdefh]              
       when "0011101000000000" => dout <= "001"; -- cmp  bl,[bx]                  
       when "0011101001000000" => dout <= "001"; -- cmp  bl,12h[bx]               
       when "0011101010000000" => dout <= "001"; -- cmp  bl,1234h[bx]             
       when "0011101111000000" => dout <= "001"; -- cmp  bx,bx                    
       when "0011101100000110" => dout <= "001"; -- cmp  bx,[0cdefh]              
       when "0011101100000000" => dout <= "001"; -- cmp  bx,[bx]                  
       when "0011101101000000" => dout <= "001"; -- cmp  bx,12h[bx]               
       when "0011101110000000" => dout <= "001"; -- cmp  bx,1234h[bx]             
       when "0011100000000110" => dout <= "001"; -- cmp  [0cdefh],bl              
       when "0011100000000000" => dout <= "001"; -- cmp  [bx],bl                  
       when "0011100001000000" => dout <= "001"; -- cmp  12h[bx],bl               
       when "0011100010000000" => dout <= "001"; -- cmp  1234h[bx],bl             
       when "0011100011000000" => dout <= "001"; -- cmp  bl,cl                    
       when "0011100100000110" => dout <= "001"; -- cmp  [0cdefh],bx              
       when "0011100100000000" => dout <= "001"; -- cmp  [bx],bx                  
       when "0011100101000000" => dout <= "001"; -- cmp  12h[bx],bx               
       when "0011100110000000" => dout <= "001"; -- cmp  1234h[bx],bx             
       when "0011100111000000" => dout <= "001"; -- cmp  bx,cx                    
       when "1000000011111000" => dout <= "001"; -- cmp  bl,0cdh                  
       when "1000000000111110" => dout <= "001"; -- cmp  byte ptr [0cdefh],0abh   
       when "1000000000111000" => dout <= "001"; -- cmp  byte ptr [bx],0abh       
       when "1000000001111000" => dout <= "001"; -- cmp  byte ptr 12h[bx],0abh    
       when "1000000010111000" => dout <= "001"; -- cmp  byte ptr 1234h[bx],0abh  
       when "1000000111111000" => dout <= "001"; -- cmp  bx,0abcdh                
       when "1000000100111110" => dout <= "001"; -- cmp  [0cdefh],0abcdh          
       when "1000000100111000" => dout <= "001"; -- cmp  [bx],0abcdh              
       when "1000000101111000" => dout <= "001"; -- cmp  12h[bx],0abcdh           
       when "1000000110111000" => dout <= "001"; -- cmp  1234h[bx],0abcdh         
       when "1000001111111000" => dout <= "001"; -- cmp  bx,05bh                  
       when "1000001100111110" => dout <= "001"; -- cmp  word ptr [0cdefh],05bh   
       when "1000001100111000" => dout <= "001"; -- cmp  word ptr [bx],05bh       
       when "1000001101111000" => dout <= "001"; -- cmp  word ptr 12h[bx],05bh    
       when "1000001110111000" => dout <= "001"; -- cmp  word ptr 1234h[bx],05bh  
       when "0011110000000000" => dout <= "000"; -- cmp  al,0cdh                  
       when "0011110100000000" => dout <= "000"; -- cmp  ax,0abcdh                
       when "1111011011011000" => dout <= "001"; -- neg  bl                       
       when "1111011000011110" => dout <= "001"; -- neg  byte ptr [0cdefh]        
       when "1111011000011000" => dout <= "001"; -- neg  byte ptr [bx]            
       when "1111011001011000" => dout <= "001"; -- neg  byte ptr 12h[bx]         
       when "1111011010011000" => dout <= "001"; -- neg  byte ptr 1234h[bx]       
       when "1111011111011000" => dout <= "001"; -- neg  bx                       
       when "1111011100011110" => dout <= "001"; -- neg  word ptr [0cdefh]        
       when "1111011100011000" => dout <= "001"; -- neg  word ptr [bx]            
       when "1111011101011000" => dout <= "001"; -- neg  word ptr 12h[bx]         
       when "1111011110011000" => dout <= "001"; -- neg  word ptr 1234h[bx]       
       when "0011011100000000" => dout <= "000"; -- aaa                           
       when "0010011100000000" => dout <= "000"; -- daa                           
       when "0011111100000000" => dout <= "000"; -- aas                           
       when "0010111100000000" => dout <= "000"; -- das                           
       when "1111011011100000" => dout <= "001"; -- mul  bl                       
       when "1111011000100110" => dout <= "001"; -- mul  byte ptr [0cdefh]        
       when "1111011000100000" => dout <= "001"; -- mul  byte ptr [bx]            
       when "1111011001100000" => dout <= "001"; -- mul  byte ptr 12h[bx]         
       when "1111011010100000" => dout <= "001"; -- mul  byte ptr 1234h[bx]       
       when "1111011111100000" => dout <= "001"; -- mul  bx                       
       when "1111011100100110" => dout <= "001"; -- mul  word ptr [0cdefh]        
       when "1111011100100000" => dout <= "001"; -- mul  word ptr [bx]            
       when "1111011101100000" => dout <= "001"; -- mul  word ptr 12h[bx]         
       when "1111011110100000" => dout <= "001"; -- mul  word ptr 1234h[bx]       
       when "1111011011101000" => dout <= "001"; -- mul  bl                      
       when "1111011000101110" => dout <= "001"; -- mul  byte ptr [0cdefh]       
       when "1111011000101000" => dout <= "001"; -- mul  byte ptr [bx]           
       when "1111011001101000" => dout <= "001"; -- mul  byte ptr 12h[bx]        
       when "1111011010101000" => dout <= "001"; -- mul  byte ptr 1234h[bx]      
       when "1111011111101000" => dout <= "001"; -- mul  bx                      
       when "1111011100101110" => dout <= "001"; -- mul  word ptr [0cdefh]       
       when "1111011100101000" => dout <= "001"; -- mul  word ptr [bx]           
       when "1111011101101000" => dout <= "001"; -- mul  word ptr 12h[bx]        
       when "1111011110101000" => dout <= "001"; -- mul  word ptr 1234h[bx]      
       when "1111011011110000" => dout <= "001"; -- div  bl                       
       when "1111011000110110" => dout <= "001"; -- div  byte ptr [0cdefh]        
       when "1111011000110000" => dout <= "001"; -- div  byte ptr [bx]            
       when "1111011001110000" => dout <= "001"; -- div  byte ptr 12h[bx]         
       when "1111011010110000" => dout <= "001"; -- div  byte ptr 1234h[bx]       
       when "1111011111110000" => dout <= "001"; -- div  bx                       
       when "1111011100110110" => dout <= "001"; -- div  word ptr [0cdefh]        
       when "1111011100110000" => dout <= "001"; -- div  word ptr [bx]            
       when "1111011101110000" => dout <= "001"; -- div  word ptr 12h[bx]         
       when "1111011110110000" => dout <= "001"; -- div  word ptr 1234h[bx]       
       when "1111011011111000" => dout <= "001"; -- div  bl                      
       when "1111011000111110" => dout <= "001"; -- div  byte ptr [0cdefh]       
       when "1111011000111000" => dout <= "001"; -- div  byte ptr [bx]           
       when "1111011001111000" => dout <= "001"; -- div  byte ptr 12h[bx]        
       when "1111011010111000" => dout <= "001"; -- div  byte ptr 1234h[bx]      
       when "1111011111111000" => dout <= "001"; -- div  bx                      
       when "1111011100111110" => dout <= "001"; -- div  word ptr [0cdefh]       
       when "1111011100111000" => dout <= "001"; -- div  word ptr [bx]           
       when "1111011101111000" => dout <= "001"; -- div  word ptr 12h[bx]        
       when "1111011110111000" => dout <= "001"; -- div  word ptr 1234h[bx]      
       when "1101010000000000" => dout <= "000"; -- aam                           
       when "1101010100000000" => dout <= "000"; -- aad                           
       when "1001100000000000" => dout <= "000"; -- cbw                           
       when "1001100100000000" => dout <= "000"; -- cwd                           
       when "1101000011000000" => dout <= "001"; -- rol  bl,1                     
       when "1101000000000110" => dout <= "001"; -- rol  byte ptr [0cdefh],1      
       when "1101000000000000" => dout <= "001"; -- rol  byte ptr [bx],1          
       when "1101000001000000" => dout <= "001"; -- rol  byte ptr 12h[bx],1       
       when "1101000010000000" => dout <= "001"; -- rol  byte ptr 1234h[bx],1     
       when "1101000111000000" => dout <= "001"; -- rol  bx,1                     
       when "1101000100000110" => dout <= "001"; -- rol  word ptr [0cdefh],1      
       when "1101000100000000" => dout <= "001"; -- rol  word ptr[bx],1           
       when "1101000101000000" => dout <= "001"; -- rol  word ptr 12h[bx],1       
       when "1101000110000000" => dout <= "001"; -- rol  word ptr 1234h[bx],1     
       when "1101001011000000" => dout <= "001"; -- rol  bl,cl                    
       when "1101001000000110" => dout <= "001"; -- rol  byte ptr [0cdefh],cl     
       when "1101001000000000" => dout <= "001"; -- rol  byte ptr [bx],cl         
       when "1101001001000000" => dout <= "001"; -- rol  byte ptr 12h[bx],cl      
       when "1101001010000000" => dout <= "001"; -- rol  byte ptr 1234h[bx],cl    
       when "1101001111000000" => dout <= "001"; -- rol  bx,cl                    
       when "1101001100000110" => dout <= "001"; -- rol  word ptr [0cdefh],cl     
       when "1101001100000000" => dout <= "001"; -- rol  word ptr[bx],cl          
       when "1101001101000000" => dout <= "001"; -- rol  word ptr 12h[bx],cl      
       when "1101001110000000" => dout <= "001"; -- rol  word ptr 1234h[bx],cl    
       when "0010000011000000" => dout <= "001"; -- and  al,bl                    
       when "0010000000000110" => dout <= "001"; -- and  [0cdefh],bl              
       when "0010000000000000" => dout <= "001"; -- and  [bx],bl                  
       when "0010000001000000" => dout <= "001"; -- and  12h[bx],bl               
       when "0010000010000000" => dout <= "001"; -- and  1234h[bx],bl             
       when "0010000111000000" => dout <= "001"; -- and  ax,bx                    
       when "0010000100000110" => dout <= "001"; -- and  [0cdefh],bx              
       when "0010000100000000" => dout <= "001"; -- and  [bx],bx                  
       when "0010000101000000" => dout <= "001"; -- and  12h[bx],bx               
       when "0010000110000000" => dout <= "001"; -- and  1234h[bx],bx             
       when "0010001011000000" => dout <= "001"; -- and  bl,bl                    
       when "0010001000000110" => dout <= "001"; -- and  bl,[0cdefh]              
       when "0010001000000000" => dout <= "001"; -- and  bl,[bx]                  
       when "0010001001000000" => dout <= "001"; -- and  bl,12h[bx]               
       when "0010001010000000" => dout <= "001"; -- and  bl,1234h[bx]             
       when "0010001111000000" => dout <= "001"; -- and  bx,bx                    
       when "0010001100000110" => dout <= "001"; -- and  bx,[0cdefh]              
       when "0010001100000000" => dout <= "001"; -- and  bx,[bx]                  
       when "0010001101000000" => dout <= "001"; -- and  bx,12h[bx]               
       when "0010001110000000" => dout <= "001"; -- and  bx,1234h[bx]             
       when "1000000011100000" => dout <= "001"; -- and  bl,0cdh                  
       when "1000000000100110" => dout <= "001"; -- and  byte ptr [0cdefh],0abh   
       when "1000000000100000" => dout <= "001"; -- and  byte ptr [bx],0abh       
       when "1000000001100000" => dout <= "001"; -- and  byte ptr 12h[bx],0abh    
       when "1000000010100000" => dout <= "001"; -- and  byte ptr 1234h[bx],0abh  
       when "1000000111100000" => dout <= "001"; -- and  bx,0abcdh                
       when "1000000100100110" => dout <= "001"; -- and  [0cdefh],0abcdh          
       when "1000000100100000" => dout <= "001"; -- and  [bx],0abcdh              
       when "1000000101100000" => dout <= "001"; -- and  12h[bx],0abcdh           
       when "1000000110100000" => dout <= "001"; -- and  1234h[bx],0abcdh         
       when "1000001111100000" => dout <= "001"; -- and  bx,05bh                  
       when "1000001100100110" => dout <= "001"; -- and  word ptr [0cdefh],05bh   
       when "1000001100100000" => dout <= "001"; -- and  word ptr [bx],05bh       
       when "1000001101100000" => dout <= "001"; -- and  word ptr 12h[bx],05bh    
       when "1000001110100000" => dout <= "001"; -- and  word ptr 1234h[bx],05bh  
       when "0010010000000000" => dout <= "000"; -- and  al,0cdh                  
       when "0010010100000000" => dout <= "000"; -- and  ax,0abcdh                
       when "0000100000000110" => dout <= "001"; -- or   [0cdefh],bl              
       when "0000100000000000" => dout <= "001"; -- or   [bx],bl                  
       when "0000100001000000" => dout <= "001"; -- or   12h[bx],bl               
       when "0000100010000000" => dout <= "001"; -- or   1234h[bx],bl             
       when "0000100011000000" => dout <= "001"; -- or   bl,cl                    
       when "0000100100000110" => dout <= "001"; -- or   [0cdefh],bx              
       when "0000100100000000" => dout <= "001"; -- or   [bx],bx                  
       when "0000100101000000" => dout <= "001"; -- or   12h[bx],bx               
       when "0000100110000000" => dout <= "001"; -- or   1234h[bx],bx             
       when "0000100111000000" => dout <= "001"; -- or   bx,cx                    
       when "0000101011000000" => dout <= "001"; -- or   bl,bl                    
       when "0000101000000110" => dout <= "001"; -- or   bl,[0cdefh]              
       when "0000101000000000" => dout <= "001"; -- or   bl,[bx]                  
       when "0000101001000000" => dout <= "001"; -- or   bl,12h[bx]               
       when "0000101010000000" => dout <= "001"; -- or   bl,1234h[bx]             
       when "0000101111000000" => dout <= "001"; -- or   bx,bx                    
       when "0000101100000110" => dout <= "001"; -- or   bx,[0cdefh]              
       when "0000101100000000" => dout <= "001"; -- or   bx,[bx]                  
       when "0000101101000000" => dout <= "001"; -- or   bx,12h[bx]               
       when "0000101110000000" => dout <= "001"; -- or   bx,1234h[bx]             
       when "1000000011001000" => dout <= "001"; -- or   bl,0cdh                  
       when "1000000000001110" => dout <= "001"; -- or   byte ptr [0cdefh],0abh   
       when "1000000000001000" => dout <= "001"; -- or   byte ptr [bx],0abh       
       when "1000000001001000" => dout <= "001"; -- or   byte ptr 12h[bx],0abh    
       when "1000000010001000" => dout <= "001"; -- or   byte ptr 1234h[bx],0abh  
       when "1000000111001000" => dout <= "001"; -- or   bx,0abcdh                
       when "1000000100001110" => dout <= "001"; -- or   [0cdefh],0abcdh          
       when "1000000100001000" => dout <= "001"; -- or   [bx],0abcdh              
       when "1000000101001000" => dout <= "001"; -- or   12h[bx],0abcdh           
       when "1000000110001000" => dout <= "001"; -- or   1234h[bx],0abcdh         
       when "1000001111001000" => dout <= "001"; -- or   bx,05bh                  
       when "1000001100001110" => dout <= "001"; -- or   word ptr [0cdefh],05bh   
       when "1000001100001000" => dout <= "001"; -- or   word ptr [bx],05bh       
       when "1000001101001000" => dout <= "001"; -- or   word ptr 12h[bx],05bh    
       when "1000001110001000" => dout <= "001"; -- or   word ptr 1234h[bx],05bh  
       when "0000110000000000" => dout <= "000"; -- or   al,0cdh                  
       when "0000110100000000" => dout <= "000"; -- or   ax,0abcdh                
       when "1000010000000110" => dout <= "001"; -- test [0cdefh],bl              
       when "1000010000000000" => dout <= "001"; -- test [bx],bl                  
       when "1000010001000000" => dout <= "001"; -- test 12h[bx],bl               
       when "1000010010000000" => dout <= "001"; -- test 1234h[bx],bl             
       when "1000010100000110" => dout <= "001"; -- test [0cdefh],bx              
       when "1000010100000000" => dout <= "001"; -- test [bx],bx                  
       when "1000010101000000" => dout <= "001"; -- test 12h[bx],bx               
       when "1000010110000000" => dout <= "001"; -- test 1234h[bx],bx             
       when "1000010011000000" => dout <= "001"; -- test bl,bl                    
       when "1000010111000000" => dout <= "001"; -- test bx,bx                    
       when "1111011011000000" => dout <= "000"; -- test bl,0cdh                  
       when "1111011000000110" => dout <= "000"; -- test byte ptr [0cdefh],0abh   
       when "1111011000000000" => dout <= "000"; -- test byte ptr [bx],0abh       
       when "1111011001000000" => dout <= "000"; -- test byte ptr 12h[bx],0abh    
       when "1111011010000000" => dout <= "000"; -- test byte ptr 1234h[bx],0abh  
       when "1111011111000000" => dout <= "000"; -- test bx,0abcdh                
       when "1111011100000110" => dout <= "000"; -- test [0cdefh],0abcdh          
       when "1111011100000000" => dout <= "000"; -- test [bx],0abcdh              
       when "1111011101000000" => dout <= "000"; -- test 12h[bx],0abcdh           
       when "1111011110000000" => dout <= "000"; -- test 1234h[bx],0abcdh         
       when "1010100000000000" => dout <= "000"; -- test al,0cdh                  
       when "1010100100000000" => dout <= "000"; -- test ax,0abcdh                
       when "0011000000000110" => dout <= "001"; -- or  [0cdefh],bl              
       when "0011000000000000" => dout <= "001"; -- or  [bx],bl                  
       when "0011000001000000" => dout <= "001"; -- or  12h[bx],bl               
       when "0011000010000000" => dout <= "001"; -- or  1234h[bx],bl             
       when "0011000011000000" => dout <= "001"; -- or  bl,cl                    
       when "0011000100000110" => dout <= "001"; -- or  [0cdefh],bx              
       when "0011000100000000" => dout <= "001"; -- or  [bx],bx                  
       when "0011000101000000" => dout <= "001"; -- or  12h[bx],bx               
       when "0011000110000000" => dout <= "001"; -- or  1234h[bx],bx             
       when "0011000111000000" => dout <= "001"; -- or  bx,cx                    
       when "0011001011000000" => dout <= "001"; -- or  bl,bl                    
       when "0011001000000110" => dout <= "001"; -- or  bl,[0cdefh]              
       when "0011001000000000" => dout <= "001"; -- or  bl,[bx]                  
       when "0011001001000000" => dout <= "001"; -- or  bl,12h[bx]               
       when "0011001010000000" => dout <= "001"; -- or  bl,1234h[bx]             
       when "0011001111000000" => dout <= "001"; -- or  bx,bx                    
       when "0011001100000110" => dout <= "001"; -- or  bx,[0cdefh]              
       when "0011001100000000" => dout <= "001"; -- or  bx,[bx]                  
       when "0011001101000000" => dout <= "001"; -- or  bx,12h[bx]               
       when "0011001110000000" => dout <= "001"; -- or  bx,1234h[bx]             
       when "1000000011110000" => dout <= "001"; -- or  bl,0cdh                  
       when "1000000000110110" => dout <= "001"; -- or  byte ptr [0cdefh],0abh   
       when "1000000000110000" => dout <= "001"; -- or  byte ptr [bx],0abh       
       when "1000000001110000" => dout <= "001"; -- or  byte ptr 12h[bx],0abh    
       when "1000000010110000" => dout <= "001"; -- or  byte ptr 1234h[bx],0abh  
       when "1000000111110000" => dout <= "001"; -- or  bx,0abcdh                
       when "1000000100110110" => dout <= "001"; -- or  [0cdefh],0abcdh          
       when "1000000100110000" => dout <= "001"; -- or  [bx],0abcdh              
       when "1000000101110000" => dout <= "001"; -- or  12h[bx],0abcdh           
       when "1000000110110000" => dout <= "001"; -- or  1234h[bx],0abcdh         
       when "1000001111110000" => dout <= "001"; -- or  bx,05bh                  
       when "1000001100110110" => dout <= "001"; -- or  word ptr [0cdefh],05bh   
       when "1000001100110000" => dout <= "001"; -- or  word ptr [bx],05bh       
       when "1000001101110000" => dout <= "001"; -- or  word ptr 12h[bx],05bh    
       when "1000001110110000" => dout <= "001"; -- or  word ptr 1234h[bx],05bh  
       when "0011010000000000" => dout <= "000"; -- or  al,0cdh                  
       when "0011010100000000" => dout <= "000"; -- or  ax,0abcdh                
       when "1111011011010000" => dout <= "001"; -- not  bl                       
       when "1111011000010110" => dout <= "001"; -- not  byte ptr [0cdefh]        
       when "1111011000010000" => dout <= "001"; -- not  byte ptr [bx]            
       when "1111011001010000" => dout <= "001"; -- not  byte ptr 12h[bx]         
       when "1111011010010000" => dout <= "001"; -- not  byte ptr 1234h[bx]       
       when "1111011111010000" => dout <= "001"; -- not  bx                       
       when "1111011100010110" => dout <= "001"; -- ord ptr [0cdefh]        
       when "1111011100010000" => dout <= "001"; -- ord ptr [bx]            
       when "1111011101010000" => dout <= "001"; -- ord ptr 12h[bx]         
       when "1111011110010000" => dout <= "001"; -- ord ptr 1234h[bx]       
       when "1010010000000000" => dout <= "000"; -- movsb                         
       when "1010010100000000" => dout <= "000"; -- movsw                         
       when "1010011000000000" => dout <= "000"; -- cmpsb                         
       when "1010011100000000" => dout <= "000"; -- cmpsw                         
       when "1010111000000000" => dout <= "000"; -- scasb                         
       when "1010111100000000" => dout <= "000"; -- scasw                         
       when "1010110000000000" => dout <= "000"; -- lodsb                         
       when "1010110100000000" => dout <= "000"; -- lodsw                         
       when "1010101000000000" => dout <= "000"; -- stosb                         
       when "1010101100000000" => dout <= "000"; -- stosw                         
       when "1111001000000000" => dout <= "000"; -- db 0F2h                       
       when "1111001100000000" => dout <= "000"; -- db 0F3h                       
       when "0110000000000000" => dout <= "000"; -- pusha                         
       when "0110000100000000" => dout <= "000"; -- popa                          
       when "0110110000000000" => dout <= "000"; -- insb                          
       when "0110110100000000" => dout <= "000"; -- insw                          
       when "0110111000000000" => dout <= "000"; -- outsb                         
       when "0110111100000000" => dout <= "000"; -- outsw                         
       when "1100100000000000" => dout <= "000"; -- enter 1234h,0                 
       when "1100100100000000" => dout <= "000"; -- leave                         
       when "0110001000000000" => dout <= "001"; -- db 062h, 07h                  
       when "0110001001000000" => dout <= "001"; -- db 062h, 05Fh, 012h           
       when "0110001010000000" => dout <= "001"; -- db 062h, 08Fh, 034h, 012h     
       when "0110001000000110" => dout <= "001"; -- db 062h, 026h, 034h, 012h     
       when "0110101000000000" => dout <= "000"; -- push 055h                     
       when "0110100000000000" => dout <= "000"; -- push 055AAh                   
       when "1100000011000000" => dout <= "001"; -- rol  bl,1eh                   
       when "1100000000000110" => dout <= "001"; -- rol  byte ptr [0cdefh],1eh    
       when "1100000000000000" => dout <= "001"; -- rol  byte ptr [bx],1eh        
       when "1100000001000000" => dout <= "001"; -- rol  byte ptr 12h[bx],1eh     
       when "1100000010000000" => dout <= "001"; -- rol  byte ptr 1234h[bx],1eh   
       when "1100000111000000" => dout <= "001"; -- rol  bx,1eh                   
       when "1100000100000110" => dout <= "001"; -- rol  word ptr [0cdefh],1eh    
       when "1100000100000000" => dout <= "001"; -- rol  word ptr[bx],1eh         
       when "1100000101000000" => dout <= "001"; -- rol  word ptr 12h[bx],1eh     
       when "1100000110000000" => dout <= "001"; -- rol  word ptr 1234h[bx],1eh   
       when "0110101111000000" => dout <= "001"; -- mul    ax,bx,08h                             
       when "0110100111000000" => dout <= "001"; -- mul    ax,bx,128h                            
       when "0110101100000110" => dout <= "001"; -- mul    bx,word ptr [0cdefh],08h              
       when "0110101100000000" => dout <= "001"; -- mul    bx,word ptr [bx],08h                  
       when "0110101101000000" => dout <= "001"; -- mul    bx,word ptr 12h[bx],08h               
       when "0110101110000000" => dout <= "001"; -- mul    bx,word ptr 1234h[bx],08h             
       when "0110100100000110" => dout <= "001"; -- mul    bx,word ptr [0cdefh],01234h           
       when "0110100100000000" => dout <= "001"; -- mul    bx,word ptr [bx],01234h               
       when "0110100101000000" => dout <= "001"; -- mul    bx,word ptr 12h[bx],01234h            
       when "0110100110000000" => dout <= "001"; -- mul    bx,word ptr 1234h[bx],01234h          
       when "1101100000000110" => dout <= "000"; -- db 0D8h, 01Eh, 034h, 12h      
       when "1101100000000000" => dout <= "000"; -- db 0D8h, 01Fh                 
       when "1101100001000000" => dout <= "000"; -- db 0D8h, 05Fh, 12h            
       when "1101100010000000" => dout <= "000"; -- db 0D8h, 09Fh, 34h, 12h       
       when "1101100011000000" => dout <= "000"; -- db 0D8h, 0D8h                 
       when "1101100100000110" => dout <= "000"; -- db 0D9h, 01Eh, 034h, 12h      
       when "1101100100000000" => dout <= "000"; -- db 0D9h, 01Fh                 
       when "1101100101000000" => dout <= "000"; -- db 0D9h, 05Fh, 12h            
       when "1101100110000000" => dout <= "000"; -- db 0D9h, 09Fh, 34h, 12h       
       when "1101100111000000" => dout <= "000"; -- db 0D9h, 0D8h                 
       when "1101101000000110" => dout <= "000"; -- db 0DAh, 01Eh, 034h, 12h      
       when "1101101000000000" => dout <= "000"; -- db 0DAh, 01Fh                 
       when "1101101001000000" => dout <= "000"; -- db 0DAh, 05Fh, 12h            
       when "1101101010000000" => dout <= "000"; -- db 0DAh, 09Fh, 34h, 12h       
       when "1101101011000000" => dout <= "000"; -- db 0DAh, 0D8h                 
       when "1101101100000110" => dout <= "000"; -- db 0DBh, 01Eh, 034h, 12h      
       when "1101101100000000" => dout <= "000"; -- db 0DBh, 01Fh                 
       when "1101101101000000" => dout <= "000"; -- db 0DBh, 05Fh, 12h            
       when "1101101110000000" => dout <= "000"; -- db 0DBh, 09Fh, 34h, 12h       
       when "1101101111000000" => dout <= "000"; -- db 0DBh, 0D8h                 
       when "1101110000000110" => dout <= "000"; -- db 0DCh, 01Eh, 034h, 12h      
       when "1101110000000000" => dout <= "000"; -- db 0DCh, 01Fh                 
       when "1101110001000000" => dout <= "000"; -- db 0DCh, 05Fh, 12h            
       when "1101110010000000" => dout <= "000"; -- db 0DCh, 09Fh, 34h, 12h       
       when "1101110011000000" => dout <= "000"; -- db 0DCh, 0D8h                 
       when "1101110100000110" => dout <= "000"; -- db 0DDh, 01Eh, 034h, 12h      
       when "1101110100000000" => dout <= "000"; -- db 0DDh, 01Fh                 
       when "1101110101000000" => dout <= "000"; -- db 0DDh, 05Fh, 12h            
       when "1101110110000000" => dout <= "000"; -- db 0DDh, 09Fh, 34h, 12h       
       when "1101110111000000" => dout <= "000"; -- db 0DDh, 0D8h                 
       when "1101111000000110" => dout <= "000"; -- db 0DEh, 01Eh, 034h, 12h      
       when "1101111000000000" => dout <= "000"; -- db 0DEh, 01Fh                 
       when "1101111001000000" => dout <= "000"; -- db 0DEh, 05Fh, 12h            
       when "1101111010000000" => dout <= "000"; -- db 0DEh, 09Fh, 34h, 12h       
       when "1101111011000000" => dout <= "000"; -- db 0DEh, 0D8h                 
       when "1101111100000110" => dout <= "000"; -- db 0DFh, 01Eh, 034h, 12h      
       when "1101111100000000" => dout <= "000"; -- db 0DFh, 01Fh                 
       when "1101111101000000" => dout <= "000"; -- db 0DFh, 05Fh, 12h            
       when "1101111110000000" => dout <= "000"; -- db 0DFh, 09Fh, 34h, 12h       
       when "1101111111000000" => dout <= "000"; -- db 0DFh, 0D8h                 
       when "0000111100000000" => dout <= "000"; -- db  00Fh                                      
       when "0110001100000000" => dout <= "000"; -- db  063h                                      
       when "0110010000000000" => dout <= "000"; -- db  064h                                      
       when "0110010100000000" => dout <= "000"; -- db  065h                                      
       when "0110011000000000" => dout <= "000"; -- db  066h                                      
       when "0110011100000000" => dout <= "000"; -- db  067h                                      
       when "1101011000000000" => dout <= "000"; -- db  0D6h                                      
       when "1111000100000000" => dout <= "000"; -- db  0F1h                                      
       when others             => dout <= "111"; 
    end case;
  end process;
end rtl;