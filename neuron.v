module neuron(
  input wire reset,          // reset signal
  input wire enable,        // enableble signal
  output wire spike          // spike output
);

  reg [2:0] count;           // timer counter
  reg spike_output;          // signal for when spike is generated

  always @(posedge !reset or posedge enable) begin
    if (!reset) begin
      count <= 3'b000;       // reset the count
      spike_output <= 1'b0;  // initial state has no spike
    end
    else if (enable) begin
      count <= 3'b000;       // enable state, reset the count
      spike_output <= 1'b0;  // no spike during enable
    end
    else begin
      // increase the count on each clock edge
      count <= count + 1;
      // check if count reaches a threshold to generate a spike
      if (count == 3'b100) begin
        spike_output <= 1'b1;  // neuron generates a spike
        count <= 3'b000;       // count resets after spike 
      end
      else begin
        spike_output <= 1'b0;  // No spike
      end
    end
  end

  assign spike = spike_output;

endmodule
// module generates a spike signal (spike) based on a count and can be reset or enable with the reset and enable signals.
