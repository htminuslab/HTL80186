-------------------------------------------------------------------------------
--  Utility Library                                                          --    
--                                                                           --
--  https://github.com/htminuslab                                            --  
--                                                                           --
-------------------------------------------------------------------------------
-- Project       :                                                           --
-- Module        : Rising_Edge strobe Flag Set/Reset                         --
--                 Assert pulse for 1 clk cycle after strobe's rising edge   --
-- Library       :                                                           --
-- Version       : 1.0  ../../1999   Created HT-LAB                          --
--               : 1.1  07/05/2023   Uploaded to github under MIT license.   --
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity rise_edge is
    GENERIC( 
        REDGECLR : integer := 0;                            -- Set to 1 for rising edge clear
                                                            -- else use level clear (active high) 
        RESLEVEL : std_logic := '1';                        -- Reset Level, active high/low
        RESDEFOUT: std_logic := '0');                       -- Default reset value for flag output
   port (clk     : in  std_logic;                           -- System Clock   
         reset   : in  std_logic;                                  
         strobe  : in  std_logic;                           -- Flag assert strobe (slow clock)
         clrflag : in  std_logic;                           -- Falling_edge clear signal
         pulse   : out std_logic;                           -- Rising edge clk wide pulse
         flag    : out std_logic);                            
end rise_edge;                
                
architecture rtl of rise_edge is                
                
    signal dind1_s : std_logic;                
    signal dind2_s : std_logic;                
    signal pulse_s : std_logic;                
                
begin                
                    
    process (clk,reset)                                     -- First delay        
        begin                
            if (reset=RESLEVEL) then                                     
                dind1_s <= '0';                              
            elsif (rising_edge(clk)) then                     
                dind1_s <= strobe;                                            
            end if;                   
    end process;                    
                
    process (clk,reset)                                     -- Second delay        
        begin                
            if (reset=RESLEVEL) then                     
                dind2_s <= '0';              
            elsif (rising_edge(clk)) then     
                dind2_s <= dind1_s;                               
            end if;   
    end process;

    ---------------------------------------------------------------------------    
    -- Rising edge Output
    ---------------------------------------------------------------------------    
    pulse_s <= '1' when (dind1_s='1' and dind2_s='0') else '0';
    pulse   <= pulse_s;                                     -- Connect to outside world

    ---------------------------------------------------------------------------    
    -- Flag Output (requires clear signal)
    --------------------------------------------------------------------------- 
    EDCLR: if REDGECLR=1 generate                           -- Clear Flag using EDGE
        process (clrflag, reset, pulse_s)        
            begin
                if (reset=RESLEVEL) then
                    flag <= RESDEFOUT;                      -- Default value upon reset   
                elsif (pulse_s='1') then   
                    flag <= NOT RESDEFOUT;      
                elsif (rising_edge(clrflag)) then 
                    flag <= RESDEFOUT;
                end if;    
        end process;
    end generate EDCLR;

    NOEDCLR: if REDGECLR=0 generate                         -- Clear Flag using Level
        process(clk,reset) 
            begin
               if (reset=RESLEVEL) then
                    flag <= RESDEFOUT;                      -- Default value upon reset   
                elsif rising_edge(clk) then
                    if (clrflag='1') then
                       flag <= RESDEFOUT;   
                    elsif pulse_s='1' then
                       flag <= NOT RESDEFOUT;
                    end if;
               end if;
        end process;
    end generate NOEDCLR;

end rtl;
