circuit SkidBuffer :
  module SkidBuffer :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip m_side : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, s_side : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    node insert = and(io.m_side.valid, io.m_side.ready) @[skid_buffer.scala 17:34]
    node remove = and(io.s_side.valid, io.s_side.ready) @[skid_buffer.scala 18:34]
    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[skid_buffer.scala 20:25]
    node _T = eq(UInt<2>("h0"), state) @[skid_buffer.scala 21:18]
    when _T : @[skid_buffer.scala 21:18]
      node _state_T = mux(insert, UInt<2>("h1"), UInt<2>("h0")) @[skid_buffer.scala 23:25]
      state <= _state_T @[skid_buffer.scala 23:19]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[skid_buffer.scala 21:18]
      when _T_1 : @[skid_buffer.scala 21:18]
        node _state_T_1 = mux(remove, UInt<2>("h1"), UInt<2>("h2")) @[skid_buffer.scala 26:36]
        node _state_T_2 = mux(remove, UInt<2>("h0"), UInt<2>("h1")) @[skid_buffer.scala 26:58]
        node _state_T_3 = mux(insert, _state_T_1, _state_T_2) @[skid_buffer.scala 26:25]
        state <= _state_T_3 @[skid_buffer.scala 26:19]
      else :
        node _T_2 = eq(UInt<2>("h2"), state) @[skid_buffer.scala 21:18]
        when _T_2 : @[skid_buffer.scala 21:18]
          node _state_T_4 = mux(remove, UInt<2>("h1"), UInt<2>("h2")) @[skid_buffer.scala 29:25]
          state <= _state_T_4 @[skid_buffer.scala 29:19]
          node _T_3 = eq(insert, UInt<1>("h1")) @[skid_buffer.scala 30:27]
          node _T_4 = bits(reset, 0, 0) @[skid_buffer.scala 30:19]
          node _T_5 = eq(_T_4, UInt<1>("h0")) @[skid_buffer.scala 30:19]
          when _T_5 : @[skid_buffer.scala 30:19]
            node _T_6 = eq(_T_3, UInt<1>("h0")) @[skid_buffer.scala 30:19]
            when _T_6 : @[skid_buffer.scala 30:19]
              printf(clock, UInt<1>("h1"), "Assertion failed: insert happend with full state!\n    at skid_buffer.scala:30 assert(insert === true.B ,\"insert happend with full state!\")\n") : printf @[skid_buffer.scala 30:19]
            assert(clock, _T_3, UInt<1>("h1"), "") : assert @[skid_buffer.scala 30:19]
    wire En0 : UInt<1> @[skid_buffer.scala 34:25]
    wire sel : UInt<1> @[skid_buffer.scala 35:25]
    wire En1 : UInt<1> @[skid_buffer.scala 36:25]
    reg Reg0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), Reg0) @[Reg.scala 16:16]
    when En0 : @[Reg.scala 17:18]
      Reg0 <= io.m_side.bits @[Reg.scala 17:22]
    node sel_o = mux(sel, Reg0, io.m_side.bits) @[skid_buffer.scala 38:24]
    reg Reg1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), Reg1) @[Reg.scala 16:16]
    when En1 : @[Reg.scala 17:18]
      Reg1 <= sel_o @[Reg.scala 17:22]
    io.s_side.bits <= Reg1 @[skid_buffer.scala 40:20]
    node _En0_T = eq(state, UInt<2>("h1")) @[skid_buffer.scala 42:24]
    node _En0_T_1 = and(_En0_T, insert) @[skid_buffer.scala 42:33]
    node _En0_T_2 = mux(_En0_T_1, UInt<1>("h1"), UInt<1>("h0")) @[skid_buffer.scala 42:15]
    En0 <= _En0_T_2 @[skid_buffer.scala 42:9]
    node _sel_T = eq(state, UInt<2>("h2")) @[skid_buffer.scala 43:23]
    node _sel_T_1 = mux(_sel_T, UInt<1>("h1"), UInt<1>("h0")) @[skid_buffer.scala 43:15]
    sel <= _sel_T_1 @[skid_buffer.scala 43:9]
    node _En1_T = neq(state, UInt<2>("h0")) @[skid_buffer.scala 44:23]
    node _En1_T_1 = mux(_En1_T, UInt<1>("h1"), UInt<1>("h0")) @[skid_buffer.scala 44:15]
    En1 <= _En1_T_1 @[skid_buffer.scala 44:9]
    node _io_s_side_valid_T = neq(state, UInt<2>("h0")) @[skid_buffer.scala 46:31]
    io.s_side.valid <= _io_s_side_valid_T @[skid_buffer.scala 46:21]
    node _io_m_side_ready_T = neq(state, UInt<2>("h2")) @[skid_buffer.scala 47:31]
    io.m_side.ready <= _io_m_side_ready_T @[skid_buffer.scala 47:21]

