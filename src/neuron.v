// module neuron(
//   input wire reset,          // reset signal
//   input wire enable,        // enable signal
//   output wire spike          // spike output
// );

//   reg [2:0] count;           // 3-bit timer counter
//   reg spike_output;          // signal for when spike is generated

//   always @(posedge reset or posedge enable) begin
//     if (reset) begin
//       count <= 3'b000;       // reset the count
//       spike_output <= 1'b0;  // initial state has no spike
//     end
//     else if (enable) begin
//       count <= 3'b000;       // enable state, reset the count
//       spike_output <= 1'b0;  // no spike during enable
//     end
//     else begin
//       // increase the count on each clock edge
//       count <= count + 1;
//       // check if count reaches a threshold to generate a spike
//       if (count == 3'b100) begin
//         spike_output <= 1'b1;  // neuron generates a spike
//         count <= 3'b000;       // count resets after spike 
//       end
//       else begin
//         spike_output <= 1'b0;  // no spike
//       end
//     end
//   end

//   assign spike = spike_output;

// endmodule
// module generates a spike signal (spike) based on a count and can be reset or enable with the reset and enable signals.

// Tests passed with above code




// new neuron.v code below was tested in Vivado
module neuron(
  input wire clk,            // clock signal
  input wire reset,          // reset signal
  input wire enable,        // enable signal
  output wire spike          // spike output
);

  reg [2:0] count;           // 3-bit timer counter
  reg spike_output;          // signal for when a spike is generated

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 3'b000;       // reset the count on the rising edge of reset
      spike_output <= 1'b0;  // initial state has no spike
    end
    else if (enable) begin
      count <= 3'b000;       // reset the count on the rising edge of enable
      spike_output <= 1'b0;  // no spike during enable
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
