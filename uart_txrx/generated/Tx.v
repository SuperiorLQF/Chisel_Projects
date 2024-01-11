module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  input  [7:0] io_channel_data,
  output       io_channel_ready,
  input        io_channel_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [19:0] clkCntReg; // @[uart_transmitter.scala 16:28]
  reg [3:0] bitCntReg; // @[uart_transmitter.scala 17:28]
  reg [10:0] shiftReg; // @[uart_transmitter.scala 18:28]
  wire  insert = io_channel_ready & io_channel_valid; // @[uart_transmitter.scala 22:32]
  reg  stateReg; // @[uart_transmitter.scala 26:26]
  wire  _T_2 = clkCntReg == 20'h67; // @[uart_transmitter.scala 36:29]
  wire [19:0] _clkCntReg_T_3 = clkCntReg + 20'h1; // @[uart_transmitter.scala 45:84]
  wire [3:0] _bitCntReg_T_1 = bitCntReg + 4'h1; // @[uart_transmitter.scala 48:36]
  wire [10:0] _shiftReg_T = {2'h3,io_channel_data,1'h0}; // @[Cat.scala 31:58]
  wire [11:0] _shiftReg_T_2 = {1'h1,shiftReg}; // @[Cat.scala 31:58]
  wire [11:0] _GEN_6 = stateReg & _T_2 ? _shiftReg_T_2 : {{1'd0}, shiftReg}; // @[uart_transmitter.scala 58:61 59:18 61:18]
  wire [11:0] _GEN_7 = insert ? {{1'd0}, _shiftReg_T} : _GEN_6; // @[uart_transmitter.scala 56:17 57:18]
  wire [11:0] _GEN_8 = reset ? 12'h7ff : _GEN_7; // @[uart_transmitter.scala 18:{28,28}]
  assign io_txd = shiftReg[0]; // @[uart_transmitter.scala 64:23]
  assign io_channel_ready = clkCntReg == 20'h0 & bitCntReg == 4'h0; // @[uart_transmitter.scala 20:44]
  always @(posedge clock) begin
    if (reset) begin // @[uart_transmitter.scala 16:28]
      clkCntReg <= 20'h0; // @[uart_transmitter.scala 16:28]
    end else if (stateReg) begin // @[uart_transmitter.scala 45:21]
      if (_T_2) begin // @[uart_transmitter.scala 45:45]
        clkCntReg <= 20'h0;
      end else begin
        clkCntReg <= _clkCntReg_T_3;
      end
    end else begin
      clkCntReg <= 20'h0;
    end
    if (reset) begin // @[uart_transmitter.scala 17:28]
      bitCntReg <= 4'h0; // @[uart_transmitter.scala 17:28]
    end else if (stateReg) begin // @[uart_transmitter.scala 46:28]
      if (_T_2) begin // @[uart_transmitter.scala 47:36]
        bitCntReg <= _bitCntReg_T_1; // @[uart_transmitter.scala 48:23]
      end
    end else begin
      bitCntReg <= 4'h0; // @[uart_transmitter.scala 53:19]
    end
    shiftReg <= _GEN_8[10:0]; // @[uart_transmitter.scala 18:{28,28}]
    if (reset) begin // @[uart_transmitter.scala 26:26]
      stateReg <= 1'h0; // @[uart_transmitter.scala 26:26]
    end else if (~stateReg) begin // @[uart_transmitter.scala 27:21]
      stateReg <= insert;
    end else if (stateReg) begin // @[uart_transmitter.scala 27:21]
      if (clkCntReg == 20'h67 & bitCntReg == 4'ha) begin // @[uart_transmitter.scala 36:67]
        stateReg <= 1'h0; // @[uart_transmitter.scala 37:26]
      end else begin
        stateReg <= 1'h1; // @[uart_transmitter.scala 39:26]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  clkCntReg = _RAND_0[19:0];
  _RAND_1 = {1{`RANDOM}};
  bitCntReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[10:0];
  _RAND_3 = {1{`RANDOM}};
  stateReg = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
