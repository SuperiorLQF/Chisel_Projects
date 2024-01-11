circuit Tx :
  module Tx :
    input clock : Clock
    input reset : UInt<1>
    output io : { txd : UInt<1>, channel : { flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}}

    reg clkCntReg : UInt<20>, clock with :
      reset => (reset, UInt<20>("h0")) @[uart_transmitter.scala 16:28]
    reg bitCntReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[uart_transmitter.scala 17:28]
    reg shiftReg : UInt<11>, clock with :
      reset => (reset, UInt<11>("h7ff")) @[uart_transmitter.scala 18:28]
    node _io_channel_ready_T = eq(clkCntReg, UInt<1>("h0")) @[uart_transmitter.scala 20:35]
    node _io_channel_ready_T_1 = eq(bitCntReg, UInt<1>("h0")) @[uart_transmitter.scala 20:58]
    node _io_channel_ready_T_2 = and(_io_channel_ready_T, _io_channel_ready_T_1) @[uart_transmitter.scala 20:44]
    io.channel.ready <= _io_channel_ready_T_2 @[uart_transmitter.scala 20:22]
    wire insert : UInt<1> @[uart_transmitter.scala 21:22]
    node _insert_T = and(io.channel.ready, io.channel.valid) @[uart_transmitter.scala 22:32]
    insert <= _insert_T @[uart_transmitter.scala 22:12]
    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[uart_transmitter.scala 26:26]
    node _T = eq(UInt<1>("h0"), stateReg) @[uart_transmitter.scala 27:21]
    when _T : @[uart_transmitter.scala 27:21]
      when insert : @[uart_transmitter.scala 29:25]
        stateReg <= UInt<1>("h1") @[uart_transmitter.scala 30:26]
      else :
        stateReg <= UInt<1>("h0") @[uart_transmitter.scala 32:26]
    else :
      node _T_1 = eq(UInt<1>("h1"), stateReg) @[uart_transmitter.scala 27:21]
      when _T_1 : @[uart_transmitter.scala 27:21]
        node _T_2 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 36:29]
        node _T_3 = eq(bitCntReg, UInt<4>("ha")) @[uart_transmitter.scala 36:54]
        node _T_4 = and(_T_2, _T_3) @[uart_transmitter.scala 36:41]
        when _T_4 : @[uart_transmitter.scala 36:67]
          stateReg <= UInt<1>("h0") @[uart_transmitter.scala 37:26]
        else :
          stateReg <= UInt<1>("h1") @[uart_transmitter.scala 39:26]
    node _clkCntReg_T = eq(stateReg, UInt<1>("h1")) @[uart_transmitter.scala 45:32]
    node _clkCntReg_T_1 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 45:57]
    node _clkCntReg_T_2 = add(clkCntReg, UInt<1>("h1")) @[uart_transmitter.scala 45:84]
    node _clkCntReg_T_3 = tail(_clkCntReg_T_2, 1) @[uart_transmitter.scala 45:84]
    node _clkCntReg_T_4 = mux(_clkCntReg_T_1, UInt<1>("h0"), _clkCntReg_T_3) @[uart_transmitter.scala 45:45]
    node _clkCntReg_T_5 = mux(_clkCntReg_T, _clkCntReg_T_4, UInt<1>("h0")) @[uart_transmitter.scala 45:21]
    clkCntReg <= _clkCntReg_T_5 @[uart_transmitter.scala 45:15]
    node _T_5 = eq(stateReg, UInt<1>("h1")) @[uart_transmitter.scala 46:19]
    when _T_5 : @[uart_transmitter.scala 46:28]
      node _T_6 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 47:24]
      when _T_6 : @[uart_transmitter.scala 47:36]
        node _bitCntReg_T = add(bitCntReg, UInt<1>("h1")) @[uart_transmitter.scala 48:36]
        node _bitCntReg_T_1 = tail(_bitCntReg_T, 1) @[uart_transmitter.scala 48:36]
        bitCntReg <= _bitCntReg_T_1 @[uart_transmitter.scala 48:23]
      else :
        bitCntReg <= bitCntReg @[uart_transmitter.scala 50:23]
    else :
      bitCntReg <= UInt<1>("h0") @[uart_transmitter.scala 53:19]
    when insert : @[uart_transmitter.scala 56:17]
      node shiftReg_hi = cat(UInt<2>("h3"), io.channel.data) @[Cat.scala 31:58]
      node _shiftReg_T = cat(shiftReg_hi, UInt<1>("h0")) @[Cat.scala 31:58]
      shiftReg <= _shiftReg_T @[uart_transmitter.scala 57:18]
    else :
      node _T_7 = eq(stateReg, UInt<1>("h1")) @[uart_transmitter.scala 58:26]
      node _T_8 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 58:48]
      node _T_9 = and(_T_7, _T_8) @[uart_transmitter.scala 58:35]
      when _T_9 : @[uart_transmitter.scala 58:61]
        node _shiftReg_T_1 = bits(shiftReg, 10, 0) @[uart_transmitter.scala 59:42]
        node _shiftReg_T_2 = cat(UInt<1>("h1"), _shiftReg_T_1) @[Cat.scala 31:58]
        shiftReg <= _shiftReg_T_2 @[uart_transmitter.scala 59:18]
      else :
        shiftReg <= shiftReg @[uart_transmitter.scala 61:18]
    node _io_txd_T = bits(shiftReg, 0, 0) @[uart_transmitter.scala 64:23]
    io.txd <= _io_txd_T @[uart_transmitter.scala 64:12]

