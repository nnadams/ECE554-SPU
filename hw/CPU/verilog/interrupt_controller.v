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
	
	
	// State Flop
	always @(posedge clk, posedge rst) begin
		if(rst) state <= 4'b0000;
		else state <= next_state; 
	end
	
	// Holds the source of the interrupt while we clear the pipeline
	dff_en int_src_flop [2:0] (.clk(clk), .rst(rst), .d(int_src_in), .en(int_src_set), .q(int_src)); 
	
	// Holds the PC we need to return to 
	// If there is a branch in the pipeline while we are waiting... 
	// We need to take that branch. 
	wire [31:0] PC_return; 
	assign PC_return = take_branch ? PC_BRANCH : PC_CURR;
	reg_32 ret_pc_reg(.clk(clk), .rst(rst), .writeData(PC_return), .write(int_src_set), .data(PC_RESUME));
	
	// The PC the fetch unit should take on an interrupt
	wire [31:0] _PC_INT;
	
	assign PC_INT = 
					(load_pc && int_src == 3'b001) ? 32'h8 :
					(load_pc && int_src == 3'b010) ? 32'hC : _PC_INT;
					
	reg_32 int_pc_reg(.clk(clk), .rst(rst), .writeData(instruction), .write(flop_pc), .data(_PC_INT));
		
	// State Logic
	always @(*) begin
		int_wait = 0; 
		int_done = 0; 
		int_src_in = 3'b0; 
		int_src_set = 0;
		int_run = 0; 
		load_pc = 0; 
		flop_pc = 0;
		
		case(state)
		4'b0000: begin
			if(spart_int) begin
				int_src_set = 1; 
				int_src_set = 3'b001; 
				next_state = 4'b0001;
				int_wait = 1; 
			end 
			else if(spu_int) begin
				int_src_set = 1; 
				int_src_set = 3'b010; 
				next_state = 4'b0001;
				int_wait = 1; 
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
		
		4'b0110: begin
			if(instruction[31:26] == 6'b111111) begin
				int_done = 1;
				next_state = 4'b0000;
			end 
			else begin 
				next_state = 4'b0110;
			end 
		end
		endcase
	end 
	
endmodule
