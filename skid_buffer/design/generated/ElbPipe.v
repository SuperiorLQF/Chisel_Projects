module SkidBuffer(
  input        clock,
  input        reset,
  output       io_m_side_ready,
  input        io_m_side_valid,
  input  [7:0] io_m_side_bits,
  input        io_s_side_ready,
  output       io_s_side_valid,
  output [7:0] io_s_side_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  insert = io_m_side_valid & io_m_side_ready; // @[skid_buffer.scala 17:34]
  wire  remove = io_s_side_valid & io_s_side_ready; // @[skid_buffer.scala 18:34]
  reg [1:0] state; // @[skid_buffer.scala 20:25]
  wire  _T = 2'h0 == state; // @[skid_buffer.scala 21:18]
  wire  _T_1 = 2'h1 == state; // @[skid_buffer.scala 21:18]
  wire [1:0] _state_T_1 = remove ? 2'h1 : 2'h2; // @[skid_buffer.scala 26:36]
  wire [1:0] _state_T_2 = remove ? 2'h0 : 2'h1; // @[skid_buffer.scala 26:58]
  wire  _T_2 = 2'h2 == state; // @[skid_buffer.scala 21:18]
  reg [7:0] Reg0; // @[Reg.scala 16:16]
  wire  En0 = state == 2'h1 & insert; // @[skid_buffer.scala 42:33]
  wire  sel = state == 2'h2; // @[skid_buffer.scala 43:23]
  reg [7:0] Reg1; // @[Reg.scala 16:16]
  wire  En1 = state != 2'h0; // @[skid_buffer.scala 44:23]
  assign io_m_side_ready = state != 2'h2; // @[skid_buffer.scala 47:31]
  assign io_s_side_valid = state != 2'h0; // @[skid_buffer.scala 46:31]
  assign io_s_side_bits = Reg1; // @[skid_buffer.scala 40:20]
  always @(posedge clock) begin
    if (reset) begin // @[skid_buffer.scala 20:25]
      state <= 2'h0; // @[skid_buffer.scala 20:25]
    end else if (2'h0 == state) begin // @[skid_buffer.scala 21:18]
      if (insert) begin // @[skid_buffer.scala 23:25]
        state <= 2'h1;
      end else begin
        state <= 2'h0;
      end
    end else if (2'h1 == state) begin // @[skid_buffer.scala 21:18]
      if (insert) begin // @[skid_buffer.scala 26:25]
        state <= _state_T_1;
      end else begin
        state <= _state_T_2;
      end
    end else if (2'h2 == state) begin // @[skid_buffer.scala 21:18]
      state <= _state_T_1; // @[skid_buffer.scala 29:19]
    end
    if (En0) begin // @[Reg.scala 17:18]
      Reg0 <= io_m_side_bits; // @[Reg.scala 17:22]
    end
    if (En1) begin // @[Reg.scala 17:18]
      if (sel) begin // @[skid_buffer.scala 38:24]
        Reg1 <= Reg0;
      end else begin
        Reg1 <= io_m_side_bits;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_T & ~_T_1 & _T_2 & ~reset & ~insert) begin
          $fwrite(32'h80000002,
            "Assertion failed: insert happend with full state!\n    at skid_buffer.scala:30 assert(insert === true.B ,\"insert happend with full state!\")\n"
            ); // @[skid_buffer.scala 30:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T & ~_T_1 & _T_2 & ~reset & ~insert) begin
          $fatal; // @[skid_buffer.scala 30:19]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
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
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  Reg0 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  Reg1 = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ElbPipe(
  input        clock,
  input        reset,
  output       io_m_side_ready,
  input        io_m_side_valid,
  input  [7:0] io_m_side_bits,
  input        io_s_side_ready,
  output       io_s_side_valid,
  output [7:0] io_s_side_bits
);
  wire  SkidBufferTempt_clock; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_reset; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_io_m_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_io_m_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_io_m_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_io_s_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_io_s_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_io_s_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_1_clock; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_1_reset; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_1_io_m_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_1_io_m_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_1_io_m_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_1_io_s_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_1_io_s_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_1_io_s_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_2_clock; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_2_reset; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_2_io_m_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_2_io_m_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_2_io_m_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_2_io_s_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_2_io_s_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_2_io_s_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_3_clock; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_3_reset; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_3_io_m_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_3_io_m_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_3_io_m_side_bits; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_3_io_s_side_ready; // @[elb_pipe.scala 19:35]
  wire  SkidBufferTempt_3_io_s_side_valid; // @[elb_pipe.scala 19:35]
  wire [7:0] SkidBufferTempt_3_io_s_side_bits; // @[elb_pipe.scala 19:35]
  SkidBuffer SkidBufferTempt ( // @[elb_pipe.scala 19:35]
    .clock(SkidBufferTempt_clock),
    .reset(SkidBufferTempt_reset),
    .io_m_side_ready(SkidBufferTempt_io_m_side_ready),
    .io_m_side_valid(SkidBufferTempt_io_m_side_valid),
    .io_m_side_bits(SkidBufferTempt_io_m_side_bits),
    .io_s_side_ready(SkidBufferTempt_io_s_side_ready),
    .io_s_side_valid(SkidBufferTempt_io_s_side_valid),
    .io_s_side_bits(SkidBufferTempt_io_s_side_bits)
  );
  SkidBuffer SkidBufferTempt_1 ( // @[elb_pipe.scala 19:35]
    .clock(SkidBufferTempt_1_clock),
    .reset(SkidBufferTempt_1_reset),
    .io_m_side_ready(SkidBufferTempt_1_io_m_side_ready),
    .io_m_side_valid(SkidBufferTempt_1_io_m_side_valid),
    .io_m_side_bits(SkidBufferTempt_1_io_m_side_bits),
    .io_s_side_ready(SkidBufferTempt_1_io_s_side_ready),
    .io_s_side_valid(SkidBufferTempt_1_io_s_side_valid),
    .io_s_side_bits(SkidBufferTempt_1_io_s_side_bits)
  );
  SkidBuffer SkidBufferTempt_2 ( // @[elb_pipe.scala 19:35]
    .clock(SkidBufferTempt_2_clock),
    .reset(SkidBufferTempt_2_reset),
    .io_m_side_ready(SkidBufferTempt_2_io_m_side_ready),
    .io_m_side_valid(SkidBufferTempt_2_io_m_side_valid),
    .io_m_side_bits(SkidBufferTempt_2_io_m_side_bits),
    .io_s_side_ready(SkidBufferTempt_2_io_s_side_ready),
    .io_s_side_valid(SkidBufferTempt_2_io_s_side_valid),
    .io_s_side_bits(SkidBufferTempt_2_io_s_side_bits)
  );
  SkidBuffer SkidBufferTempt_3 ( // @[elb_pipe.scala 19:35]
    .clock(SkidBufferTempt_3_clock),
    .reset(SkidBufferTempt_3_reset),
    .io_m_side_ready(SkidBufferTempt_3_io_m_side_ready),
    .io_m_side_valid(SkidBufferTempt_3_io_m_side_valid),
    .io_m_side_bits(SkidBufferTempt_3_io_m_side_bits),
    .io_s_side_ready(SkidBufferTempt_3_io_s_side_ready),
    .io_s_side_valid(SkidBufferTempt_3_io_s_side_valid),
    .io_s_side_bits(SkidBufferTempt_3_io_s_side_bits)
  );
  assign io_m_side_ready = SkidBufferTempt_io_m_side_ready; // @[elb_pipe.scala 17:31 20:35]
  assign io_s_side_valid = SkidBufferTempt_3_io_s_side_valid; // @[elb_pipe.scala 17:31 21:35]
  assign io_s_side_bits = SkidBufferTempt_3_io_s_side_bits; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_clock = clock;
  assign SkidBufferTempt_reset = reset;
  assign SkidBufferTempt_io_m_side_valid = io_m_side_valid; // @[elb_pipe.scala 17:31 23:24]
  assign SkidBufferTempt_io_m_side_bits = io_m_side_bits; // @[elb_pipe.scala 17:31 23:24]
  assign SkidBufferTempt_io_s_side_ready = SkidBufferTempt_1_io_m_side_ready; // @[elb_pipe.scala 17:31 20:35]
  assign SkidBufferTempt_1_clock = clock;
  assign SkidBufferTempt_1_reset = reset;
  assign SkidBufferTempt_1_io_m_side_valid = SkidBufferTempt_io_s_side_valid; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_1_io_m_side_bits = SkidBufferTempt_io_s_side_bits; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_1_io_s_side_ready = SkidBufferTempt_2_io_m_side_ready; // @[elb_pipe.scala 17:31 20:35]
  assign SkidBufferTempt_2_clock = clock;
  assign SkidBufferTempt_2_reset = reset;
  assign SkidBufferTempt_2_io_m_side_valid = SkidBufferTempt_1_io_s_side_valid; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_2_io_m_side_bits = SkidBufferTempt_1_io_s_side_bits; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_2_io_s_side_ready = SkidBufferTempt_3_io_m_side_ready; // @[elb_pipe.scala 17:31 20:35]
  assign SkidBufferTempt_3_clock = clock;
  assign SkidBufferTempt_3_reset = reset;
  assign SkidBufferTempt_3_io_m_side_valid = SkidBufferTempt_2_io_s_side_valid; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_3_io_m_side_bits = SkidBufferTempt_2_io_s_side_bits; // @[elb_pipe.scala 17:31 21:35]
  assign SkidBufferTempt_3_io_s_side_ready = io_s_side_ready; // @[elb_pipe.scala 17:31 24:31]
endmodule
