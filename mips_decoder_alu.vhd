library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity aludec is -- ALU control decoder
  port(funct:      in  STD_LOGIC_VECTOR(5 downto 0);
       aluop:      in  STD_LOGIC_VECTOR(2 downto 0);
       alucontrol: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture behave of aludec is
begin
  process(aluop, funct) begin
    case aluop is
      when "000" => alucontrol <= "0010"; -- add (for lb/sb/addi)
      when "001" => alucontrol <= "0110"; -- sub (for beq)
      when "011" => alucontrol <= "0111"; --slti 
      when "101" => alucontrol <= "0001"; --ori

      when others => case funct is         -- R-type instructions
                         when "100000" => alucontrol <= "0010"; -- add (for add)
                         when "100010" => alucontrol <= "0110"; -- subtract (for sub)
                         when "100100" => alucontrol <= "0000"; -- logical and (for and)
                         when "100101" => alucontrol <= "0001"; -- logical or (for or)
                         when "101010" => alucontrol <= "0111"; -- set on less (for slt)
                         when "000000" => alucontrol <= "1110"; -- sll
                         when "000010" => alucontrol <= "1111"; -- srl
                         when others   => alucontrol <= "----"; -- should never happen
                     end case;
    end case;
  end process;
end;

