// new neuron.v code below was tested in Vivado
module neuron(
  input wire clk,            // clock signal
  input wire reset,          // reset signal
  output wire spike          // spike output
);

  reg [2:0] count;           // 3-bit timer counter
  reg spike_output;          // signal for when a spike is generated

  always @(posedge clk) begin
    if (reset) begin
      count <= 3'b000;       // reset the count on the rising edge of reset
      spike_output <= 1'b0;  // initial state has no spike
    end
    else begin
      // increase the count on the rising edge of the clock
      count <= count + 1;
      // check if count reaches a threshold to generate a spike
      if (count == 3'b100) begin
        spike_output <= 1'b1;  // neuron generates a spike
        count <= 3'b000;       // count resets after the spike
      end
      else begin
        spike_output <= 1'b0;  // no spike
      end
    end
  end

  assign spike = spike_output;

endmodule
