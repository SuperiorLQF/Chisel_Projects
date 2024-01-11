module FifoBuffer(
  input         clock,
  input         reset,
  input         io_WriterInterface_write,
  output        io_WriterInterface_full,
  input  [15:0] io_WriterInterface_din,
  input         io_ReaderInterface_read,
  output        io_ReaderInterface_empty,
  output [15:0] io_ReaderInterface_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[fifo_buffer.scala 21:27]
  wire  _GEN_0 = io_WriterInterface_write | ~io_ReaderInterface_read | stateReg; // @[fifo_buffer.scala 24:75 25:25 21:27]
  reg [15:0] fifoReg; // @[fifo_buffer.scala 37:26]
  reg [15:0] io_ReaderInterface_dout_REG; // @[fifo_buffer.scala 45:41]
  assign io_WriterInterface_full = stateReg; // @[fifo_buffer.scala 34:41]
  assign io_ReaderInterface_empty = ~stateReg; // @[fifo_buffer.scala 35:41]
  assign io_ReaderInterface_dout = io_ReaderInterface_read ? io_ReaderInterface_dout_REG : 16'h0; // @[fifo_buffer.scala 43:28 44:34 45:32]
  always @(posedge clock) begin
    if (reset) begin // @[fifo_buffer.scala 21:27]
      stateReg <= 1'h0; // @[fifo_buffer.scala 21:27]
    end else if (~stateReg) begin // @[fifo_buffer.scala 22:21]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[fifo_buffer.scala 22:21]
      if (~io_WriterInterface_write | io_ReaderInterface_read) begin // @[fifo_buffer.scala 29:75]
        stateReg <= 1'h0; // @[fifo_buffer.scala 30:25]
      end
    end
    if (reset) begin // @[fifo_buffer.scala 37:26]
      fifoReg <= 16'h0; // @[fifo_buffer.scala 37:26]
    end else if (io_WriterInterface_write) begin // @[fifo_buffer.scala 39:35]
      fifoReg <= io_WriterInterface_din; // @[fifo_buffer.scala 40:17]
    end
    io_ReaderInterface_dout_REG <= fifoReg; // @[fifo_buffer.scala 45:41]
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
  stateReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  fifoReg = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_ReaderInterface_dout_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
