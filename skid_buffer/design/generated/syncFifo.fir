circuit syncFifo :
  module syncFifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip WriteInterface : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, ReadInterface : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, full : UInt<1>, empty : UInt<1>, cnt : UInt<4>}

    node _io_full_T = eq(io.cnt, UInt<4>("h9")) @[skid_buffer.scala 93:29]
    io.full <= _io_full_T @[skid_buffer.scala 93:17]
    node _io_empty_T = eq(io.cnt, UInt<1>("h0")) @[skid_buffer.scala 94:29]
    io.empty <= _io_empty_T @[skid_buffer.scala 94:17]
    reg memReg : UInt<8>[10], clock with :
      reset => (UInt<1>("h0"), memReg) @[skid_buffer.scala 95:24]
    wire wen : UInt<1> @[skid_buffer.scala 96:25]
    wire ren : UInt<1> @[skid_buffer.scala 97:25]
    node _wen_T = and(io.WriteInterface.valid, io.WriteInterface.ready) @[skid_buffer.scala 98:45]
    wen <= _wen_T @[skid_buffer.scala 98:17]
    node _ren_T = and(io.ReadInterface.valid, io.ReadInterface.ready) @[skid_buffer.scala 99:45]
    ren <= _ren_T @[skid_buffer.scala 99:17]
    reg wrptr : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[skid_buffer.scala 82:29]
    when wen : @[skid_buffer.scala 83:17]
      node _wrptr_T = bits(wrptr, 3, 0) @[skid_buffer.scala 84:24]
      node _wrptr_T_1 = eq(_wrptr_T, UInt<4>("h9")) @[skid_buffer.scala 84:39]
      when _wrptr_T_1 : @[skid_buffer.scala 84:54]
        node _wrptr_cntReg_T = bits(wrptr, 4, 4) @[skid_buffer.scala 85:37]
        node _wrptr_cntReg_T_1 = add(_wrptr_cntReg_T, UInt<1>("h1")) @[skid_buffer.scala 85:49]
        node _wrptr_cntReg_T_2 = tail(_wrptr_cntReg_T_1, 1) @[skid_buffer.scala 85:49]
        node _wrptr_cntReg_T_3 = cat(_wrptr_cntReg_T_2, UInt<4>("h0")) @[Cat.scala 31:58]
        wrptr <= _wrptr_cntReg_T_3 @[skid_buffer.scala 85:24]
      else :
        node _wrptr_cntReg_T_4 = add(wrptr, UInt<1>("h1")) @[skid_buffer.scala 87:34]
        node _wrptr_cntReg_T_5 = tail(_wrptr_cntReg_T_4, 1) @[skid_buffer.scala 87:34]
        wrptr <= _wrptr_cntReg_T_5 @[skid_buffer.scala 87:24]
    reg rdptr : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[skid_buffer.scala 82:29]
    when ren : @[skid_buffer.scala 83:17]
      node _rdptr_T = bits(rdptr, 3, 0) @[skid_buffer.scala 84:24]
      node _rdptr_T_1 = eq(_rdptr_T, UInt<4>("h9")) @[skid_buffer.scala 84:39]
      when _rdptr_T_1 : @[skid_buffer.scala 84:54]
        node _rdptr_cntReg_T = bits(rdptr, 4, 4) @[skid_buffer.scala 85:37]
        node _rdptr_cntReg_T_1 = add(_rdptr_cntReg_T, UInt<1>("h1")) @[skid_buffer.scala 85:49]
        node _rdptr_cntReg_T_2 = tail(_rdptr_cntReg_T_1, 1) @[skid_buffer.scala 85:49]
        node _rdptr_cntReg_T_3 = cat(_rdptr_cntReg_T_2, UInt<4>("h0")) @[Cat.scala 31:58]
        rdptr <= _rdptr_cntReg_T_3 @[skid_buffer.scala 85:24]
      else :
        node _rdptr_cntReg_T_4 = add(rdptr, UInt<1>("h1")) @[skid_buffer.scala 87:34]
        node _rdptr_cntReg_T_5 = tail(_rdptr_cntReg_T_4, 1) @[skid_buffer.scala 87:34]
        rdptr <= _rdptr_cntReg_T_5 @[skid_buffer.scala 87:24]
    node _io_cnt_T = bits(wrptr, 4, 4) @[skid_buffer.scala 102:32]
    node _io_cnt_T_1 = bits(rdptr, 4, 4) @[skid_buffer.scala 102:54]
    node _io_cnt_T_2 = eq(_io_cnt_T, _io_cnt_T_1) @[skid_buffer.scala 102:45]
    node _io_cnt_T_3 = bits(wrptr, 3, 0) @[skid_buffer.scala 103:30]
    node _io_cnt_T_4 = bits(rdptr, 3, 0) @[skid_buffer.scala 103:50]
    node _io_cnt_T_5 = sub(_io_cnt_T_3, _io_cnt_T_4) @[skid_buffer.scala 103:44]
    node _io_cnt_T_6 = tail(_io_cnt_T_5, 1) @[skid_buffer.scala 103:44]
    node _io_cnt_T_7 = bits(wrptr, 3, 0) @[skid_buffer.scala 104:30]
    node _io_cnt_T_8 = bits(rdptr, 3, 0) @[skid_buffer.scala 104:50]
    node _io_cnt_T_9 = sub(_io_cnt_T_7, _io_cnt_T_8) @[skid_buffer.scala 104:44]
    node _io_cnt_T_10 = tail(_io_cnt_T_9, 1) @[skid_buffer.scala 104:44]
    node _io_cnt_T_11 = add(_io_cnt_T_10, UInt<4>("h9")) @[skid_buffer.scala 104:64]
    node _io_cnt_T_12 = tail(_io_cnt_T_11, 1) @[skid_buffer.scala 104:64]
    node _io_cnt_T_13 = mux(_io_cnt_T_2, _io_cnt_T_6, _io_cnt_T_12) @[skid_buffer.scala 102:25]
    io.cnt <= _io_cnt_T_13 @[skid_buffer.scala 102:17]
    node _io_WriteInterface_ready_T = eq(io.full, UInt<1>("h0")) @[skid_buffer.scala 106:32]
    io.WriteInterface.ready <= _io_WriteInterface_ready_T @[skid_buffer.scala 106:29]
    node _io_ReadInterface_valid_T = eq(io.empty, UInt<1>("h0")) @[skid_buffer.scala 107:32]
    io.ReadInterface.valid <= _io_ReadInterface_valid_T @[skid_buffer.scala 107:29]
    when wen : @[skid_buffer.scala 110:14]
      node _T = bits(wrptr, 3, 0)
      memReg[_T] <= io.WriteInterface.bits @[skid_buffer.scala 111:23]
    node _io_ReadInterface_bits_T = bits(rdptr, 3, 0)
    io.ReadInterface.bits <= memReg[_io_ReadInterface_bits_T] @[skid_buffer.scala 114:27]

