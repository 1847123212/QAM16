`timescale 1ns/1ns

module myqam (
	input 						CLK		,
	input							Rst		,
	output	signed [28:0]	mult_i	,
	output	signed [28:0]	mult_q	,
	output	signed [29:0]	dout		
	);
	
	
	
	wire						   s_Bit		;
	wire			 	 [3:0]	s_code	;
	wire		signed [2:0]	s_di		;
	wire		signed [2:0]	s_dq		;
	wire		signed [2:0]	s_up_i	;
	wire		signed [2:0]	s_up_q	;
	wire		signed [18:0]	s_di_lpf	;
	wire		signed [18:0]	s_dq_lpf	;
	wire							s_validi	;
	wire							s_validq	;
	wire				 [1:0]	s_errori	;
	wire				 [1:0]	s_errorq	;
	wire 				 [36:0]	s_phi_inc;
	wire 		signed [9:0]	s_sin		;
	wire		signed [9:0]	s_cos		;
	wire							out_valid;
	wire		signed [28:0] 	s_mult_i	;
	wire		signed [28:0] 	s_mult_q	;
	reg 		signed [29:0] 	r_douttem;
	
	//2Mhz载波
	assign	s_phi_inc	= 37'd34359738368		;
	
	//信源模块例化
	source	source(
					.CLK	(CLK)				,
					.Rst	(Rst)				,
					.Bit	(s_Bit)
					);
					
	//转换模块例化
	
	BitTrans 	BitTrans(
						.rst	(Rst)			,
						.clk	(CLK)			,
						.din	(s_Bit)		,
						.code	(s_code)	
						);
						
	//映射模块例化
	
	CodeMap CodeMap(
					.rst	(Rst)				,
					.clk	(CLK)				,
					.din	(s_code)			,
					.I		(s_di)			,
					.Q		(s_dq)
					);
					
	//插值模块
	upsample	upsample(
					.clk	(CLK)				,
					.rst	(Rst)				,
					.I		(s_di)			,
					.Q		(s_dq)			,
					.UP_I	(s_up_i)			,
					.UP_Q	(s_up_q)
					);
					
	//fir模块例化
	
	fir_lpf fir_lpfi(
		.clk					(CLK)			,         //clk.clk
		.reset_n				(!Rst)		,         //rst.reset_n
		.ast_sink_data		(s_up_i)		,      	 //avalon_streaming_sink.data
		.ast_sink_valid	(1'b1)		,    		 //.valid
		.ast_sink_error	(2'd0)		,    		 //.error
		.ast_source_data	(s_di_lpf)	,  		 //avalon_streaming_source.data
		.ast_source_valid	(s_validi)	, 			 //.valid
		.ast_source_error	(s_errori)  			 //.error
	);
	
	
	fir_lpf fir_lpfq(
		.clk					(CLK)			,         //clk.clk
		.reset_n				(!Rst)		,         //rst.reset_n
		.ast_sink_data		(s_up_q)		,      	 //avalon_streaming_sink.data
		.ast_sink_valid	(1'b1)		,    		 //.valid
		.ast_sink_error	(2'd0)		,    		 //.error
		.ast_source_data	(s_dq_lpf)	,  		 // avalon_streaming_source.data
		.ast_source_valid	(s_validq)	, 			 //.valid
		.ast_source_error	(s_errorq)  			 //.error
	);
	
	//nco模块例化
	
	nco nco(
			.clk			(CLK)				,  		 // clk.clk
			.clken		(1'b1)			,  		 // in.clken
			.phi_inc_i	(s_phi_inc)		, 			 // .phi_inc_i
			.fsin_o		(s_sin)			,  		 // out.fsin_o
			.fcos_o		(s_cos)			,  		 // .fcos_o
			.out_valid	(out_valid)		, 			 // .out_valid
			.reset_n 	(!Rst)   					 // rst.reset_n
	);
	
	//乘法器模块例化
	
	mult19_10 mult19_10i(
					.clock	(CLK)			,
					.dataa	(s_di_lpf)	,
					.datab	(s_sin)		,
					.result	(s_mult_i)
					);
	
	mult19_10 mult19_10q(
					.clock	(CLK)			,
					.dataa	(s_dq_lpf)	,
					.datab	(s_cos)		,
					.result	(s_mult_q)
					);
	
	//同相正交支路合成，输出16qam信号
	
	always @(posedge CLK or posedge Rst)	begin
	   if (Rst)	begin
		   r_douttem <= 30'd0;
		end else begin
		   r_douttem <= s_mult_i + s_mult_q;
		end
	end
	
	//信号输出
	assign	mult_i	= s_mult_i	;
	assign	mult_q	= s_mult_q	;
	assign	dout 		= r_douttem	;
	
	 
	

endmodule 