module new_module_seg7 (HEX0, HEX1, SW);   
 output logic  [6:0]    HEX0, HEX1;   
 input  logic  [9:0]   SW; 

 seg7 display1(.bcd(SW[3:0]), .leds(HEX0));
 seg7 display2(.bcd(SW[7:4]), .leds(HEX1));
 
endmodule
 
module new_module_seg7_testbench();  
 logic  [6:0] HEX0, HEX1;   
 logic  [9:0] SW;   
  
 new_module_seg7 dut (.HEX0, .HEX1, .SW);  
  
 // Try all combinations of inputs.  
 integer i;   
 initial begin   
  SW[9] = 1'b0;
  SW[8] = 1'b0;
  for(i = 0; i < 256; i++) begin  
   SW[7:0] = i; #10;
  end  
 end  
endmodule 