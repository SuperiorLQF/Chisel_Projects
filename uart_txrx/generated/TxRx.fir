circuit TxRx :
  module Tx :
    input clock : Clock
    input reset : Reset
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
        node _shiftReg_T_1 = bits(shiftReg, 10, 1) @[uart_transmitter.scala 59:42]
        node _shiftReg_T_2 = cat(UInt<1>("h1"), _shiftReg_T_1) @[Cat.scala 31:58]
        shiftReg <= _shiftReg_T_2 @[uart_transmitter.scala 59:18]
      else :
        shiftReg <= shiftReg @[uart_transmitter.scala 61:18]
    node _io_txd_T = bits(shiftReg, 0, 0) @[uart_transmitter.scala 64:23]
    io.txd <= _io_txd_T @[uart_transmitter.scala 64:12]

  module Rx :
    input clock : Clock
    input reset : Reset
    output io : { flip rxd : UInt<1>, flip channel : { flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}}

    reg clkCntReg : UInt<20>, clock with :
      reset => (reset, UInt<20>("h0")) @[uart_receiver.scala 18:28]
    reg bitCntReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[uart_receiver.scala 19:28]
    reg shiftReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h3ff")) @[uart_receiver.scala 20:28]
    reg rxdReg_REG : UInt, clock with :
      reset => (UInt<1>("h0"), rxdReg_REG) @[uart_receiver.scala 21:36]
    rxdReg_REG <= io.rxd @[uart_receiver.scala 21:36]
    reg rxdReg : UInt, clock with :
      reset => (UInt<1>("h0"), rxdReg) @[uart_receiver.scala 21:28]
    rxdReg <= rxdReg_REG @[uart_receiver.scala 21:28]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[uart_receiver.scala 24:26]
    node _T = eq(UInt<2>("h0"), stateReg) @[uart_receiver.scala 25:21]
    when _T : @[uart_receiver.scala 25:21]
      node _T_1 = eq(rxdReg, UInt<1>("h0")) @[uart_receiver.scala 27:26]
      when _T_1 : @[uart_receiver.scala 27:34]
        stateReg <= UInt<2>("h1") @[uart_receiver.scala 28:26]
      else :
        stateReg <= UInt<2>("h0") @[uart_receiver.scala 30:26]
    else :
      node _T_2 = eq(UInt<2>("h1"), stateReg) @[uart_receiver.scala 25:21]
      when _T_2 : @[uart_receiver.scala 25:21]
        node _T_3 = eq(clkCntReg, UInt<29>("h1f79bfff")) @[uart_receiver.scala 34:28]
        when _T_3 : @[uart_receiver.scala 34:46]
          stateReg <= UInt<2>("h2") @[uart_receiver.scala 35:26]
        else :
          stateReg <= UInt<2>("h1") @[uart_receiver.scala 37:26]
      else :
        node _T_4 = eq(UInt<2>("h2"), stateReg) @[uart_receiver.scala 25:21]
        when _T_4 : @[uart_receiver.scala 25:21]
          node _T_5 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 42:29]
          node _T_6 = eq(bitCntReg, UInt<4>("ha")) @[uart_receiver.scala 42:54]
          node _T_7 = and(_T_5, _T_6) @[uart_receiver.scala 42:41]
          when _T_7 : @[uart_receiver.scala 42:67]
            stateReg <= UInt<2>("h0") @[uart_receiver.scala 43:26]
          else :
            stateReg <= UInt<2>("h2") @[uart_receiver.scala 45:26]
    node _T_8 = eq(stateReg, UInt<2>("h1")) @[uart_receiver.scala 51:19]
    when _T_8 : @[uart_receiver.scala 51:29]
      node _T_9 = eq(clkCntReg, UInt<29>("h1f79bfff")) @[uart_receiver.scala 52:24]
      when _T_9 : @[uart_receiver.scala 52:42]
        clkCntReg <= UInt<1>("h0") @[uart_receiver.scala 53:23]
      else :
        node _clkCntReg_T = add(clkCntReg, UInt<1>("h1")) @[uart_receiver.scala 55:36]
        node _clkCntReg_T_1 = tail(_clkCntReg_T, 1) @[uart_receiver.scala 55:36]
        clkCntReg <= _clkCntReg_T_1 @[uart_receiver.scala 55:23]
    else :
      node _T_10 = eq(stateReg, UInt<2>("h2")) @[uart_receiver.scala 57:25]
      when _T_10 : @[uart_receiver.scala 57:34]
        node _T_11 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 58:24]
        when _T_11 : @[uart_receiver.scala 58:36]
          clkCntReg <= UInt<1>("h0") @[uart_receiver.scala 59:23]
        else :
          node _clkCntReg_T_2 = add(clkCntReg, UInt<1>("h1")) @[uart_receiver.scala 61:36]
          node _clkCntReg_T_3 = tail(_clkCntReg_T_2, 1) @[uart_receiver.scala 61:36]
          clkCntReg <= _clkCntReg_T_3 @[uart_receiver.scala 61:23]
      else :
        clkCntReg <= UInt<1>("h0") @[uart_receiver.scala 64:19]
    node _T_12 = eq(stateReg, UInt<2>("h1")) @[uart_receiver.scala 67:19]
    when _T_12 : @[uart_receiver.scala 67:29]
      node _T_13 = eq(clkCntReg, UInt<29>("h1f79bfff")) @[uart_receiver.scala 68:24]
      when _T_13 : @[uart_receiver.scala 68:42]
        node _bitCntReg_T = add(bitCntReg, UInt<1>("h1")) @[uart_receiver.scala 69:36]
        node _bitCntReg_T_1 = tail(_bitCntReg_T, 1) @[uart_receiver.scala 69:36]
        bitCntReg <= _bitCntReg_T_1 @[uart_receiver.scala 69:23]
      else :
        bitCntReg <= bitCntReg @[uart_receiver.scala 71:23]
    else :
      node _T_14 = eq(stateReg, UInt<2>("h2")) @[uart_receiver.scala 73:25]
      when _T_14 : @[uart_receiver.scala 73:34]
        node _T_15 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 74:24]
        when _T_15 : @[uart_receiver.scala 74:36]
          node _bitCntReg_T_2 = add(bitCntReg, UInt<1>("h1")) @[uart_receiver.scala 75:36]
          node _bitCntReg_T_3 = tail(_bitCntReg_T_2, 1) @[uart_receiver.scala 75:36]
          bitCntReg <= _bitCntReg_T_3 @[uart_receiver.scala 75:23]
        else :
          bitCntReg <= bitCntReg @[uart_receiver.scala 77:23]
      else :
        bitCntReg <= UInt<1>("h0") @[uart_receiver.scala 80:19]
    node _T_16 = eq(stateReg, UInt<2>("h2")) @[uart_receiver.scala 83:20]
    node _T_17 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 83:42]
    node _T_18 = and(_T_16, _T_17) @[uart_receiver.scala 83:29]
    when _T_18 : @[uart_receiver.scala 83:55]
      node _shiftReg_T = bits(shiftReg, 8, 0) @[uart_receiver.scala 84:33]
      node _shiftReg_T_1 = cat(_shiftReg_T, rxdReg) @[Cat.scala 31:58]
      shiftReg <= _shiftReg_T_1 @[uart_receiver.scala 84:18]
    else :
      shiftReg <= shiftReg @[uart_receiver.scala 86:18]
    node _T_19 = eq(clkCntReg, UInt<7>("h67")) @[uart_receiver.scala 90:21]
    node _T_20 = eq(bitCntReg, UInt<4>("ha")) @[uart_receiver.scala 90:46]
    node _T_21 = and(_T_19, _T_20) @[uart_receiver.scala 90:33]
    when _T_21 : @[uart_receiver.scala 90:59]
      io.channel.valid <= UInt<1>("h1") @[uart_receiver.scala 91:26]
      io.channel.data <= shiftReg @[uart_receiver.scala 92:26]
    else :
      io.channel.valid <= UInt<1>("h0") @[uart_receiver.scala 94:26]
      io.channel.data <= UInt<1>("h0") @[uart_receiver.scala 95:26]

  module TxRx :
    input clock : Clock
    input reset : UInt<1>
    output io : { txchannel : { flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}, flip rxchannel : { flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}}

    inst txPart of Tx @[uart_txrx.scala 14:24]
    txPart.clock <= clock
    txPart.reset <= reset
    inst rxPart of Rx @[uart_txrx.scala 15:24]
    rxPart.clock <= clock
    rxPart.reset <= reset
    rxPart.io.rxd <= txPart.io.txd @[uart_txrx.scala 16:19]
    txPart.io.channel.valid <= io.txchannel.valid @[uart_txrx.scala 17:23]
    io.txchannel.ready <= txPart.io.channel.ready @[uart_txrx.scala 17:23]
    txPart.io.channel.data <= io.txchannel.data @[uart_txrx.scala 17:23]
    rxPart.io.channel <= io.rxchannel @[uart_txrx.scala 18:18]

