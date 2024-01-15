circuit TxRx :
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

  module Rx :
    input clock : Clock
    input reset : UInt<1>
    input io_rxd : UInt<1>
    output io_channel_data : UInt<8>
    input io_channel_ready : UInt<1>
    output io_channel_valid : UInt<1>

    reg clkCntReg : UInt<20>, clock with :
      reset => (UInt<1>("h0"), clkCntReg) @[uart_receiver.scala 19:28]
    reg bitCntReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), bitCntReg) @[uart_receiver.scala 20:28]
    reg shiftReg : UInt<10>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[uart_receiver.scala 21:28]
    reg rxdReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxdReg_REG) @[uart_receiver.scala 22:36]
    reg rxdReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxdReg) @[uart_receiver.scala 22:28]
    reg stateReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[uart_receiver.scala 25:26]
    node _T = eq(UInt<2>("h0"), stateReg) @[uart_receiver.scala 26:21]
    node _T_1 = eq(rxdReg, UInt<1>("h0")) @[uart_receiver.scala 28:26]
    node _GEN_0 = mux(_T_1, UInt<2>("h1"), UInt<2>("h0")) @[uart_receiver.scala 28:34 29:26 31:26]
    node _T_2 = eq(UInt<2>("h1"), stateReg) @[uart_receiver.scala 26:21]
    node _T_3 = eq(clkCntReg, UInt<6>("h33")) @[uart_receiver.scala 35:28]
    node _GEN_1 = mux(_T_3, UInt<2>("h2"), UInt<2>("h1")) @[uart_receiver.scala 35:46 36:26 38:26]
    node _T_4 = eq(UInt<2>("h2"), stateReg) @[uart_receiver.scala 26:21]
    node _T_5 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 43:29]
    node _T_6 = eq(bitCntReg, UInt<4>("ha")) @[uart_receiver.scala 43:54]
    node _T_7 = and(_T_5, _T_6) @[uart_receiver.scala 43:41]
    node _GEN_2 = mux(_T_7, UInt<2>("h0"), UInt<2>("h2")) @[uart_receiver.scala 43:67 44:26 46:26]
    node _GEN_3 = mux(_T_4, _GEN_2, stateReg) @[uart_receiver.scala 26:21 25:26]
    node _GEN_4 = mux(_T_2, _GEN_1, _GEN_3) @[uart_receiver.scala 26:21]
    node _GEN_5 = mux(_T, _GEN_0, _GEN_4) @[uart_receiver.scala 26:21]
    node _T_8 = eq(stateReg, UInt<2>("h1")) @[uart_receiver.scala 52:19]
    node _T_9 = eq(clkCntReg, UInt<6>("h33")) @[uart_receiver.scala 53:24]
    node _clkCntReg_T = add(clkCntReg, UInt<1>("h1")) @[uart_receiver.scala 56:36]
    node _clkCntReg_T_1 = tail(_clkCntReg_T, 1) @[uart_receiver.scala 56:36]
    node _GEN_6 = mux(_T_9, UInt<1>("h0"), _clkCntReg_T_1) @[uart_receiver.scala 53:42 54:23 56:23]
    node _T_10 = eq(stateReg, UInt<2>("h2")) @[uart_receiver.scala 58:25]
    node _T_11 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 59:24]
    node _clkCntReg_T_2 = add(clkCntReg, UInt<1>("h1")) @[uart_receiver.scala 62:36]
    node _clkCntReg_T_3 = tail(_clkCntReg_T_2, 1) @[uart_receiver.scala 62:36]
    node _GEN_7 = mux(_T_11, UInt<1>("h0"), _clkCntReg_T_3) @[uart_receiver.scala 59:36 60:23 62:23]
    node _GEN_8 = mux(_T_10, _GEN_7, UInt<1>("h0")) @[uart_receiver.scala 58:34 65:19]
    node _GEN_9 = mux(_T_8, _GEN_6, _GEN_8) @[uart_receiver.scala 52:29]
    node _T_12 = eq(stateReg, UInt<2>("h1")) @[uart_receiver.scala 68:19]
    node _T_13 = eq(clkCntReg, UInt<6>("h33")) @[uart_receiver.scala 69:24]
    node _bitCntReg_T = add(bitCntReg, UInt<1>("h1")) @[uart_receiver.scala 70:36]
    node _bitCntReg_T_1 = tail(_bitCntReg_T, 1) @[uart_receiver.scala 70:36]
    node _GEN_10 = mux(_T_13, _bitCntReg_T_1, bitCntReg) @[uart_receiver.scala 69:42 70:23 72:23]
    node _T_14 = eq(stateReg, UInt<2>("h2")) @[uart_receiver.scala 74:25]
    node _T_15 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 75:24]
    node _bitCntReg_T_2 = add(bitCntReg, UInt<1>("h1")) @[uart_receiver.scala 76:36]
    node _bitCntReg_T_3 = tail(_bitCntReg_T_2, 1) @[uart_receiver.scala 76:36]
    node _GEN_11 = mux(_T_15, _bitCntReg_T_3, bitCntReg) @[uart_receiver.scala 75:36 76:23 78:23]
    node _GEN_12 = mux(_T_14, _GEN_11, UInt<1>("h0")) @[uart_receiver.scala 74:34 81:19]
    node _GEN_13 = mux(_T_12, _GEN_10, _GEN_12) @[uart_receiver.scala 68:29]
    node _T_16 = eq(stateReg, UInt<2>("h2")) @[uart_receiver.scala 84:20]
    node _T_17 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 84:42]
    node _T_18 = and(_T_16, _T_17) @[uart_receiver.scala 84:29]
    node _shiftReg_T = bits(shiftReg, 8, 0) @[uart_receiver.scala 85:33]
    node _shiftReg_T_1 = cat(_shiftReg_T, rxdReg) @[Cat.scala 31:58]
    node _GEN_14 = mux(_T_18, _shiftReg_T_1, shiftReg) @[uart_receiver.scala 84:55 85:18 87:18]
    node _T_19 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 91:21]
    node _T_20 = eq(bitCntReg, UInt<4>("ha")) @[uart_receiver.scala 91:46]
    node _T_21 = and(_T_19, _T_20) @[uart_receiver.scala 91:33]
    node _io_channel_data_T = bits(shiftReg, 9, 2) @[uart_receiver.scala 93:37]
    node _GEN_15 = mux(_T_21, UInt<1>("h1"), UInt<1>("h0")) @[uart_receiver.scala 91:59 92:26 95:26]
    node _GEN_16 = mux(_T_21, _io_channel_data_T, UInt<1>("h0")) @[uart_receiver.scala 91:59 93:26 96:26]
    io_channel_data <= _GEN_16
    io_channel_valid <= _GEN_15
    clkCntReg <= mux(reset, UInt<20>("h0"), _GEN_9) @[uart_receiver.scala 19:{28,28}]
    bitCntReg <= mux(reset, UInt<4>("h0"), _GEN_13) @[uart_receiver.scala 20:{28,28}]
    shiftReg <= mux(reset, UInt<10>("h3ff"), _GEN_14) @[uart_receiver.scala 21:{28,28}]
    rxdReg_REG <= io_rxd @[uart_receiver.scala 22:36]
    rxdReg <= rxdReg_REG @[uart_receiver.scala 22:28]
    stateReg <= mux(reset, UInt<2>("h0"), _GEN_5) @[uart_receiver.scala 25:{26,26}]

  module TxRx :
    input clock : Clock
    input reset : UInt<1>
    input io_txchannel_data : UInt<8>
    output io_txchannel_ready : UInt<1>
    input io_txchannel_valid : UInt<1>
    output io_rxchannel_data : UInt<8>
    input io_rxchannel_ready : UInt<1>
    output io_rxchannel_valid : UInt<1>

    inst txPart of Tx @[uart_txrx.scala 17:24]
    inst rxPart of Rx @[uart_txrx.scala 18:24]
    io_txchannel_ready <= txPart.io_channel_ready @[uart_txrx.scala 20:23]
    io_rxchannel_data <= rxPart.io_channel_data @[uart_txrx.scala 21:18]
    io_rxchannel_valid <= rxPart.io_channel_valid @[uart_txrx.scala 21:18]
    txPart.clock <= clock
    txPart.reset <= reset
    txPart.io_channel_data <= io_txchannel_data @[uart_txrx.scala 20:23]
    txPart.io_channel_valid <= io_txchannel_valid @[uart_txrx.scala 20:23]
    rxPart.clock <= clock
    rxPart.reset <= reset
    rxPart.io_rxd <= txPart.io_txd @[uart_txrx.scala 19:19]
    rxPart.io_channel_ready <= io_rxchannel_ready @[uart_txrx.scala 21:18]
