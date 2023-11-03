// module synapse (
//   input wire spike_input,   // spike input from the presynaptic neuron
//   output wire spike_output  // spike output to the postsynaptic neuron
// );

//   reg [1:0] delay_counter;   // counter for delay

//   always @(posedge spike_input) begin   // when a spike is received, initiate the delay counter
//     delay_counter <= 2'b00;
//   end

//   always @(posedge delay_counter[1]) begin  // after a delay, pass the spike to the postsynaptic neuron
//     spike_output <= spike_input;
//   end

// endmodule
// // module receives a spike input from the presynaptic neuron, initiates a delay, and then passes the spike 
//     // to the postsynaptic neuron. The length of the delay can be adjusted.





// module synapse (
//   input wire spike_input,   // spike input from the presynaptic neuron
//   output wire spike_output  // spike output to the postsynaptic neuron
// );

//   reg [1:0] delay_counter;   // counter for delay

//   always @(posedge spike_input) begin   // when a spike is received, initiate the delay counter
//     delay_counter <= 2'b00;
//   end

// endmodule







// module synapse (
//   input wire spike_input,   // spike input from the presynaptic neuron
//   output wire spike_output  // spike output to the postsynaptic neuron
// );

//   reg [1:0] delay_counter;   // counter for delay
//   wire default_spike_output; // Default value for spike_output

//   // default assignment
//   assign default_spike_output = 1'b0;

//   always @(posedge spike_input) begin
//     delay_counter <= 2'b00;
//   end

//   // assign spike_output a default value if not assigned in the always block
//   assign spike_output = (delay_counter == 2'b00) ? default_spike_output : 1'b0;

// endmodule
// syanpse.v code block above passes, but it is not incrementing delay_counter at all...  new code below:







module synapse (
  input wire spike_input,   // spike input from the presynaptic neuron
  output wire spike_output  // spike output to the postsynaptic neuron
);

  reg [1:0] delay_counter;   // counter for delay
  wire default_spike_output; // Default value for spike_output

  // default assignment
  assign default_spike_output = 1'b0;

  always @(posedge spike_input) begin
    if (delay_counter < 2'b11) begin
      delay_counter <= delay_counter + 1;
    end
  end

  // assign spike_output a default value if not assigned in the always block
  assign spike_output = (delay_counter == 2'b11) ? default_spike_output : 1'b0;
// delay_counter is incremented when a positive edge of spike_input is detected. 
  // increases from 2'b00 to 2'b11, which represents a 2-cycle delay. 
    // when delay_counter reaches 2'b11,  spike_output is set to 1'b0, indicating that the delayed spike has passed through.
endmodule
