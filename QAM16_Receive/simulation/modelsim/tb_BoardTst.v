`timescale 1ns/1ns

module tb_BoardTst();
	
	reg						r_CLK			;
	reg						r_DCO			;
	reg						r_Rst			;
	reg			 [13:0]		r_ADA_D			;
	wire 					ADA_OE			;
	wire					LEDG0			;
	wire					LEDG3			;
	wire					FPGA_CLK_A_N	;
	wire					FPGA_CLK_A_P	;
	wire					ADA_SPI_CS		;
	wire	signed [13:0]	DA				;
	wire	signed [13:0]	DB				;
	
	parameter data_num = 746592		;  //仿真数据长度
	
	//时钟激励
	initial begin
        r_CLK	= 1'b1 ;
        forever begin
            # 10 ;
            r_CLK	<= ~r_CLK ;
        end
    end
	 
	 //DA输出激励
	initial begin
        r_DCO	= 1'b1 ;
        forever begin
            # 10 ;
            r_DCO	<= ~r_DCO ;
        end
    end
	 
	 initial begin
        r_Rst	= 1'b0 	;
        # 3500 			;
		  r_Rst	= 1'b1 	;
    end
	 
	 //仿真数据从文本文件读入
	integer			Pattern					;
	reg		[13:0] stimulus[1:data_num]	;
	initial begin
		//文件必须放置在"工程目录\simulation\modelsim"路径下
		$readmemb("source.txt",stimulus);
		Pattern = 0;
		repeat(data_num)
			begin
				Pattern = Pattern+1;
				r_ADA_D = stimulus[Pattern];
				#20;
			end
	end
	
	//产生写入时钟信号，初始状态时不写入数据
	wire		rst_write	;
	assign 	rst_write = (Pattern >215 )? r_CLK: 1'b0;    
	
	//将仿真数据di写入外部TXT文件中(di.txt)
	integer file_di;
	initial	begin
		//文件放置在"工程目录\simulation\modelsim"路径下                                                  
		file_di = $fopen("di.txt");
	end
	
	//将df转换成有符号数据
	wire	signed [13:0]	s_di;
	assign	s_di = DA;
	always @(posedge rst_write)	begin
		$fdisplay(file_di,"%d",s_di);
	end

	//将仿真数据dq写入外部TXT文件中(dq.txt)
	integer	file_dq;
	initial	begin
		//文件放置在"工程目录\simulation\modelsim"路径下                                                  
		file_dq = $fopen("dq.txt");
	end
	//将df转换成有符号数据
	wire signed [13:0] s_dq;
	assign	s_dq = DB;
	always @(posedge rst_write)	begin
		$fdisplay(file_dq,"%d",s_dq);
	end



	BoardTst BoardTst(
				.CLK				(r_CLK)				,
				.Rst				(r_Rst)				,
				.ADA_OR			(1'b1)				,
				.ADA_DCO			(r_DCO)				,
				.ADA_D			(r_ADA_D)			,
				.ADA_OE			(ADA_OE)				,
				.LEDG0			(LEDG0)				,
				.LEDG3			(LEDG3)				,
				.ADA_SPI_CS		(ADA_SPI_CS)		,
				.DA				(DA)					,
				.DB				(DB)					,
				.FPGA_CLK_A_N	(FPGA_CLK_A_N)		,
				.FPGA_CLK_A_P	(FPGA_CLK_A_P)	,
				.AD_SCLK()						,
				.AD_SDIO()
			);
			

endmodule 