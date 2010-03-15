-- VHDL Entity R6502_TC.Reg_SP.symbol
--
-- Created:
--          by - eda.UNKNOWN (TEST)
--          at - 19:25:32 10.02.2009
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2007.1a (Build 13)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg_SP IS
   PORT( 
      adr_low_i   : IN     std_logic_vector (7 DOWNTO 0);
      clk_clk_i   : IN     std_logic;
      ld_low_i    : IN     std_logic;
      ld_sp_i     : IN     std_logic;
      rst_rst_n_i : IN     std_logic;
      sel_sp_as_i : IN     std_logic;
      sel_sp_in_i : IN     std_logic;
      adr_sp_o    : OUT    std_logic_vector (15 DOWNTO 0)
   );

-- Declarations

END Reg_SP ;

-- Jens-D. Gutschmidt     Project:  R6502_TC  
-- scantara2003@yahoo.de                      
-- COPYRIGHT (C) 2008-2009 by Jens Gutschmidt and OPENCORES.ORG                                                                                
--                                                                                                                                             
-- This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by   
-- the Free Software Foundation, either version 3 of the License, or any later version.                                                        
--                                                                                                                                             
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of              
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                                  
--                                                                                                                                             
-- You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.     
--                                                                                                                                             
-- CVS Revisins History                                                                                                                        
--                                                                                                                                             
-- $Log: not supported by cvs2svn $                                                                                                                         
--   <<-- more -->>                                                                                                                            
-- Title:  Stack Pointer Logic  
-- Path:  R6502_TC/Reg_SP/struct  
-- Edited:  by eda on 10 Feb 2009  
--
-- VHDL Architecture R6502_TC.Reg_SP.struct
--
-- Created:
--          by - eda.UNKNOWN (TEST)
--          at - 19:25:32 10.02.2009
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2007.1a (Build 13)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ARCHITECTURE struct OF Reg_SP IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL adr_sp_low_o_i  : std_logic_vector(7 DOWNTO 0);
   SIGNAL load_o_i        : std_logic;
   SIGNAL result_low1_o_i : std_logic_vector(7 DOWNTO 0);
   SIGNAL result_low_o_i  : std_logic_vector(7 DOWNTO 0);
   SIGNAL sp_as_n_o_i     : std_logic;
   SIGNAL val_one         : std_logic_vector(7 DOWNTO 0);

   -- Implicit buffer signal declarations
   SIGNAL adr_sp_o_internal : std_logic_vector (15 DOWNTO 0);


   -- ModuleWare signal declarations(v1.9) for instance 'U_0' of 'adff'
   SIGNAL mw_U_0reg_cval : std_logic_vector(7 DOWNTO 0);


BEGIN

   -- ModuleWare code(v1.9) for instance 'U_11' of 'addsub'
   u_11combo_proc: PROCESS (adr_sp_low_o_i, val_one, sp_as_n_o_i)
   VARIABLE temp_din0 : std_logic_vector(8 DOWNTO 0);
   VARIABLE temp_din1 : std_logic_vector(8 DOWNTO 0);
   VARIABLE temp_sum : unsigned(8 DOWNTO 0);
   VARIABLE temp_carry : std_logic;
   BEGIN
      temp_din0 := '0' & adr_sp_low_o_i;
      temp_din1 := '0' & val_one;
      temp_carry := '0';
      IF (sp_as_n_o_i = '1' OR sp_as_n_o_i = 'H') THEN
         temp_sum := unsigned(temp_din0) + unsigned(temp_din1) + temp_carry;
      ELSE
         temp_sum := unsigned(temp_din0) - unsigned(temp_din1) - temp_carry;
      END IF;
      result_low_o_i <= conv_std_logic_vector(temp_sum(7 DOWNTO 0),8);
   END PROCESS u_11combo_proc;

   -- ModuleWare code(v1.9) for instance 'U_0' of 'adff'
   adr_sp_o_internal(7 DOWNTO 0) <= mw_U_0reg_cval;
   u_0seq_proc: PROCESS (clk_clk_i, rst_rst_n_i)
   BEGIN
      IF (rst_rst_n_i = '0' OR rst_rst_n_i = 'L') THEN
         mw_U_0reg_cval <= "00000000";
      ELSIF (clk_clk_i'EVENT AND clk_clk_i='1') THEN
         IF (load_o_i = '1' OR load_o_i = 'H') THEN
            mw_U_0reg_cval <= result_low1_o_i;
         END IF;
      END IF;
   END PROCESS u_0seq_proc;

   -- ModuleWare code(v1.9) for instance 'U_6' of 'and'
   load_o_i <= ld_sp_i AND ld_low_i;

   -- ModuleWare code(v1.9) for instance 'U_3' of 'buff'
   adr_sp_o_internal(15 DOWNTO 8) <= val_one;

   -- ModuleWare code(v1.9) for instance 'U_4' of 'constval'
   val_one <= "00000001";

   -- ModuleWare code(v1.9) for instance 'U_2' of 'inv'
   sp_as_n_o_i <= NOT(sel_sp_as_i);

   -- ModuleWare code(v1.9) for instance 'U_8' of 'mux'
   u_8combo_proc: PROCESS(result_low_o_i, adr_low_i, sel_sp_in_i)
   BEGIN
      CASE sel_sp_in_i IS
      WHEN '0'|'L' => result_low1_o_i <= result_low_o_i;
      WHEN '1'|'H' => result_low1_o_i <= adr_low_i;
      WHEN OTHERS => result_low1_o_i <= (OTHERS => 'X');
      END CASE;
   END PROCESS u_8combo_proc;

   -- ModuleWare code(v1.9) for instance 'U_10' of 'tap'
   adr_sp_low_o_i <= adr_sp_o_internal(7 DOWNTO 0);

   -- Instance port mappings.

   -- Implicit buffered output assignments
   adr_sp_o <= adr_sp_o_internal;

END struct;
