module check_counter_mode();
test_bench top();
	  reg[31:0] register_tmp;
        	 //address
              parameter TCR_OFFSET   = 12'h00;
              parameter TDR0_OFFSET  = 12'h04;
              parameter TDR1_OFFSET  = 12'h08;
              parameter TCMP0_OFFSET = 12'h0C;
              parameter TCMP1_OFFSET = 12'h10;
              parameter TIER_OFFSET  = 12'h14;
              parameter TISR_OFFSET  = 12'h18;
              parameter THCSR_OFFSET = 12'h1C;

	initial begin
		#100;
		$display("\n===========================TIMER IS COUNTING WITH CONTROL MODE========================\n");	
		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 0==================\n");
		top.write(TCR_OFFSET, 32'h0000_0003, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n=========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 1==================\n");
		top.write(TCR_OFFSET, 32'h0000_0103, 4'hF);
		repeat(10) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(10) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(10) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n");

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 2==================\n");
		top.write(TCR_OFFSET, 32'h0000_0203, 4'hF);
		repeat(24) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(24) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(24) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n");

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 3==================\n");
		top.write(TCR_OFFSET, 32'h0000_0303, 4'hF);
		repeat(38) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(5) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(5) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 4==================\n");
		top.write(TCR_OFFSET, 32'h0000_0403, 4'hF);
		repeat(78) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(13) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(13) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 5==================\n");
		top.write(TCR_OFFSET, 32'h0000_0503, 4'hF);
		repeat(158) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(29) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(29) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 6==================\n");
		top.write(TCR_OFFSET, 32'h0000_0603, 4'hF);
		repeat(328) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(61) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(61) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 7==================\n");
		top.write(TCR_OFFSET, 32'h0000_0703, 4'hF);
		repeat(638) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(125) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(125) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 1 AND DIV_VAL = 8==================\n");
		top.write(TCR_OFFSET, 32'h0000_0803, 4'hF);
		repeat(1278) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(253) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(253) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
	

		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n============================DIV_VAL IS ASSERTED BUT DIV_EN IS DESSERTED==================\n");

		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 1==================\n");
		top.write(TCR_OFFSET, 32'h0000_0101, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 2==================\n");
		top.write(TCR_OFFSET, 32'h0000_0201, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 3==================\n");
		top.write(TCR_OFFSET, 32'h0000_0301, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 4==================\n");
		top.write(TCR_OFFSET, 32'h0000_0401, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 5==================\n");
		top.write(TCR_OFFSET, 32'h0000_0501, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 6==================\n");
		top.write(TCR_OFFSET, 32'h0000_0601, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;
		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 7==================\n");
		top.write(TCR_OFFSET, 32'h0000_0701, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 
		top.sys_rst_n = 0;
		#100 top.sys_rst_n = 1;

		$display("\n========================CONTROL MODE WITH DIV_EN = 0 AND DIV_VAL = 8==================\n");
		top.write(TCR_OFFSET, 32'h0000_0801, 4'hF);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		repeat(3) @(posedge top.sys_clk);
		top.read(TDR0_OFFSET, register_tmp);
		$display("\n===========================END==========================\n"); 

		$display("\n==================================END TEST=======================================\n"); 
	end
endmodule
