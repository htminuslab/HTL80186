-------------------------------------------------------------------------------
--  HTL80186 - CPU core                                                      --
--                                                                           --
--  https://github.com/htminuslab                                            --  
--                                                                           --
-------------------------------------------------------------------------------
-- Project       : HTL80186                                                  --
-- Module        : IP Register File                                          --
-- Library       : I80186                                                    --
--                                                                           --
-- Version       : 0.1  01/12/2007   Created HT-LAB                          --
--               : 1.1  07/05/2023   Uploaded to github under MIT license.   --
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY I80186;
USE I80186.cpu86pack.ALL;

ENTITY ipregister IS
   PORT( 
      clk    : IN     std_logic;
      ipbus  : IN     std_logic_vector (15 DOWNTO 0);
      reset  : IN     std_logic;
      wrip   : IN     std_logic;
      ipreg  : OUT    std_logic_vector (15 DOWNTO 0);
      ipfault: OUT    std_logic_vector (15 DOWNTO 0)                    -- Fault IP address (used for DIV/BOUND)
   );
END ipregister ;


architecture rtl of ipregister is

signal ipreg_s : std_logic_vector(15 downto 0);

begin

----------------------------------------------------------------------------
-- Instructon Pointer Register
----------------------------------------------------------------------------
process (clk, reset)
    begin 
        if reset='1' then
            ipreg_s <= RESET_IP_C;                                      -- See cpupack
            ipfault <= RESET_IP_C;
        elsif rising_edge(clk) then
            if (wrip='1') then  
                ipfault <= ipreg_s;     
                ipreg_s <= ipbus;  
            end if; 
        end if; 
end process;  

ipreg <= ipreg_s;

end rtl;
