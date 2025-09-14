module check_onehot();
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
		 $display("\n=======================================TEST ONE HOT===========================\n");
               
                         top.write(TISR_OFFSET  , 32'haaaa_aaaa	, 4'hF)  ;
                         top.write(TCR_OFFSET	, 32'h2222_2222	, 4'hF)  ;
                         top.write(TDR0_OFFSET  , 32'hffff_ffff , 4'hF)  ;
                         top.write(TDR1_OFFSET  , 32'h3333_3333	, 4'hF)  ;
                         top.write(TCMP0_OFFSET , 32'h4444_4444	, 4'hF)  ;
                         top.write(TCMP1_OFFSET , 32'h5555_5555	, 4'hF)  ;
                         top.write(TIER_OFFSET  , 32'h9999_9999	, 4'hF)  ;
                         top.write(THCSR_OFFSET , 32'hbbbb_bbbb	, 4'hF)  ;


                         top.verify(TISR_OFFSET  , 32'h0000_0000)        ;
                         top.verify(TCR_OFFSET   , 32'h0000_0202)        ;
                         top.verify(TDR0_OFFSET  , 32'hffff_ffff)        ;
                         top.verify(TDR1_OFFSET  , 32'h3333_3333)        ;
                         top.verify(TCMP0_OFFSET , 32'h4444_4444)        ;
                         top.verify(TCMP1_OFFSET , 32'h5555_5555)        ;
                         top.verify(TIER_OFFSET  , 32'h0000_0001)        ;
                         top.verify(THCSR_OFFSET , 32'h0000_0001)        ;
                 $display("\n=================================================END======================================\n");
	

		end
endmodule
