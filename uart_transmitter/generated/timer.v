module timer(
  input        clock,
  input        reset,
  input  [7:0] io_din,
  input        io_load,
  output       io_done
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] cntReg; // @[timer.scala 9:28]
  wire [7:0] _cntReg_T_1 = cntReg - 8'h1; // @[timer.scala 14:28]
  assign io_done = cntReg == 8'h0; // @[timer.scala 10:28]
  always @(posedge clock) begin
    if (reset) begin // @[timer.scala 9:28]
      cntReg <= 8'h0; // @[timer.scala 9:28]
    end else if (io_load) begin // @[timer.scala 11:24]
      cntReg <= io_din; // @[timer.scala 12:17]
    end else if (~io_done) begin // @[timer.scala 13:30]
      cntReg <= _cntReg_T_1; // @[timer.scala 14:17]
    end else begin
      cntReg <= 8'h0; // @[timer.scala 16:17]
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
  cntReg = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
