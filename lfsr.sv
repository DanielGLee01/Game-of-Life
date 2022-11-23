module lfsr(Clock, Reset, OUT);
 output logic [9:0] OUT;
 input logic Clock, Reset;
 
 logic RAND;
 
 assign RAND = (OUT[0] ~^ OUT[3]);
 
 always_ff @(posedge Clock) begin 
  if (Reset) OUT <= 10'b0000000000;
  else OUT <= {RAND, OUT[9:1]};
 end
endmodule

module LSFR_testbench();
 logic [9:0] OUT;
 logic Clock, Reset;
 logic RAND;
 
 lfsr dut(.Clock, .Reset, .OUT);
 
 parameter CLOCK_PERIOD = 100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD / 2) 
	Clock <= ~Clock;
 end
 
 initial begin
												      @(posedge Clock);
  Reset <= 1;              				   @(posedge Clock); // Always reset FSMs at start
													   @(posedge Clock);
  Reset <= 0;              				   @(posedge Clock);
													   @(posedge Clock);
                                repeat(10)@(posedge Clock);
  $stop;
 end
endmodule 