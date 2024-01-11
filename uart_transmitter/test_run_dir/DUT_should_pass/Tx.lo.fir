circuit Tx :
  module Tx :
    input clock : Clock
    input reset : UInt<1>
    output io_txd : UInt<1>
    input io_channel_data : UInt<8>
    output io_channel_ready : UInt<1>
    input io_channel_valid : UInt<1>

    reg clkCntReg : UInt<20>, clock with :
      reset => (UInt<1>("h0"), clkCntReg) @[uart_transmitter.scala 16:28]
    reg bitCntReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), bitCntReg) @[uart_transmitter.scala 17:28]
    reg shiftReg : UInt<11>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[uart_transmitter.scala 18:28]
    node _io_channel_ready_T = eq(clkCntReg, UInt<1>("h0")) @[uart_transmitter.scala 20:35]
    node _io_channel_ready_T_1 = eq(bitCntReg, UInt<1>("h0")) @[uart_transmitter.scala 20:58]
    node _io_channel_ready_T_2 = and(_io_channel_ready_T, _io_channel_ready_T_1) @[uart_transmitter.scala 20:44]
    node _insert_T = and(io_channel_ready, io_channel_valid) @[uart_transmitter.scala 22:32]
    reg stateReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[uart_transmitter.scala 26:26]
    node _T = eq(UInt<1>("h0"), stateReg) @[uart_transmitter.scala 27:21]
    node insert = _insert_T @[uart_transmitter.scala 21:22 22:12]
    node _GEN_0 = mux(insert, UInt<1>("h1"), UInt<1>("h0")) @[uart_transmitter.scala 29:25 30:26 32:26]
    node _T_1 = eq(UInt<1>("h1"), stateReg) @[uart_transmitter.scala 27:21]
    node _T_2 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 36:29]
    node _T_3 = eq(bitCntReg, UInt<4>("ha")) @[uart_transmitter.scala 36:54]
    node _T_4 = and(_T_2, _T_3) @[uart_transmitter.scala 36:41]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), UInt<1>("h1")) @[uart_transmitter.scala 36:67 37:26 39:26]
    node _GEN_2 = mux(_T_1, _GEN_1, stateReg) @[uart_transmitter.scala 27:21 26:26]
    node _GEN_3 = mux(_T, _GEN_0, _GEN_2) @[uart_transmitter.scala 27:21]
    node _clkCntReg_T = eq(stateReg, UInt<1>("h1")) @[uart_transmitter.scala 45:32]
    node _clkCntReg_T_1 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 45:57]
    node _clkCntReg_T_2 = add(clkCntReg, UInt<1>("h1")) @[uart_transmitter.scala 45:84]
    node _clkCntReg_T_3 = tail(_clkCntReg_T_2, 1) @[uart_transmitter.scala 45:84]
    node _clkCntReg_T_4 = mux(_clkCntReg_T_1, UInt<1>("h0"), _clkCntReg_T_3) @[uart_transmitter.scala 45:45]
    node _clkCntReg_T_5 = mux(_clkCntReg_T, _clkCntReg_T_4, UInt<1>("h0")) @[uart_transmitter.scala 45:21]
    node _T_5 = eq(stateReg, UInt<1>("h1")) @[uart_transmitter.scala 46:19]
    node _T_6 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 47:24]
    node _bitCntReg_T = add(bitCntReg, UInt<1>("h1")) @[uart_transmitter.scala 48:36]
    node _bitCntReg_T_1 = tail(_bitCntReg_T, 1) @[uart_transmitter.scala 48:36]
    node _GEN_4 = mux(_T_6, _bitCntReg_T_1, bitCntReg) @[uart_transmitter.scala 47:36 48:23 50:23]
    node _GEN_5 = mux(_T_5, _GEN_4, UInt<1>("h0")) @[uart_transmitter.scala 46:28 53:19]
    node shiftReg_hi = cat(UInt<2>("h3"), io_channel_data) @[Cat.scala 31:58]
    node _shiftReg_T = cat(shiftReg_hi, UInt<1>("h0")) @[Cat.scala 31:58]
    node _T_7 = eq(stateReg, UInt<1>("h1")) @[uart_transmitter.scala 58:26]
    node _T_8 = eq(clkCntReg, UInt<7>("h67")) @[uart_transmitter.scala 58:48]
    node _T_9 = and(_T_7, _T_8) @[uart_transmitter.scala 58:35]
    node _shiftReg_T_1 = bits(shiftReg, 10, 1) @[uart_transmitter.scala 59:42]
    node _shiftReg_T_2 = cat(UInt<1>("h1"), _shiftReg_T_1) @[Cat.scala 31:58]
    node _GEN_6 = mux(_T_9, _shiftReg_T_2, shiftReg) @[uart_transmitter.scala 58:61 59:18 61:18]
    node _GEN_7 = mux(insert, _shiftReg_T, _GEN_6) @[uart_transmitter.scala 56:17 57:18]
    node _io_txd_T = bits(shiftReg, 0, 0) @[uart_transmitter.scala 64:23]
    io_txd <= _io_txd_T @[uart_transmitter.scala 64:12]
    io_channel_ready <= _io_channel_ready_T_2 @[uart_transmitter.scala 20:22]
    clkCntReg <= mux(reset, UInt<20>("h0"), _clkCntReg_T_5) @[uart_transmitter.scala 16:{28,28} 45:15]
    bitCntReg <= mux(reset, UInt<4>("h0"), _GEN_5) @[uart_transmitter.scala 17:{28,28}]
    shiftReg <= mux(reset, UInt<11>("h7ff"), _GEN_7) @[uart_transmitter.scala 18:{28,28}]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_3) @[uart_transmitter.scala 26:{26,26}]
