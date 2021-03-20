---------------------------------------------------------------
-- Arithmetic/Logic unit with add/sub, AND, OR, set less than
---------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_real.all;

entity alu is 
  generic(width: integer);
  port(a, b:       in  STD_LOGIC_VECTOR((width-1) downto 0);
       shamt:      in  STD_LOGIC_VECTOR(4 downto 0);
       alucontrol: in  STD_LOGIC_VECTOR(3 downto 0);
       result:     inout STD_LOGIC_VECTOR((width-1) downto 0);
       zero:       out STD_LOGIC);
end;

architecture behave of alu is
  signal b2, sum, slt: STD_LOGIC_VECTOR((width-1) downto 0);
  signal const_zero : STD_LOGIC_VECTOR((width-1) downto 0) := (others => '0');
  signal normResult: STD_LOGIC_VECTOR((width-1) downto 0);
  signal Testsll, Testsrl: STD_LOGIC_VECTOR((width-1) downto 0);
begin

  -- hardware inverter for 2's complement 
  b2 <= not b when alucontrol(3) = '1' else b;
  
  -- hardware adder
  sum <= a + b2 + alucontrol(3);
  
  -- slt should be 1 if most significant bit of sum is 1
  slt <= ( const_zero(width-1 downto 1) & '1') when sum((width-1)) = '1' else (others =>'0');
  
  -- determine alu operation from alucontrol bits 0 and 1
  with alucontrol(2 downto 0) select normResult <=
    a and b when "000",
    a or b  when "001", --ori and or
    sum     when "010",
    slt     when others;
	
  -- set the zero flag if result is 0
  zero <= '1' when result = const_zero else '0';

  process(a, shamt)
  begin
    for i in 0 to width-1 loop
      if shamt = STD_LOGIC_VECTOR(to_unsigned(i, width)) then
        Testsll <= STD_LOGIC_VECTOR(unsigned(a) sll i );
      end if;
    end loop;
  end process;

  process(a, shamt)
  begin
    for i in 0 to width-1 loop
      if shamt = STD_LOGIC_VECTOR(to_unsigned(i, width)) then
        Testsrl <= STD_LOGIC_VECTOR(unsigned(a) srl i );
      end if;
    end loop;
  end process;


  with alucontrol(3 downto 0) select result <=
    Testsll when "1110",
    Testsrl when "1111",
    normResult when others;
end;
