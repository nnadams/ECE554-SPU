module interrupt_controller(
	input clk, 
	input rst, 
	input spart_int,
	input spu_int,
	input [31:0] PC_CURR,
	input take_branch, 
	input [31:0] PC_BRANCH,
	input [31:0] instruction, 
	
	output [31:0] PC_INT,
	output reg int_wait,
	output reg int_run,
	output reg int_done, 
	output [31:0] PC_RESUME
);


	reg [3:0] state;
	reg [3:0] next_state;
	wire [2:0] int_src; 
	reg [2:0] int_src_in; 
	reg int_src_set;
	reg load_pc; 
	reg flop_pc; 
	reg load_reset;
	reg clr_spu;
	reg clr_spart; 
	
	// INTERRUPT REGISTERS 
	
	// SPU ENABLE FLOP
	wire spu_int_en_wr; 
	wire spu_int_en; 
	assign spu_int_en_wr = (instruction[31:26] == 6'b111111) ? 1'b1 : 1'b0; 
	dff_en spu_int_en_flop(.clk(clk), .rst(rst), .d(instruction[1]), .en(spu_int_en_wr), .q(spu_int_en));
	
	// SPU Status Reg 
	wire spu_int_wr; 
	wire spu_int_ff; 
	assign spu_int_en_wr = clr_spu ? 1'b0 : spu_int ? 1'b1 : spu_int_ff;
	dff spu_status_reg(.clk(clk), .rst(rst), .d(spu_int_wr), .q(spu_int_ff));
	
	// SPART ENABLE FLOP
	wire spart_int_en_wr; 
	wire spart_int_en; 
	assign spart_int_en_wr = (instruction[31:26] == 6'b111111) ? 1'b1 : 1'b0; 
	dff_en spart_int_en_flop(.clk(clk), .rst(rst), .d(instruction[2]), .en(spart_int_en_wr), .q(spart_int_en));
	
	// SPART Status Reg 
	wire spart_int_wr; 
	wire spart_int_ff; 
	assign spart_int_en_wr = clr_spart ? 1'b0 : spart_int ? 1'b1 : spart_int_ff;
	dff spart_status_reg(.clk(clk), .rst(rst), .d(spart_int_wr), .q(spart_int_ff));
	
	// State Flop
	always @(posedge clk, posedge rst) begin
		if(rst) state <= 4'b1111;
		else state <= next_state; 
	end
	
	// Holds the source of the interrupt while we clear the pipeline
	dff_en int_src_flop [2:0] (.clk(clk), .rst(rst), .d(int_src_in), .en(int_src_set), .q(int_src)); 
	
	// Holds the PC we need to return to 
	// If there is a branch in the pipeline while we are waiting... 
	// We need to take that branch. 
	wire [31:0] PC_return; 
	assign PC_return = take_branch ? PC_BRANCH : PC_CURR;
	reg_32 ret_pc_reg(.clk(clk), .rst(rst), .writeData(PC_return), .write(int_src_set | take_branch), .data(PC_RESUME));
	
	// The PC the fetch unit should take on an interrupt
	wire [31:0] _PC_INT;
	
	assign PC_INT = 
					(load_reset)                   ? 32'h0 :
					(load_pc && int_src == 3'b001) ? 32'h8 :
					(load_pc && int_src == 3'b010) ? 32'hC : _PC_INT;
					
	reg_32 int_pc_reg(.clk(clk), .rst(rst), .writeData(instruction), .write(flop_pc), .data(_PC_INT));
		
	// Counter used to clear pipeline when isr completes 
	reg [3:0] cntr;
	reg rst_cnt; 
	
	always @(posedge clk, posedge rst) begin
		if(rst) cntr <= 0; 
		else if(rst_cnt) cntr <= 0;
		else cntr <= cntr + 1; 
	end
	
	// State Logic
	always @(*) begin
		int_wait = 0; 
		int_done = 0; 
		int_src_in = 3'b0; 
		int_src_set = 0;
		int_run = 0; 
		load_pc = 0; 
		flop_pc = 0;
		load_reset = 0; 
		rst_cnt = 0; 
		clr_spu = 0; 
		clr_spart = 0; 
		
		case(state)
		// Reset State - This is a reset interrupt
		4'b1111: begin
			load_reset = 1; 
			next_state = 4'b1110;
			int_wait = 1; 	
		end 
		
		4'b1110: begin
			flop_pc = 1;
			int_wait = 1;
			next_state = 4'b1101;
		end 
		
		4'b1101: begin
			int_run = 1;
			next_state = 4'b0000;
		end 
		
		4'b0000: begin
			if(spart_int_ff & spart_int_en) begin
				int_src_set = 1; 
				int_src_in = 3'b001; 
				next_state = 4'b0001;
				int_wait = 1;
				clr_spart = 1;
			end 
			else if(spu_int_ff & spu_int_en) begin
				int_src_set = 1; 
				int_src_in = 3'b010; 
				next_state = 4'b0001;
				int_wait = 1; 
				clr_spu = 1; 
			end
			else begin
				next_state = 4'b0000;
			end
		end
		
		4'b0001: begin
			// Set the PC so we can load in the interrupt handler address 
			load_pc = 1; 
			next_state = 4'b0010;
			int_wait = 1; 
		end
		
		4'b0010: begin
			// Flop in the data from imem
			flop_pc = 1; 
			next_state = 4'b0011;
			int_wait = 1; 
		end
		
		4'b0011: begin
			next_state = 4'b0100;
			int_wait = 1; 
		end
		
		4'b0100: begin
			next_state = 4'b0101;
			int_wait = 1; 
		end
		
		4'b0101: begin
			next_state = 4'b0110;
			int_wait = 1; 
		end
		
		4'b0110: begin
			// Actually Run the Interrupt
			int_run = 1;
			next_state = 4'b0111;
		end
		
		4'b0111: begin
			if(instruction[31:26] == 6'b111110) begin
				rst_cnt = 1;
				int_wait = 1; 
				next_state = 4'b1000;
			end 
			else begin 
				next_state = 4'b0111;
			end 
		end
		
		4'b1000: begin
			if(cntr == 4'd4) begin
				next_state = 4'b0000; 
				int_done = 1'b1; 
			end 
			else if(take_branch) begin
				next_state = 4'b0111; 
			end 
			else begin
				next_state = 4'b1000; 
				int_wait = 1;
			end
		end
		endcase
	end 
	
endmodule
