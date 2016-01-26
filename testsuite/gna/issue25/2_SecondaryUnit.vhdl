--	This snippets reports that the specifications of test2 (line 17 and 26) are not identical.
--	Line 17 was generated by line duplication in my editor ... strange
--	Have I missed something?
--	
--	PS H:\Austausch\PoC\temp\bugreport> C:\Tools\GHDL.new\bin\ghdl.exe -a -v .\2_SecondaryUnit.vhd
--	.\2_SecondaryUnit.vhd:25:18: body of procedure "test2" does not conform with specification at .\2_SecondaryUnit.vhd:16:18
--	
package pkg is
	type T_ANGEL is range INTEGER'low to INTEGER'high units
		second;
		minute	= 60 second;
		deg			= 60 minute;
	end units;
	subtype T_PHASE is T_ANGEL range	-360 deg to 360 deg;
	
	function test1(Phase : T_PHASE := 10 second) return T_PHASE;
	procedure test2(signal output : out T_PHASE; input : T_PHASE := 10.0 second);
end package;
	
package body pkg is
	function test1(Phase : T_PHASE := 10 second) return T_PHASE is
	begin
		return Phase + 1.0 deg;
	end function;
	
	procedure test2(signal output : out T_PHASE; input : T_PHASE := 10.0 second) is
	begin
		output <= input;
	end procedure;
end package body;


use			work.pkg.all;


entity SecondaryUnit_tb is
end entity;

architecture test of SecondaryUnit_tb is
	signal TestSignal1 : T_PHASE;
	signal TestSignal2 : T_PHASE;
begin
	TestSignal1	<= test1(50.0 second);
	test2(TestSignal2, TestSignal1);
end architecture;
