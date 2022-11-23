module decoder4_16 (switch, enable, out);
 input logic [3:0] switch;
 input logic enable;
 output logic [15:0] out;
 
 assign out = {16{enable}} & (1'b1 << switch);
endmodule

module decoder4_16_testbench();
 logic CLOCK_50;
 logic [3:0] switch;
 logic enable;
 logic [15:0] out;

 decoder4_16 dut (.switch, .enable, .out);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   															@(posedge CLOCK_50);
	enable <= 0; switch <= 4'b0001; 		         @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	switch <= 4'b0011;  							      @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	switch <= 4'b0111;  							      @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	switch <= 4'b1111;  							      @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	enable <= 1; switch <= 4'b0001;  				@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	switch <= 4'b0011;  							      @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	switch <= 4'b0111;  							      @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	switch <= 4'b1111;  							      @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	$stop;
	end
endmodule 