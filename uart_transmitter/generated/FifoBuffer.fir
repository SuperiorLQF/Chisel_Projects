circuit FifoBuffer :
  module FifoBuffer :
    input clock : Clock
    input reset : UInt<1>
    output io : { WriterInterface : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<16>}, ReaderInterface : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<16>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[fifo_buffer.scala 21:27]
    node _T = eq(UInt<1>("h0"), stateReg) @[fifo_buffer.scala 22:21]
    when _T : @[fifo_buffer.scala 22:21]
      node _T_1 = eq(io.ReaderInterface.read, UInt<1>("h0")) @[fifo_buffer.scala 24:49]
      node _T_2 = or(io.WriterInterface.write, _T_1) @[fifo_buffer.scala 24:45]
      when _T_2 : @[fifo_buffer.scala 24:75]
        stateReg <= UInt<1>("h1") @[fifo_buffer.scala 25:25]
    else :
      node _T_3 = eq(UInt<1>("h1"), stateReg) @[fifo_buffer.scala 22:21]
      when _T_3 : @[fifo_buffer.scala 22:21]
        node _T_4 = eq(io.WriterInterface.write, UInt<1>("h0")) @[fifo_buffer.scala 29:19]
        node _T_5 = or(_T_4, io.ReaderInterface.read) @[fifo_buffer.scala 29:46]
        when _T_5 : @[fifo_buffer.scala 29:75]
          stateReg <= UInt<1>("h0") @[fifo_buffer.scala 30:25]
    node _io_WriterInterface_full_T = eq(stateReg, UInt<1>("h1")) @[fifo_buffer.scala 34:41]
    io.WriterInterface.full <= _io_WriterInterface_full_T @[fifo_buffer.scala 34:29]
    node _io_ReaderInterface_empty_T = eq(stateReg, UInt<1>("h0")) @[fifo_buffer.scala 35:41]
    io.ReaderInterface.empty <= _io_ReaderInterface_empty_T @[fifo_buffer.scala 35:29]
    reg fifoReg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[fifo_buffer.scala 37:26]
    when io.WriterInterface.write : @[fifo_buffer.scala 39:35]
      fifoReg <= io.WriterInterface.din @[fifo_buffer.scala 40:17]
    io.ReaderInterface.dout <= UInt<1>("h0") @[fifo_buffer.scala 43:28]
    when io.ReaderInterface.read : @[fifo_buffer.scala 44:34]
      reg io_ReaderInterface_dout_REG : UInt, clock with :
        reset => (UInt<1>("h0"), io_ReaderInterface_dout_REG) @[fifo_buffer.scala 45:41]
      io_ReaderInterface_dout_REG <= fifoReg @[fifo_buffer.scala 45:41]
      io.ReaderInterface.dout <= io_ReaderInterface_dout_REG @[fifo_buffer.scala 45:32]

