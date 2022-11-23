module gameLoad (Clock, Reset, A, sw, DOT);
 input logic Clock, Reset;
 input logic  [15:0][15:0] A;
 input logic [9:0] sw;
 output logic [15:0] [15:0] DOT;
 
 logic [15:0] RowSelect, ColumnSelect;
 logic control;
 
 decoder4_16 row (.switch(sw[3:0]), .enable(1'b1), .out(RowSelect));
 decoder4_16 column (.switch(sw[7:4]), .enable(1'b1), .out(ColumnSelect));
 
 genvar i, j;
 generate
  for (i = 0; i < 16; i++) begin : rowGeneration
   for (j = 0; j < 16; j++) begin : columnGeneration
    dotManager dot (.Clock(Clock), .G(A[i][j]), .RowSelect(RowSelect[i]), .ColumnSelect(ColumnSelect[j]), .SWNINE(sw[9]), .Q(DOT[i][j]), .SWEIGHT(sw[8]));
   end
  end
 endgenerate
endmodule

module gameLoad_testbench();
 logic CLOCK_50;
 logic Reset;
 logic [15:0][15:0] A;
 logic [9:0] sw;
 logic [15:0] [15:0] DOT;

 gameLoad dut (.Clock(CLOCK_50), .Reset, .A, .sw, .DOT);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   sw <= 10'b1000000000; 		                  @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	sw <= 10'b0100000000;		            		@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	sw <= 10'b0100001111; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	sw <= 10'b0111110000; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	sw <= 10'b0111111111; 							   @(posedge CLOCK_50);
															   @(posedge CLOCK_50);
	sw <= 10'b1100000000; 		                  @(posedge CLOCK_50);
       														@(posedge CLOCK_50);
	sw <= 10'b1100001111; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	sw <= 10'b1011110000; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	sw <= 10'b1011111111; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	$stop;
	end
endmodule 