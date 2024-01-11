circuit timer :
  module timer :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din : UInt<8>, flip load : UInt<1>, done : UInt<1>}

    reg cntReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[timer.scala 9:28]
    node _io_done_T = eq(cntReg, UInt<1>("h0")) @[timer.scala 10:28]
    io.done <= _io_done_T @[timer.scala 10:16]
    node _T = eq(io.load, UInt<1>("h1")) @[timer.scala 11:17]
    when _T : @[timer.scala 11:24]
      cntReg <= io.din @[timer.scala 12:17]
    else :
      node _T_1 = eq(io.done, UInt<1>("h0")) @[timer.scala 13:23]
      when _T_1 : @[timer.scala 13:30]
        node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[timer.scala 14:28]
        node _cntReg_T_1 = tail(_cntReg_T, 1) @[timer.scala 14:28]
        cntReg <= _cntReg_T_1 @[timer.scala 14:17]
      else :
        cntReg <= UInt<1>("h0") @[timer.scala 16:17]

