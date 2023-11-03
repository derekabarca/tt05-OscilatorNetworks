`default_nettype none

// trying new code real quick
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
  wire spike_neuron1, spike_neuron2, synapse1_out;  // spike signals from neuron modules & synpase output

  // instantiate 2 neuron modules
  neuron neuron1 (.reset(reset), .enable(ena), .spike(spike_neuron1));
  neuron neuron2 (.reset(reset), .enable(synapse1_out), .spike(spike_neuron2));

  // instantiate 2 synapse module
  synapse synapse1 (.spike_input(spike_neuron1), .spike_output(synapse1_out));
  synapse synapse2 (.spike_input(spike_neuron2), .spike_output(spike_output));

  assign uo_out = 8'b0;          // no specific output to 7-segment display
  assign uio_out = 8'b0;         // no specific bidirectional output
  assign uio_oe = 8'b0;          // no specific bidirectional enable path

endmodule
