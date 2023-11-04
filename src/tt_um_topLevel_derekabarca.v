module tt_um_topLevel_derekabarca (
  input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
  output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
  input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
  output wire [7:0] uio_out,  // IOs: Bidirectional Output path
  output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // will go high when the design is enabled
  input  wire       clk,      // clock
  input  wire       rst_n     // reset_n - low to reset
);
  // topLevel logic
  wire reset = !rst_n;
  wire spike_neuron1, spike_neuron2;  // spike signals from neuron modules
  wire temp_wire_synapse1out, temp_wire_synapse2out, spike_output;

  // instantiate 2 neuron modules
  neuron neuron1 (.clk(clk), .reset(reset), .spike(spike_neuron1));
  neuron neuron2 (.clk(clk), .reset(reset), .spike(spike_neuron2));

  // instantiate 2 synapse modules with separate temporary wires
  synapse synapse1 (.spike_input(spike_neuron1), .spike_output(temp_wire_synapse1out), .reset(reset), .clk(clk));
  synapse synapse2 (.spike_input(spike_neuron2), .spike_output(temp_wire_synapse2out), .reset(reset), .clk(clk));

  // output of the synapse modules becomes the network's spike output
  assign spike_output = temp_wire_synapse1out || temp_wire_synapse2out;
  assign uo_out = {7'b0, spike_output}; 


  // connect the unused pins to Neuron or Synapse modules
  assign uio_out = 8'b0;         // no specific bidirectional output
  assign uio_oe = 8'b0;          // no specific bidirectional enable path

endmodule