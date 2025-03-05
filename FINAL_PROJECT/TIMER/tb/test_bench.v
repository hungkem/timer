`timescale 1ns/1ns
module test_bench();
	reg sys_clk, sys_rst_n;
	reg tim_psel, tim_pwrite, tim_penable, dbg_mode;
	reg[31:0] tim_pwdata; 
	wire[31:0] tim_prdata;
	reg[11:0] tim_paddr;
	reg[3:0] tim_pstrb;
	wire tim_pready, tim_int, tim_pslverr; 
	//address
          parameter TCR_OFFSET   = 12'h00;
          parameter TDR0_OFFSET  = 12'h04;
          parameter TDR1_OFFSET  = 12'h08;
          parameter TCMP0_OFFSET = 12'h0C;
          parameter TCMP1_OFFSET = 12'h10;
          parameter TIER_OFFSET  = 12'h14;
          parameter TISR_OFFSET  = 12'h18;
          parameter THCSR_OFFSET = 12'h1C;



	timer_top timer_top_dut(.*);
	

	// sys_clk 200MHz
	initial begin
		sys_clk = 1'b0;
		forever #2.5 sys_clk = ~sys_clk;
	end
	// sys_rst_n
	
	
	initial	begin
			sys_rst_n = 1'b0;
			#25 sys_rst_n = 1'b1;
	end
		
	


	//init value
	initial	begin
		
			tim_psel    = 0		;
			tim_paddr   = 0		;
			tim_penable = 0		;
			tim_pwrite  = 0		;
			tim_pwdata  = 0		;
			tim_pstrb   = 0		;
			dbg_mode    = 0		;
			
	end


	
	//run
	initial begin
		#40000 $finish();
	end
	
	// write tranfer
	task write(input [31:0] in_addr, 
		   input [31:0] in_data);
			begin
				$display("t = %10d DATA IS WRITTEN IN ADDRESS = %x IS %x\n", $time, in_addr, in_data);
				@(posedge sys_clk);
				#1;
				tim_paddr = in_addr;
				tim_pwrite = 1;
				tim_psel = 1;
				tim_pwdata = in_data;
				@(posedge sys_clk);
				#1;
				tim_penable = 1;
				wait(tim_pready == 1)
				@(posedge sys_clk);
				#1;
				tim_paddr = 0;
				tim_psel = 0;
				tim_pwrite = 0;
				tim_penable = 0;
				tim_pwdata = 0;
			end
	endtask
	task read(input [31:0] in_addr, 
		  output [31:0] out_data);
			begin
				@(posedge sys_clk);
				#1;
				tim_paddr = in_addr;
				tim_pwrite = 0;
				tim_psel = 1;
				@(posedge sys_clk);
				#1;
				tim_penable = 1;
				wait(tim_pready == 1);
				#1;
			       	out_data = tim_prdata;
				@(posedge sys_clk);
				tim_pwdata = 0;
				tim_paddr = 0;
				tim_pwrite = 0;
				tim_penable = 0;
				tim_psel = 0;
			$display("t = %10d REGISTER WITH ADDRESS = %x HAS DATA = %x\n", $time, in_addr, out_data);
			end

	endtask

	// verify register
	task verify(	input [11:0] tim_paddr		,
			input [31:0] expected_data	);
		reg [31:0] read_data;
		begin
			read(tim_paddr, read_data);
			if(read_data === expected_data) $display("t = %10d ==> PASS: ADDRESS = %x HAS EXPECTED VALUE = %x\n",$time, tim_paddr, expected_data);
			else $display("t = %10d ==> FAIL: ADDRESS = %x HAS VALUE = %x, BUT EXPECTED DATA = %x\n", $time, tim_paddr, read_data, expected_data);
		end

	endtask	

	// test default value
	task check_default_value(	input [11:0] tim_paddr		,
					input [31:0] default_value	);
			reg [31:0] read_data;
		begin
			read(tim_paddr, read_data);
			if(read_data === default_value) $display("t = %10d ==> PASS: DEFAULT VALUE AT ADDRESS = %x IS %x\n", $time, tim_paddr, default_value);
			else $display("t = %10d ==> FAIL: DEFAULT VALUE AT ADDRESS = %x IS %x, BUT EXPECTED DATA = %x\n", $time, tim_paddr, read_data, default_value);	
		end

	endtask
	


endmodule
