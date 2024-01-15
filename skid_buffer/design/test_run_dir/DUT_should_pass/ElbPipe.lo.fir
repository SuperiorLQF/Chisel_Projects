circuit ElbPipe :
  module SkidBuffer :
    input clock : Clock
    input reset : UInt<1>
    output io_m_side_ready : UInt<1>
    input io_m_side_valid : UInt<1>
    input io_m_side_bits : UInt<8>
    input io_s_side_ready : UInt<1>
    output io_s_side_valid : UInt<1>
    output io_s_side_bits : UInt<8>

    node insert = and(io_m_side_valid, io_m_side_ready) @[skid_buffer.scala 17:34]
    node remove = and(io_s_side_valid, io_s_side_ready) @[skid_buffer.scala 18:34]
    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[skid_buffer.scala 20:25]
    node _T = eq(UInt<2>("h0"), state) @[skid_buffer.scala 21:18]
    node _state_T = mux(insert, UInt<2>("h1"), UInt<2>("h0")) @[skid_buffer.scala 23:25]
    node _T_1 = eq(UInt<2>("h1"), state) @[skid_buffer.scala 21:18]
    node _state_T_1 = mux(remove, UInt<2>("h1"), UInt<2>("h2")) @[skid_buffer.scala 26:36]
    node _state_T_2 = mux(remove, UInt<2>("h0"), UInt<2>("h1")) @[skid_buffer.scala 26:58]
    node _state_T_3 = mux(insert, _state_T_1, _state_T_2) @[skid_buffer.scala 26:25]
    node _T_2 = eq(UInt<2>("h2"), state) @[skid_buffer.scala 21:18]
    node _state_T_4 = mux(remove, UInt<2>("h1"), UInt<2>("h2")) @[skid_buffer.scala 29:25]
    node _GEN_0 = mux(_T_2, _state_T_4, state) @[skid_buffer.scala 21:18 29:19 20:25]
    node _GEN_1 = mux(_T_1, _state_T_3, _GEN_0) @[skid_buffer.scala 21:18 26:19]
    node _GEN_2 = mux(_T, _state_T, _GEN_1) @[skid_buffer.scala 21:18 23:19]
    reg Reg0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), Reg0) @[Reg.scala 16:16]
    node _En0_T = eq(state, UInt<2>("h1")) @[skid_buffer.scala 42:24]
    node _En0_T_1 = and(_En0_T, insert) @[skid_buffer.scala 42:33]
    node _En0_T_2 = eq(remove, UInt<1>("h0")) @[skid_buffer.scala 42:46]
    node _En0_T_3 = and(_En0_T_1, _En0_T_2) @[skid_buffer.scala 42:43]
    node _En0_T_4 = mux(_En0_T_3, UInt<1>("h1"), UInt<1>("h0")) @[skid_buffer.scala 42:15]
    node En0 = _En0_T_4 @[skid_buffer.scala 34:25 42:9]
    node _GEN_3 = mux(En0, io_m_side_bits, Reg0) @[Reg.scala 16:16 17:{18,22}]
    node _sel_T = eq(state, UInt<2>("h2")) @[skid_buffer.scala 43:23]
    node _sel_T_1 = mux(_sel_T, UInt<1>("h1"), UInt<1>("h0")) @[skid_buffer.scala 43:15]
    node sel = _sel_T_1 @[skid_buffer.scala 35:25 43:9]
    node sel_o = mux(sel, Reg0, io_m_side_bits) @[skid_buffer.scala 38:24]
    reg Reg1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), Reg1) @[Reg.scala 16:16]
    node _En1_T = eq(state, UInt<2>("h0")) @[skid_buffer.scala 44:24]
    node _En1_T_1 = eq(state, UInt<2>("h1")) @[skid_buffer.scala 45:25]
    node _En1_T_2 = eq(remove, UInt<1>("h0")) @[skid_buffer.scala 45:39]
    node _En1_T_3 = and(_En1_T_1, _En1_T_2) @[skid_buffer.scala 45:35]
    node _En1_T_4 = or(_En1_T, _En1_T_3) @[skid_buffer.scala 44:35]
    node _En1_T_5 = eq(state, UInt<2>("h2")) @[skid_buffer.scala 46:25]
    node _En1_T_6 = eq(remove, UInt<1>("h0")) @[skid_buffer.scala 46:39]
    node _En1_T_7 = and(_En1_T_5, _En1_T_6) @[skid_buffer.scala 46:35]
    node _En1_T_8 = or(_En1_T_4, _En1_T_7) @[skid_buffer.scala 45:49]
    node _En1_T_9 = mux(_En1_T_8, UInt<1>("h1"), UInt<1>("h0")) @[skid_buffer.scala 44:15]
    node En1 = _En1_T_9 @[skid_buffer.scala 36:25 44:9]
    node _GEN_4 = mux(En1, sel_o, Reg1) @[Reg.scala 16:16 17:{18,22}]
    node _io_s_side_valid_T = neq(state, UInt<2>("h0")) @[skid_buffer.scala 48:31]
    node _io_m_side_ready_T = neq(state, UInt<2>("h2")) @[skid_buffer.scala 49:31]
    io_m_side_ready <= _io_m_side_ready_T @[skid_buffer.scala 49:21]
    io_s_side_valid <= _io_s_side_valid_T @[skid_buffer.scala 48:21]
    io_s_side_bits <= Reg1 @[skid_buffer.scala 40:20]
    state <= mux(reset, UInt<2>("h0"), _GEN_2) @[skid_buffer.scala 20:{25,25}]
    Reg0 <= _GEN_3
    Reg1 <= _GEN_4

  module ElbPipe :
    input clock : Clock
    input reset : UInt<1>
    output io_m_side_ready : UInt<1>
    input io_m_side_valid : UInt<1>
    input io_m_side_bits : UInt<8>
    input io_s_side_ready : UInt<1>
    output io_s_side_valid : UInt<1>
    output io_s_side_bits : UInt<8>

    inst SkidBufferTempt of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_1 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_2 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_3 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_4 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_5 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_6 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_7 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_8 of SkidBuffer @[elb_pipe.scala 7:35]
    inst SkidBufferTempt_9 of SkidBuffer @[elb_pipe.scala 7:35]
    node DecoupledIO_mid_0_ready = SkidBufferTempt.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_0_valid = io_m_side_valid @[elb_pipe.scala 11:24 5:31]
    node DecoupledIO_mid_0_bits = io_m_side_bits @[elb_pipe.scala 11:24 5:31]
    node DecoupledIO_mid_1_ready = SkidBufferTempt_1.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_1_valid = SkidBufferTempt.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_1_bits = SkidBufferTempt.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_2_ready = SkidBufferTempt_2.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_2_valid = SkidBufferTempt_1.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_2_bits = SkidBufferTempt_1.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_3_ready = SkidBufferTempt_3.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_3_valid = SkidBufferTempt_2.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_3_bits = SkidBufferTempt_2.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_4_ready = SkidBufferTempt_4.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_4_valid = SkidBufferTempt_3.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_4_bits = SkidBufferTempt_3.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_5_ready = SkidBufferTempt_5.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_5_valid = SkidBufferTempt_4.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_5_bits = SkidBufferTempt_4.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_6_ready = SkidBufferTempt_6.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_6_valid = SkidBufferTempt_5.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_6_bits = SkidBufferTempt_5.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_7_ready = SkidBufferTempt_7.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_7_valid = SkidBufferTempt_6.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_7_bits = SkidBufferTempt_6.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_8_ready = SkidBufferTempt_8.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_8_valid = SkidBufferTempt_7.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_8_bits = SkidBufferTempt_7.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_9_ready = SkidBufferTempt_9.io_m_side_ready @[elb_pipe.scala 5:31 8:35]
    node DecoupledIO_mid_9_valid = SkidBufferTempt_8.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_9_bits = SkidBufferTempt_8.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_10_ready = io_s_side_ready @[elb_pipe.scala 12:31 5:31]
    node DecoupledIO_mid_10_valid = SkidBufferTempt_9.io_s_side_valid @[elb_pipe.scala 5:31 9:35]
    node DecoupledIO_mid_10_bits = SkidBufferTempt_9.io_s_side_bits @[elb_pipe.scala 5:31 9:35]
    io_m_side_ready <= DecoupledIO_mid_0_ready @[elb_pipe.scala 11:24]
    io_s_side_valid <= DecoupledIO_mid_10_valid @[elb_pipe.scala 12:31]
    io_s_side_bits <= DecoupledIO_mid_10_bits @[elb_pipe.scala 12:31]
    SkidBufferTempt.clock <= clock
    SkidBufferTempt.reset <= reset
    SkidBufferTempt.io_m_side_valid <= DecoupledIO_mid_0_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt.io_m_side_bits <= DecoupledIO_mid_0_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt.io_s_side_ready <= DecoupledIO_mid_1_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_1.clock <= clock
    SkidBufferTempt_1.reset <= reset
    SkidBufferTempt_1.io_m_side_valid <= DecoupledIO_mid_1_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_1.io_m_side_bits <= DecoupledIO_mid_1_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_1.io_s_side_ready <= DecoupledIO_mid_2_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_2.clock <= clock
    SkidBufferTempt_2.reset <= reset
    SkidBufferTempt_2.io_m_side_valid <= DecoupledIO_mid_2_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_2.io_m_side_bits <= DecoupledIO_mid_2_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_2.io_s_side_ready <= DecoupledIO_mid_3_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_3.clock <= clock
    SkidBufferTempt_3.reset <= reset
    SkidBufferTempt_3.io_m_side_valid <= DecoupledIO_mid_3_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_3.io_m_side_bits <= DecoupledIO_mid_3_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_3.io_s_side_ready <= DecoupledIO_mid_4_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_4.clock <= clock
    SkidBufferTempt_4.reset <= reset
    SkidBufferTempt_4.io_m_side_valid <= DecoupledIO_mid_4_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_4.io_m_side_bits <= DecoupledIO_mid_4_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_4.io_s_side_ready <= DecoupledIO_mid_5_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_5.clock <= clock
    SkidBufferTempt_5.reset <= reset
    SkidBufferTempt_5.io_m_side_valid <= DecoupledIO_mid_5_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_5.io_m_side_bits <= DecoupledIO_mid_5_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_5.io_s_side_ready <= DecoupledIO_mid_6_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_6.clock <= clock
    SkidBufferTempt_6.reset <= reset
    SkidBufferTempt_6.io_m_side_valid <= DecoupledIO_mid_6_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_6.io_m_side_bits <= DecoupledIO_mid_6_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_6.io_s_side_ready <= DecoupledIO_mid_7_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_7.clock <= clock
    SkidBufferTempt_7.reset <= reset
    SkidBufferTempt_7.io_m_side_valid <= DecoupledIO_mid_7_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_7.io_m_side_bits <= DecoupledIO_mid_7_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_7.io_s_side_ready <= DecoupledIO_mid_8_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_8.clock <= clock
    SkidBufferTempt_8.reset <= reset
    SkidBufferTempt_8.io_m_side_valid <= DecoupledIO_mid_8_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_8.io_m_side_bits <= DecoupledIO_mid_8_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_8.io_s_side_ready <= DecoupledIO_mid_9_ready @[elb_pipe.scala 9:35]
    SkidBufferTempt_9.clock <= clock
    SkidBufferTempt_9.reset <= reset
    SkidBufferTempt_9.io_m_side_valid <= DecoupledIO_mid_9_valid @[elb_pipe.scala 8:35]
    SkidBufferTempt_9.io_m_side_bits <= DecoupledIO_mid_9_bits @[elb_pipe.scala 8:35]
    SkidBufferTempt_9.io_s_side_ready <= DecoupledIO_mid_10_ready @[elb_pipe.scala 9:35]
