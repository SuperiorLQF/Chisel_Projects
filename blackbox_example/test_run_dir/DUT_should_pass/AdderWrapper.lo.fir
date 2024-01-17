circuit AdderWrapper :
  extmodule BlackBoxAdder :
    input a : UInt<32>
    input b : UInt<32>
    output sum : UInt<32>
    defname = BlackBoxAdder

  module AdderWrapper :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<32>
    input io_b : UInt<32>
    output io_sum : UInt<32>

    inst adder of BlackBoxAdder @[test.scala 34:21]
    io_sum <= adder.sum @[test.scala 37:10]
    adder.a <= io_a @[test.scala 35:14]
    adder.b <= io_b @[test.scala 36:15]
