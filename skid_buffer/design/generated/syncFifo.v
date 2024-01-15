module syncFifo(
  input        clock,
  input        reset,
  output       io_WriteInterface_ready,
  input        io_WriteInterface_valid,
  input  [7:0] io_WriteInterface_bits,
  input        io_ReadInterface_ready,
  output       io_ReadInterface_valid,
  output [7:0] io_ReadInterface_bits,
  output       io_full,
  output       io_empty,
  output [3:0] io_cnt
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] memReg_0; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_1; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_2; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_3; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_4; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_5; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_6; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_7; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_8; // @[skid_buffer.scala 95:24]
  reg [7:0] memReg_9; // @[skid_buffer.scala 95:24]
  wire  wen = io_WriteInterface_valid & io_WriteInterface_ready; // @[skid_buffer.scala 98:45]
  wire  ren = io_ReadInterface_valid & io_ReadInterface_ready; // @[skid_buffer.scala 99:45]
  reg [4:0] wrptr; // @[skid_buffer.scala 82:29]
  wire  _wrptr_cntReg_T_2 = wrptr[4] + 1'h1; // @[skid_buffer.scala 85:49]
  wire [4:0] _wrptr_cntReg_T_3 = {_wrptr_cntReg_T_2,4'h0}; // @[Cat.scala 31:58]
  wire [4:0] _wrptr_cntReg_T_5 = wrptr + 5'h1; // @[skid_buffer.scala 87:34]
  reg [4:0] rdptr; // @[skid_buffer.scala 82:29]
  wire  _rdptr_cntReg_T_2 = rdptr[4] + 1'h1; // @[skid_buffer.scala 85:49]
  wire [4:0] _rdptr_cntReg_T_3 = {_rdptr_cntReg_T_2,4'h0}; // @[Cat.scala 31:58]
  wire [4:0] _rdptr_cntReg_T_5 = rdptr + 5'h1; // @[skid_buffer.scala 87:34]
  wire [3:0] _io_cnt_T_6 = wrptr[3:0] - rdptr[3:0]; // @[skid_buffer.scala 103:44]
  wire [3:0] _io_cnt_T_12 = _io_cnt_T_6 + 4'h9; // @[skid_buffer.scala 104:64]
  wire [7:0] _GEN_25 = 4'h1 == rdptr[3:0] ? memReg_1 : memReg_0; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_26 = 4'h2 == rdptr[3:0] ? memReg_2 : _GEN_25; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_27 = 4'h3 == rdptr[3:0] ? memReg_3 : _GEN_26; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_28 = 4'h4 == rdptr[3:0] ? memReg_4 : _GEN_27; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_29 = 4'h5 == rdptr[3:0] ? memReg_5 : _GEN_28; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_30 = 4'h6 == rdptr[3:0] ? memReg_6 : _GEN_29; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_31 = 4'h7 == rdptr[3:0] ? memReg_7 : _GEN_30; // @[skid_buffer.scala 114:{27,27}]
  wire [7:0] _GEN_32 = 4'h8 == rdptr[3:0] ? memReg_8 : _GEN_31; // @[skid_buffer.scala 114:{27,27}]
  assign io_WriteInterface_ready = ~io_full; // @[skid_buffer.scala 106:32]
  assign io_ReadInterface_valid = ~io_empty; // @[skid_buffer.scala 107:32]
  assign io_ReadInterface_bits = 4'h9 == rdptr[3:0] ? memReg_9 : _GEN_32; // @[skid_buffer.scala 114:{27,27}]
  assign io_full = io_cnt == 4'h9; // @[skid_buffer.scala 93:29]
  assign io_empty = io_cnt == 4'h0; // @[skid_buffer.scala 94:29]
  assign io_cnt = wrptr[4] == rdptr[4] ? _io_cnt_T_6 : _io_cnt_T_12; // @[skid_buffer.scala 102:25]
  always @(posedge clock) begin
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h0 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_0 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h1 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_1 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h2 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_2 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h3 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_3 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h4 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_4 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h5 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_5 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h6 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_6 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h7 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_7 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h8 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_8 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (wen) begin // @[skid_buffer.scala 110:14]
      if (4'h9 == wrptr[3:0]) begin // @[skid_buffer.scala 111:23]
        memReg_9 <= io_WriteInterface_bits; // @[skid_buffer.scala 111:23]
      end
    end
    if (reset) begin // @[skid_buffer.scala 82:29]
      wrptr <= 5'h0; // @[skid_buffer.scala 82:29]
    end else if (wen) begin // @[skid_buffer.scala 83:17]
      if (wrptr[3:0] == 4'h9) begin // @[skid_buffer.scala 84:54]
        wrptr <= _wrptr_cntReg_T_3; // @[skid_buffer.scala 85:24]
      end else begin
        wrptr <= _wrptr_cntReg_T_5; // @[skid_buffer.scala 87:24]
      end
    end
    if (reset) begin // @[skid_buffer.scala 82:29]
      rdptr <= 5'h0; // @[skid_buffer.scala 82:29]
    end else if (ren) begin // @[skid_buffer.scala 83:17]
      if (rdptr[3:0] == 4'h9) begin // @[skid_buffer.scala 84:54]
        rdptr <= _rdptr_cntReg_T_3; // @[skid_buffer.scala 85:24]
      end else begin
        rdptr <= _rdptr_cntReg_T_5; // @[skid_buffer.scala 87:24]
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
  memReg_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  memReg_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  memReg_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  memReg_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  memReg_4 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  memReg_5 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  memReg_6 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  memReg_7 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  memReg_8 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  memReg_9 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  wrptr = _RAND_10[4:0];
  _RAND_11 = {1{`RANDOM}};
  rdptr = _RAND_11[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
