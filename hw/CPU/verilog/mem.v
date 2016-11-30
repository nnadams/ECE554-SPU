module memory(
	input clk, 
	input rst,
	input [31:0] mem_alu_out,
	input [31:0] mem_reg_data_2,
	input [3:0] mem_mem_write,
	input [3:0] mem_mem_enable, 
	input [31:0] data_mem_data, 	
	output [3:0] data_mem_en,
	output [31:0] data_mem_addr, 
	output [31:0] data_mem_write_data, 
	output [3:0] data_mem_wr, 
	output [31:0] mem_mem_out,
	output mem_stall 
);

	reg state; 
	reg next_state; 
	reg _stall; 
	
	assign data_mem_addr = mem_alu_out;
	assign data_mem_write_data = mem_reg_data_2;
	assign data_mem_wr = mem_mem_write;
	assign data_mem_en = mem_mem_enable;
	assign mem_mem_out = data_mem_data;
	assign mem_stall = _stall;
	
	// Simple one cycle mem_delay state machine
	always @(posedge clk or posedge rst) begin
		if(rst) state <= 0; 
		else state <= next_state;
	end
	
	always @(*) begin
		_stall = 0; 
		next_state = 0; 
		case(state) 
		1'b0: begin
			if(data_mem_en & ~data_mem_wr) begin
				_stall = 1; 
				next_state = 1; 
			end
		end
		
		1'b1: begin
			next_state = 0;
		end
		
		endcase 
	end 
	
endmodule 