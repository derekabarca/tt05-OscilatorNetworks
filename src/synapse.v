module synapse (
  input wire spike_input, clk, reset,   // spike input from the presynaptic neuron
  output wire spike_output  // spike output to the postsynaptic neuron
);

  reg [1:0] delay_counter;   // counter for delay

// always at posedge clk and whenever you recieve a spike_input
  // always @(posedge clk or posedge spike_input) begin
  //   if (reset) begin
  //     delay_counter <= 2'b00;       
  //   end
  //   else if (delay_counter < 2'b11) begin
  //     delay_counter <= delay_counter + 1;
  //   end
  // end

  // new always @ block
  always @(posedge clk) begin
  if (spike_input) begin
    // code executes when spike_input is 1'b1
    if (reset) begin
      delay_counter <= 2'b00;
    end
    else if (delay_counter < 2'b11) begin
      delay_counter <= delay_counter + 1;
    end
  end
end


  // assign spike_output a default value if not assigned in the always block
  assign spike_output = (delay_counter == 2'b11) ? 1'b1 : 1'b0;
// delay_counter is incremented when a positive edge of spike_input is detected. 
  // increases from 2'b00 to 2'b11, which represents a 2-cycle delay. 
    // when delay_counter reaches 2'b11,  spike_output is set to 1'b1, indicating that the delayed spike has passed through.
      // if not then spike_output is 1'b0.
endmodule
