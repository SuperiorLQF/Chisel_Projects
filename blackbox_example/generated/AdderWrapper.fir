circuit AdderWrapper :
  extmodule InlineBlackBoxAdder :
    input a : UInt<32>
    input b : UInt<32>
    output sum : UInt<32>
    defname = InlineBlackBoxAdder

  module AdderWrapper :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<32>, flip b : UInt<32>, sum : UInt<32>}

    inst adder of InlineBlackBoxAdder @[test.scala 34:21]
    adder.sum is invalid
    adder.b is invalid
    adder.a is invalid
    adder.a <= io.a @[test.scala 35:14]
    adder.b <= io.b @[test.scala 36:15]
    io.sum <= adder.sum @[test.scala 37:10]

