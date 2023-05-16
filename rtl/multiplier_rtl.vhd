-------------------------------------------------------------------------------
--  HTL80186 - CPU core                                                      --
--                                                                           --
--  https://github.com/htminuslab                                            --  
--                                                                           --
-------------------------------------------------------------------------------
-- Project       : HTL80186                                                  --
-- Module        : 16x16 multiplier                                          --
-- Library       : I80186                                                    --
--                                                                           --
-- Version       : 1.0  05/21/02   Created HT-LAB                            --
--               : 1.1  07/05/2023   Uploaded to github under MIT license.   --
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity multiplier is
    generic( 
        width : integer := 16
    );
    port( 
        clk         : in  std_logic;    
        multiplicant: in  std_logic_vector (WIDTH-1 DOWNTO 0);
        multiplier  : in  std_logic_vector (WIDTH-1 DOWNTO 0);
        product     : out std_logic_vector (WIDTH+WIDTH-1 DOWNTO 0);  -- result
        twocomp     : in  std_logic
   );
END multiplier ;


architecture rtl of multiplier is

function rectify (r    : in  std_logic_vector (WIDTH-1 downto 0);       -- Rectifier for signed multiplication
                  twoc : in  std_logic)                                 -- Signed/Unsigned
  return std_logic_vector is 
  variable rec_v       : std_logic_vector (WIDTH-1 downto 0);             
begin
    if ((r(WIDTH-1) and twoc)='1') then 
        rec_v := not(r); 
    else 
        rec_v := r;
    end if;
    return (rec_v + (r(WIDTH-1) and twoc));        
end; 

signal multiplicant_s : std_logic_vector (WIDTH-1 downto 0);          
signal multiplier_s   : std_logic_vector (WIDTH-1 downto 0);          

signal product_s    : std_logic_vector (WIDTH+WIDTH-1 downto 0);        -- Result
signal sign_s       : std_logic;

begin
    
    multiplicant_s <= rectify(multiplicant,twocomp);
    multiplier_s   <= rectify(multiplier,twocomp);

    sign_s <= multiplicant(WIDTH-1) xor multiplier(WIDTH-1);            -- sign product
    
    process (clk)
        begin 
            if rising_edge(clk) then
                product_s <= multiplicant_s * multiplier_s;
                if ((sign_s and twocomp)='1') then
                    product <= (not(product_s)) + '1';                  -- correct sign
                else
                    product <= product_s;   
                end if;
            end if;
    end process;

end rtl;
