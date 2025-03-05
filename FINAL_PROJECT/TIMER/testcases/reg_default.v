module reg_default();
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
		$display("\n==========================CHECK DEFAULT VALUE============================\n");

			top.check_default_value(TCR_OFFSET	, {20'h0, 4'h1, 8'b0})	;
			top.check_default_value(TDR0_OFFSET	, 32'h0)		;
			top.check_default_value(TDR1_OFFSET	, 32'h0)		;
			top.check_default_value(TCMP0_OFFSET	, 32'hFFFF_FFFF)	;
			top.check_default_value(TCMP1_OFFSET	, 32'hFFFF_FFFF)	;
			top.check_default_value(TIER_OFFSET	, 32'h0)		;
			top.check_default_value(TISR_OFFSET	, 32'h0)		;
			top.check_default_value(THCSR_OFFSET	, 32'h0)		;

		$display("\n==================================END====================================\n");

	end

endmodule
