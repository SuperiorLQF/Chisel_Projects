circuit syncFifo :
  module syncFifo :
    input clock : Clock
    input reset : UInt<1>
    output io_WriteInterface_ready : UInt<1>
    input io_WriteInterface_valid : UInt<1>
    input io_WriteInterface_bits : UInt<8>
    input io_ReadInterface_ready : UInt<1>
    output io_ReadInterface_valid : UInt<1>
    output io_ReadInterface_bits : UInt<8>
    output io_full : UInt<1>
    output io_empty : UInt<1>
    output io_cnt : UInt<4>

    node _io_full_T = eq(io_cnt, UInt<4>("h9")) @[fifo.scala 40:29]
    node _io_empty_T = eq(io_cnt, UInt<1>("h0")) @[fifo.scala 41:29]
    reg memReg_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_0) @[fifo.scala 42:24]
    reg memReg_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_1) @[fifo.scala 42:24]
    reg memReg_2 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_2) @[fifo.scala 42:24]
    reg memReg_3 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_3) @[fifo.scala 42:24]
    reg memReg_4 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_4) @[fifo.scala 42:24]
    reg memReg_5 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_5) @[fifo.scala 42:24]
    reg memReg_6 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_6) @[fifo.scala 42:24]
    reg memReg_7 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_7) @[fifo.scala 42:24]
    reg memReg_8 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_8) @[fifo.scala 42:24]
    reg memReg_9 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), memReg_9) @[fifo.scala 42:24]
    node _wen_T = and(io_WriteInterface_valid, io_WriteInterface_ready) @[fifo.scala 45:45]
    node _ren_T = and(io_ReadInterface_valid, io_ReadInterface_ready) @[fifo.scala 46:45]
    reg wrptr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), wrptr) @[fifo.scala 29:29]
    node _wrptr_T = bits(wrptr, 3, 0) @[fifo.scala 31:24]
    node _wrptr_T_1 = eq(_wrptr_T, UInt<4>("h9")) @[fifo.scala 31:39]
    node _wrptr_cntReg_T = bits(wrptr, 4, 4) @[fifo.scala 32:37]
    node _wrptr_cntReg_T_1 = add(_wrptr_cntReg_T, UInt<1>("h1")) @[fifo.scala 32:49]
    node _wrptr_cntReg_T_2 = tail(_wrptr_cntReg_T_1, 1) @[fifo.scala 32:49]
    node _wrptr_cntReg_T_3 = cat(_wrptr_cntReg_T_2, UInt<4>("h0")) @[Cat.scala 31:58]
    node _wrptr_cntReg_T_4 = add(wrptr, UInt<1>("h1")) @[fifo.scala 34:34]
    node _wrptr_cntReg_T_5 = tail(_wrptr_cntReg_T_4, 1) @[fifo.scala 34:34]
    node _GEN_0 = mux(_wrptr_T_1, _wrptr_cntReg_T_3, _wrptr_cntReg_T_5) @[fifo.scala 31:54 32:24 34:24]
    node wen = _wen_T @[fifo.scala 43:25 45:17]
    node _GEN_1 = mux(wen, _GEN_0, wrptr) @[fifo.scala 30:17 29:29]
    reg rdptr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdptr) @[fifo.scala 29:29]
    node _rdptr_T = bits(rdptr, 3, 0) @[fifo.scala 31:24]
    node _rdptr_T_1 = eq(_rdptr_T, UInt<4>("h9")) @[fifo.scala 31:39]
    node _rdptr_cntReg_T = bits(rdptr, 4, 4) @[fifo.scala 32:37]
    node _rdptr_cntReg_T_1 = add(_rdptr_cntReg_T, UInt<1>("h1")) @[fifo.scala 32:49]
    node _rdptr_cntReg_T_2 = tail(_rdptr_cntReg_T_1, 1) @[fifo.scala 32:49]
    node _rdptr_cntReg_T_3 = cat(_rdptr_cntReg_T_2, UInt<4>("h0")) @[Cat.scala 31:58]
    node _rdptr_cntReg_T_4 = add(rdptr, UInt<1>("h1")) @[fifo.scala 34:34]
    node _rdptr_cntReg_T_5 = tail(_rdptr_cntReg_T_4, 1) @[fifo.scala 34:34]
    node _GEN_2 = mux(_rdptr_T_1, _rdptr_cntReg_T_3, _rdptr_cntReg_T_5) @[fifo.scala 31:54 32:24 34:24]
    node ren = _ren_T @[fifo.scala 44:25 46:17]
    node _GEN_3 = mux(ren, _GEN_2, rdptr) @[fifo.scala 30:17 29:29]
    node _io_cnt_T = bits(wrptr, 4, 4) @[fifo.scala 49:32]
    node _io_cnt_T_1 = bits(rdptr, 4, 4) @[fifo.scala 49:54]
    node _io_cnt_T_2 = eq(_io_cnt_T, _io_cnt_T_1) @[fifo.scala 49:45]
    node _io_cnt_T_3 = bits(wrptr, 3, 0) @[fifo.scala 50:30]
    node _io_cnt_T_4 = bits(rdptr, 3, 0) @[fifo.scala 50:50]
    node _io_cnt_T_5 = sub(_io_cnt_T_3, _io_cnt_T_4) @[fifo.scala 50:44]
    node _io_cnt_T_6 = tail(_io_cnt_T_5, 1) @[fifo.scala 50:44]
    node _io_cnt_T_7 = bits(wrptr, 3, 0) @[fifo.scala 51:30]
    node _io_cnt_T_8 = bits(rdptr, 3, 0) @[fifo.scala 51:50]
    node _io_cnt_T_9 = sub(_io_cnt_T_7, _io_cnt_T_8) @[fifo.scala 51:44]
    node _io_cnt_T_10 = tail(_io_cnt_T_9, 1) @[fifo.scala 51:44]
    node _io_cnt_T_11 = add(_io_cnt_T_10, UInt<4>("h9")) @[fifo.scala 51:64]
    node _io_cnt_T_12 = tail(_io_cnt_T_11, 1) @[fifo.scala 51:64]
    node _io_cnt_T_13 = mux(_io_cnt_T_2, _io_cnt_T_6, _io_cnt_T_12) @[fifo.scala 49:25]
    node _io_WriteInterface_ready_T = eq(io_full, UInt<1>("h0")) @[fifo.scala 53:32]
    node _io_ReadInterface_valid_T = eq(io_empty, UInt<1>("h0")) @[fifo.scala 54:32]
    node _T = bits(wrptr, 3, 0)
    node _memReg_T = io_WriteInterface_bits @[fifo.scala 58:{23,23}]
    node _GEN_4 = mux(eq(UInt<1>("h0"), _T), _memReg_T, memReg_0) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_5 = mux(eq(UInt<1>("h1"), _T), _memReg_T, memReg_1) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_6 = mux(eq(UInt<2>("h2"), _T), _memReg_T, memReg_2) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_7 = mux(eq(UInt<2>("h3"), _T), _memReg_T, memReg_3) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_8 = mux(eq(UInt<3>("h4"), _T), _memReg_T, memReg_4) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_9 = mux(eq(UInt<3>("h5"), _T), _memReg_T, memReg_5) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_10 = mux(eq(UInt<3>("h6"), _T), _memReg_T, memReg_6) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_11 = mux(eq(UInt<3>("h7"), _T), _memReg_T, memReg_7) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_12 = mux(eq(UInt<4>("h8"), _T), _memReg_T, memReg_8) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_13 = mux(eq(UInt<4>("h9"), _T), _memReg_T, memReg_9) @[fifo.scala 58:{23,23} 42:24]
    node _GEN_14 = mux(wen, _GEN_4, memReg_0) @[fifo.scala 57:14 42:24]
    node _GEN_15 = mux(wen, _GEN_5, memReg_1) @[fifo.scala 57:14 42:24]
    node _GEN_16 = mux(wen, _GEN_6, memReg_2) @[fifo.scala 57:14 42:24]
    node _GEN_17 = mux(wen, _GEN_7, memReg_3) @[fifo.scala 57:14 42:24]
    node _GEN_18 = mux(wen, _GEN_8, memReg_4) @[fifo.scala 57:14 42:24]
    node _GEN_19 = mux(wen, _GEN_9, memReg_5) @[fifo.scala 57:14 42:24]
    node _GEN_20 = mux(wen, _GEN_10, memReg_6) @[fifo.scala 57:14 42:24]
    node _GEN_21 = mux(wen, _GEN_11, memReg_7) @[fifo.scala 57:14 42:24]
    node _GEN_22 = mux(wen, _GEN_12, memReg_8) @[fifo.scala 57:14 42:24]
    node _GEN_23 = mux(wen, _GEN_13, memReg_9) @[fifo.scala 57:14 42:24]
    node _io_ReadInterface_bits_T = bits(rdptr, 3, 0)
    node _GEN_24 = validif(eq(UInt<1>("h0"), _io_ReadInterface_bits_T), memReg_0) @[fifo.scala 61:{27,27}]
    node _GEN_25 = mux(eq(UInt<1>("h1"), _io_ReadInterface_bits_T), memReg_1, _GEN_24) @[fifo.scala 61:{27,27}]
    node _GEN_26 = mux(eq(UInt<2>("h2"), _io_ReadInterface_bits_T), memReg_2, _GEN_25) @[fifo.scala 61:{27,27}]
    node _GEN_27 = mux(eq(UInt<2>("h3"), _io_ReadInterface_bits_T), memReg_3, _GEN_26) @[fifo.scala 61:{27,27}]
    node _GEN_28 = mux(eq(UInt<3>("h4"), _io_ReadInterface_bits_T), memReg_4, _GEN_27) @[fifo.scala 61:{27,27}]
    node _GEN_29 = mux(eq(UInt<3>("h5"), _io_ReadInterface_bits_T), memReg_5, _GEN_28) @[fifo.scala 61:{27,27}]
    node _GEN_30 = mux(eq(UInt<3>("h6"), _io_ReadInterface_bits_T), memReg_6, _GEN_29) @[fifo.scala 61:{27,27}]
    node _GEN_31 = mux(eq(UInt<3>("h7"), _io_ReadInterface_bits_T), memReg_7, _GEN_30) @[fifo.scala 61:{27,27}]
    node _GEN_32 = mux(eq(UInt<4>("h8"), _io_ReadInterface_bits_T), memReg_8, _GEN_31) @[fifo.scala 61:{27,27}]
    node _GEN_33 = mux(eq(UInt<4>("h9"), _io_ReadInterface_bits_T), memReg_9, _GEN_32) @[fifo.scala 61:{27,27}]
    node _memReg_io_ReadInterface_bits_T = _GEN_33 @[fifo.scala 61:27]
    io_WriteInterface_ready <= _io_WriteInterface_ready_T @[fifo.scala 53:29]
    io_ReadInterface_valid <= _io_ReadInterface_valid_T @[fifo.scala 54:29]
    io_ReadInterface_bits <= _memReg_io_ReadInterface_bits_T @[fifo.scala 61:27]
    io_full <= _io_full_T @[fifo.scala 40:17]
    io_empty <= _io_empty_T @[fifo.scala 41:17]
    io_cnt <= _io_cnt_T_13 @[fifo.scala 49:17]
    memReg_0 <= _GEN_14
    memReg_1 <= _GEN_15
    memReg_2 <= _GEN_16
    memReg_3 <= _GEN_17
    memReg_4 <= _GEN_18
    memReg_5 <= _GEN_19
    memReg_6 <= _GEN_20
    memReg_7 <= _GEN_21
    memReg_8 <= _GEN_22
    memReg_9 <= _GEN_23
    wrptr <= mux(reset, UInt<5>("h0"), _GEN_1) @[fifo.scala 29:{29,29}]
    rdptr <= mux(reset, UInt<5>("h0"), _GEN_3) @[fifo.scala 29:{29,29}]
