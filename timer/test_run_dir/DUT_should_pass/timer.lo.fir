circuit timer :
  module timer :
    input clock : Clock
    input reset : UInt<1>
    input io_din : UInt<8>
    input io_load : UInt<1>
    output io_done : UInt<1>

    reg cntReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[timer.scala 9:28]
    node _io_done_T = eq(cntReg, UInt<1>("h0")) @[timer.scala 10:28]
    node _T = eq(io_load, UInt<1>("h1")) @[timer.scala 11:17]
    node _T_1 = eq(io_done, UInt<1>("h0")) @[timer.scala 13:23]
    node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[timer.scala 14:28]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[timer.scala 14:28]
    node _GEN_0 = mux(_T_1, _cntReg_T_1, UInt<1>("h0")) @[timer.scala 13:30 14:17 16:17]
    node _GEN_1 = mux(_T, io_din, _GEN_0) @[timer.scala 11:24 12:17]
    io_done <= _io_done_T @[timer.scala 10:16]
    cntReg <= mux(reset, UInt<8>("h0"), _GEN_1) @[timer.scala 9:{28,28}]
