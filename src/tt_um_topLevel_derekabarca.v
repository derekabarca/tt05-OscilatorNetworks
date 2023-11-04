module tt_um_topLevel_derekabarca (
  input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
  output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
  input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
  output wire [7:0] uio_out,  // IOs: Bidirectional Output path
  output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // will go high when the design is enabled
  input  wire       clk,      // clock
  input  wire       rst_n,     // reset_n - low to reset
  output wire spike_output
);
  // topLevel logic
  wire reset = !rst_n;
  wire spike_neuron1, spike_neuron2;  // spike signals from neuron modules
  wire temp_wire_synapse1out, temp_wire_synapse2out;

  // instantiate 2 neuron modules
  neuron neuron1 (.clk(clk), .reset(reset), .spike(spike_neuron1));
  neuron neuron2 (.clk(clk), .reset(reset), .spike(spike_neuron2));

  // instantiate 2 synapse modules with separate temporary wires
  synapse synapse1 (.clk(clk), .spike_input(spike_neuron1), .spike_output(temp_wire_synapse1out), .reset(reset));
  synapse synapse2 (.clk(clk), .spike_input(spike_neuron2), .spike_output(temp_wire_synapse2out), .reset(reset));

  // output of the synapse modules becomes the network's spike output
  assign spike_output = temp_wire_synapse1out || temp_wire_synapse2out;

  // connect the unused pins to Neuron or Synapse modules
  // assign ui_in = 8'b0;           // no specific input from switches
  assign uo_out = 8'b0;          // no specific output to 7-segment display
  // assign uio_in = 8'b0;          // no specific bidirectional input
  assign uio_out = 8'b0;         // no specific bidirectional output
  assign uio_oe = 8'b0;          // no specific bidirectional enable path

endmodule


// FINALLY ALL THREE PASSED
  // Need to write a real Testbench though...