module	nco_top(
			input							clk			,
			input 						rst			,
			output						out_valid	,
			output	signed [9:0]	sin			,
			output	signed [9:0]	cos
			);
			
	//设定输出频率子2Mhz
	wire [36:0]	phi_inc								;
	
	assign		phi_inc	= 37'd34359738368		;
			
	nco nco(
		.clk(clk),       // clk.clk
		.clken(1'b1),     //  in.clken
		.phi_inc_i(phi_inc), //    .phi_inc_i
		.fsin_o(sin),    // out.fsin_o
		.fcos_o(cos),    //    .fcos_o
		.out_valid(out_valid), //    .out_valid
		.reset_n (rst)   // rst.reset_n
	);



endmodule
