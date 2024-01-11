circuit FifoBufferRdyVld :
  module FifoBuffer :
    input clock : Clock
    input reset : UInt<1>
    input io_WriterInterface_write : UInt<1>
    output io_WriterInterface_full : UInt<1>
    input io_WriterInterface_din : UInt<16>
    input io_ReaderInterface_read : UInt<1>
    output io_ReaderInterface_empty : UInt<1>
    output io_ReaderInterface_dout : UInt<16>

    reg stateReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[fifo_buffer.scala 21:27]
    node _T = eq(UInt<1>("h0"), stateReg) @[fifo_buffer.scala 22:21]
    node _T_1 = eq(io_ReaderInterface_read, UInt<1>("h0")) @[fifo_buffer.scala 24:49]
    node _T_2 = and(io_WriterInterface_write, _T_1) @[fifo_buffer.scala 24:45]
    node _GEN_0 = mux(_T_2, UInt<1>("h1"), stateReg) @[fifo_buffer.scala 24:75 25:25 21:27]
    node _T_3 = eq(UInt<1>("h1"), stateReg) @[fifo_buffer.scala 22:21]
    node _T_4 = eq(io_WriterInterface_write, UInt<1>("h0")) @[fifo_buffer.scala 29:19]
    node _T_5 = and(_T_4, io_ReaderInterface_read) @[fifo_buffer.scala 29:46]
    node _GEN_1 = mux(_T_5, UInt<1>("h0"), stateReg) @[fifo_buffer.scala 29:75 30:25 21:27]
    node _GEN_2 = mux(_T_3, _GEN_1, stateReg) @[fifo_buffer.scala 22:21 21:27]
    node _GEN_3 = mux(_T, _GEN_0, _GEN_2) @[fifo_buffer.scala 22:21]
    node _io_WriterInterface_full_T = eq(stateReg, UInt<1>("h1")) @[fifo_buffer.scala 34:41]
    node _io_ReaderInterface_empty_T = eq(stateReg, UInt<1>("h0")) @[fifo_buffer.scala 35:41]
    reg fifoReg : UInt<16>, clock with :
      reset => (UInt<1>("h0"), fifoReg) @[fifo_buffer.scala 37:26]
    node _GEN_4 = mux(io_WriterInterface_write, io_WriterInterface_din, fifoReg) @[fifo_buffer.scala 39:35 40:17 37:26]
    reg io_ReaderInterface_dout_REG : UInt<16>, clock with :
      reset => (UInt<1>("h0"), io_ReaderInterface_dout_REG) @[fifo_buffer.scala 45:41]
    node _GEN_5 = mux(io_ReaderInterface_read, io_ReaderInterface_dout_REG, UInt<1>("h0")) @[fifo_buffer.scala 43:28 44:34 45:32]
    io_WriterInterface_full <= _io_WriterInterface_full_T @[fifo_buffer.scala 34:29]
    io_ReaderInterface_empty <= _io_ReaderInterface_empty_T @[fifo_buffer.scala 35:29]
    io_ReaderInterface_dout <= _GEN_5
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_3) @[fifo_buffer.scala 21:{27,27}]
    fifoReg <= mux(reset, UInt<16>("h0"), _GEN_4) @[fifo_buffer.scala 37:{26,26}]
    io_ReaderInterface_dout_REG <= fifoReg @[fifo_buffer.scala 45:41]

  module FifoBufferRdyVld :
    input clock : Clock
    input reset : UInt<1>
    output io_WriterInterface_ready : UInt<1>
    input io_WriterInterface_valid : UInt<1>
    input io_WriterInterface_bits : UInt<16>
    input io_ReaderInterface_ready : UInt<1>
    output io_ReaderInterface_valid : UInt<1>
    output io_ReaderInterface_bits : UInt<16>

    inst fifoBuffer of FifoBuffer @[fifo_buffer.scala 55:27]
    node _io_WriterInterface_ready_T = eq(fifoBuffer.io_WriterInterface_full, UInt<1>("h0")) @[fifo_buffer.scala 59:33]
    node _io_ReaderInterface_valid_T = eq(fifoBuffer.io_ReaderInterface_empty, UInt<1>("h0")) @[fifo_buffer.scala 60:33]
    node _fifoBuffer_io_WriterInterface_write_T = and(io_WriterInterface_valid, io_WriterInterface_ready) @[fifo_buffer.scala 62:70]
    node _fifoBuffer_io_ReaderInterface_read_T = and(io_ReaderInterface_valid, io_ReaderInterface_ready) @[fifo_buffer.scala 63:70]
    io_WriterInterface_ready <= _io_WriterInterface_ready_T @[fifo_buffer.scala 59:30]
    io_ReaderInterface_valid <= _io_ReaderInterface_valid_T @[fifo_buffer.scala 60:30]
    io_ReaderInterface_bits <= fifoBuffer.io_ReaderInterface_dout @[fifo_buffer.scala 57:29]
    fifoBuffer.clock <= clock
    fifoBuffer.reset <= reset
    fifoBuffer.io_WriterInterface_write <= _fifoBuffer_io_WriterInterface_write_T @[fifo_buffer.scala 62:41]
    fifoBuffer.io_WriterInterface_din <= io_WriterInterface_bits @[fifo_buffer.scala 56:39]
    fifoBuffer.io_ReaderInterface_read <= _fifoBuffer_io_ReaderInterface_read_T @[fifo_buffer.scala 63:41]
