module dotCount (neighborDot, counter);
 input logic [7:0] neighborDot;
 output logic [1:0] counter;
 
 logic [2:0] number;
 
 assign counter = ~number[2] ? number[1:0] : 2'b00;
 
 assign number = neighborDot[0] + neighborDot[1] + neighborDot[2] + neighborDot[3]
               + neighborDot[4] + neighborDot[5] + neighborDot[6] + neighborDot[7];

endmodule 
  
module dotCount_testbench();
  logic [7:0] neighborDot;
  logic [1:0] counter;
  logic CLOCK_50;
  
  dotCount dut (.neighborDot, .counter);
  
  parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000010;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000001;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000011;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000100;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00001111;  							@(posedge CLOCK_50);
	$stop;
	end
endmodule
