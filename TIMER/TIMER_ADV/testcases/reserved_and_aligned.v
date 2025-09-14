module reserved_and_aligned();
	test_bench top();
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
		     $display("\n============================================TEST RESERVED=======================================\n");

				top.write(12'hAA	,32'h1234_ABCD, 4'hF);
				top.verify(12'hAA	,32'h0	      );	

				top.write(32'h4000_1FFC	, 32'h1111_2222, 4'hF);
				top.verify(32'h4000_1FFC,32'h0);

				top.write(THCSR_OFFSET + 4 	, 32'h9999_6666, 4'hF);
				top.verify(THCSR_OFFSET + 4	, 32'h0);

				top.write(4000_4000 	, 32'h9999_6666, 4'hF);
				top.verify(4000_4000	, 32'h0);


		     $display("\n================================================END=============================================\n");
	
		     $display("\n================================================TEST UNALIGNED=============================================\n");
				top.write (12'h00 + 1	,32'h1234_ABCD, 4'hF);
				top.verify(12'h00 + 1	,32'h0	      );	

				top.write (12'h08 + 2	,32'h1234_ABCD, 4'hF);
				top.verify(12'h08 + 2	,32'h0	      );	

				top.write (12'h18 + 3	,32'h1234_ABCD, 4'hF);
				top.verify(12'h18 + 3	,32'h0	      );	
		     $display("\n================================================END=============================================\n");
	     end




endmodule
