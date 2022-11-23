module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
 output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0]  LEDR;
 input  logic [3:0]  KEY;
 input  logic [9:0]  SW;
 output logic [35:0] GPIO_1;
 input logic CLOCK_50;

 logic SYSTEM_CLOCK, runClk, reset, out;
 logic [31:0] clk;
 
 // Turn off HEX displays and LEDS
 assign HEX0 = 7'b1111111;
 assign HEX1 = 7'b1111111;
 assign HEX2 = 7'b1111111;
 assign HEX3 = 7'b1111111;
 assign HEX4 = 7'b1111111;
 assign HEX5 = 7'b1111111;
 assign LEDR = 10'b0000000000;
	 
 clock_divider divider (.reset, .clock(CLOCK_50), .divided_clocks(clk));
	 
 //assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal
 assign SYSTEM_CLOCK = CLOCK_50; // 1526 Hz clock signal
	 
 logic [15:0][15:0]DOT; // 16 x 16 array representing red LEDs
 logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
 logic [15:0][15:0]temp;
 logic [15:0][15:0]temp1;
 assign GrnPixels = {16'b0, 16'b0, 16'b0, 16'b0, 16'b0, 16'b0,16'b0, 16'b0,
							16'b0, 16'b0, 16'b0, 16'b0, 16'b0, 16'b0,16'b0, 16'b0};
 
 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(reset), .EnableCount(1'b1), .RedPixels(DOT), .GrnPixels(GrnPixels), .GPIO_1(GPIO_1));
 doubleFF d_ff (.Clock(SYSTEM_CLOCK), .Reset(~KEY[3]), .key(~KEY[0]), .stableOut(reset));
 gameLoad game (.Clock(SYSTEM_CLOCK), .Reset(reset), .A(DOT), .sw(SW), .DOT(temp));
	
 //assign runClk	= clk[24];
 assign runClk	= CLOCK_50;
	
 always_comb begin
  if (~SW[9]) 
	DOT <= temp;
  else
	DOT <= temp1;
  end
 
 genvar i, j;
 generate
  for (i = 0; i < 16; i++) begin : rowGeneration
   for (j = 0; j < 16; j++) begin : columnGeneration
	 gameStart play (.Clock(runClk), .neighborDot({DOT[(i+15)%16][(j+15)%16], DOT[(i+15)%16][j], DOT[(i+15)%16][(j+1)%16],
	 DOT[i][(j+15)%16], DOT[i][(j+1)%16], 
	 DOT[(i+1)%16][(j+15)%16], DOT[(i+1)%16][j], DOT[(i+1)%16][(j+1)%16]}),
	 .existence(temp1[i][j]), .reset);
   end
  end
 endgenerate
endmodule


module DE1_SoC_testbench();
 logic 		CLOCK_50;
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;
 logic [35:0] GPIO_1;
	
 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .GPIO_1, .CLOCK_50);
	
 parameter CLOCK_PERIOD = 100;
 initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
 end
	
	initial begin

   SW <= 10'b1000000000; KEY[3] <= 0;				@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
	KEY[3] <= 1;KEY[0] <= 0;							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
	KEY[0] <= 1;											@(posedge CLOCK_50);
																@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
	SW <= 10'b0100000000; 	            			@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0100001111; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0111110000; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0111111111; 							   @(posedge CLOCK_50);
															   @(posedge CLOCK_50);
	SW <= 10'b0101100101; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0101010101; 		                  @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0101011011; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0101101001; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0101111011; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b1000000000; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		$stop;
	end
endmodule