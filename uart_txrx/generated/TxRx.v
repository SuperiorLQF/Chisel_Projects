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
  wire [10:0] _shiftReg_T_2 = {1'h1,shiftReg[10:1]}; // @[Cat.scala 31:58]
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
    if (reset) begin // @[uart_transmitter.scala 18:28]
      shiftReg <= 11'h7ff; // @[uart_transmitter.scala 18:28]
    end else if (insert) begin // @[uart_transmitter.scala 56:17]
      shiftReg <= _shiftReg_T; // @[uart_transmitter.scala 57:18]
    end else if (stateReg & _T_2) begin // @[uart_transmitter.scala 58:61]
      shiftReg <= _shiftReg_T_2; // @[uart_transmitter.scala 59:18]
    end
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
module Rx(
  input        clock,
  input        reset,
  input        io_rxd,
  output [7:0] io_channel_data,
  output       io_channel_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [19:0] clkCntReg; // @[uart_receiver.scala 18:28]
  reg [3:0] bitCntReg; // @[uart_receiver.scala 19:28]
  reg [9:0] shiftReg; // @[uart_receiver.scala 20:28]
  reg  rxdReg_REG; // @[uart_receiver.scala 21:36]
  reg  rxdReg; // @[uart_receiver.scala 21:28]
  reg [1:0] stateReg; // @[uart_receiver.scala 24:26]
  wire [28:0] _GEN_17 = {{9'd0}, clkCntReg}; // @[uart_receiver.scala 34:28]
  wire  _T_3 = _GEN_17 == 29'h1f79bfff; // @[uart_receiver.scala 34:28]
  wire  _T_5 = clkCntReg == 20'h67; // @[uart_receiver.scala 42:29]
  wire  _T_6 = bitCntReg == 4'ha; // @[uart_receiver.scala 42:54]
  wire  _T_7 = clkCntReg == 20'h67 & bitCntReg == 4'ha; // @[uart_receiver.scala 42:41]
  wire [1:0] _GEN_2 = clkCntReg == 20'h67 & bitCntReg == 4'ha ? 2'h0 : 2'h2; // @[uart_receiver.scala 42:67 43:26 45:26]
  wire  _T_8 = stateReg == 2'h1; // @[uart_receiver.scala 51:19]
  wire [19:0] _clkCntReg_T_1 = clkCntReg + 20'h1; // @[uart_receiver.scala 55:36]
  wire  _T_10 = stateReg == 2'h2; // @[uart_receiver.scala 57:25]
  wire [3:0] _bitCntReg_T_1 = bitCntReg + 4'h1; // @[uart_receiver.scala 69:36]
  wire [9:0] _shiftReg_T_1 = {shiftReg[8:0],rxdReg}; // @[Cat.scala 31:58]
  wire [9:0] _GEN_16 = _T_7 ? shiftReg : 10'h0; // @[uart_receiver.scala 90:59 92:26 95:26]
  assign io_channel_data = _GEN_16[7:0];
  assign io_channel_valid = _T_5 & _T_6; // @[uart_receiver.scala 90:33]
  always @(posedge clock) begin
    if (reset) begin // @[uart_receiver.scala 18:28]
      clkCntReg <= 20'h0; // @[uart_receiver.scala 18:28]
    end else if (stateReg == 2'h1) begin // @[uart_receiver.scala 51:29]
      if (_T_3) begin // @[uart_receiver.scala 52:42]
        clkCntReg <= 20'h0; // @[uart_receiver.scala 53:23]
      end else begin
        clkCntReg <= _clkCntReg_T_1; // @[uart_receiver.scala 55:23]
      end
    end else if (stateReg == 2'h2) begin // @[uart_receiver.scala 57:34]
      if (_T_5) begin // @[uart_receiver.scala 58:36]
        clkCntReg <= 20'h0; // @[uart_receiver.scala 59:23]
      end else begin
        clkCntReg <= _clkCntReg_T_1; // @[uart_receiver.scala 61:23]
      end
    end else begin
      clkCntReg <= 20'h0; // @[uart_receiver.scala 64:19]
    end
    if (reset) begin // @[uart_receiver.scala 19:28]
      bitCntReg <= 4'h0; // @[uart_receiver.scala 19:28]
    end else if (_T_8) begin // @[uart_receiver.scala 67:29]
      if (_T_3) begin // @[uart_receiver.scala 68:42]
        bitCntReg <= _bitCntReg_T_1; // @[uart_receiver.scala 69:23]
      end
    end else if (_T_10) begin // @[uart_receiver.scala 73:34]
      if (_T_5) begin // @[uart_receiver.scala 74:36]
        bitCntReg <= _bitCntReg_T_1; // @[uart_receiver.scala 75:23]
      end
    end else begin
      bitCntReg <= 4'h0; // @[uart_receiver.scala 80:19]
    end
    if (reset) begin // @[uart_receiver.scala 20:28]
      shiftReg <= 10'h3ff; // @[uart_receiver.scala 20:28]
    end else if (_T_10 & _T_5) begin // @[uart_receiver.scala 83:55]
      shiftReg <= _shiftReg_T_1; // @[uart_receiver.scala 84:18]
    end
    rxdReg_REG <= io_rxd; // @[uart_receiver.scala 21:36]
    rxdReg <= rxdReg_REG; // @[uart_receiver.scala 21:28]
    if (reset) begin // @[uart_receiver.scala 24:26]
      stateReg <= 2'h0; // @[uart_receiver.scala 24:26]
    end else if (2'h0 == stateReg) begin // @[uart_receiver.scala 25:21]
      if (~rxdReg) begin // @[uart_receiver.scala 27:34]
        stateReg <= 2'h1; // @[uart_receiver.scala 28:26]
      end else begin
        stateReg <= 2'h0; // @[uart_receiver.scala 30:26]
      end
    end else if (2'h1 == stateReg) begin // @[uart_receiver.scala 25:21]
      if (_GEN_17 == 29'h1f79bfff) begin // @[uart_receiver.scala 34:46]
        stateReg <= 2'h2; // @[uart_receiver.scala 35:26]
      end else begin
        stateReg <= 2'h1; // @[uart_receiver.scala 37:26]
      end
    end else if (2'h2 == stateReg) begin // @[uart_receiver.scala 25:21]
      stateReg <= _GEN_2;
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
  shiftReg = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  rxdReg_REG = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  rxdReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stateReg = _RAND_5[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TxRx(
  input        clock,
  input        reset,
  input  [7:0] io_txchannel_data,
  output       io_txchannel_ready,
  input        io_txchannel_valid,
  output [7:0] io_rxchannel_data,
  input        io_rxchannel_ready,
  output       io_rxchannel_valid
);
  wire  txPart_clock; // @[uart_txrx.scala 14:24]
  wire  txPart_reset; // @[uart_txrx.scala 14:24]
  wire  txPart_io_txd; // @[uart_txrx.scala 14:24]
  wire [7:0] txPart_io_channel_data; // @[uart_txrx.scala 14:24]
  wire  txPart_io_channel_ready; // @[uart_txrx.scala 14:24]
  wire  txPart_io_channel_valid; // @[uart_txrx.scala 14:24]
  wire  rxPart_clock; // @[uart_txrx.scala 15:24]
  wire  rxPart_reset; // @[uart_txrx.scala 15:24]
  wire  rxPart_io_rxd; // @[uart_txrx.scala 15:24]
  wire [7:0] rxPart_io_channel_data; // @[uart_txrx.scala 15:24]
  wire  rxPart_io_channel_valid; // @[uart_txrx.scala 15:24]
  Tx txPart ( // @[uart_txrx.scala 14:24]
    .clock(txPart_clock),
    .reset(txPart_reset),
    .io_txd(txPart_io_txd),
    .io_channel_data(txPart_io_channel_data),
    .io_channel_ready(txPart_io_channel_ready),
    .io_channel_valid(txPart_io_channel_valid)
  );
  Rx rxPart ( // @[uart_txrx.scala 15:24]
    .clock(rxPart_clock),
    .reset(rxPart_reset),
    .io_rxd(rxPart_io_rxd),
    .io_channel_data(rxPart_io_channel_data),
    .io_channel_valid(rxPart_io_channel_valid)
  );
  assign io_txchannel_ready = txPart_io_channel_ready; // @[uart_txrx.scala 17:23]
  assign io_rxchannel_data = rxPart_io_channel_data; // @[uart_txrx.scala 18:18]
  assign io_rxchannel_valid = rxPart_io_channel_valid; // @[uart_txrx.scala 18:18]
  assign txPart_clock = clock;
  assign txPart_reset = reset;
  assign txPart_io_channel_data = io_txchannel_data; // @[uart_txrx.scala 17:23]
  assign txPart_io_channel_valid = io_txchannel_valid; // @[uart_txrx.scala 17:23]
  assign rxPart_clock = clock;
  assign rxPart_reset = reset;
  assign rxPart_io_rxd = txPart_io_txd; // @[uart_txrx.scala 16:19]
endmodule
