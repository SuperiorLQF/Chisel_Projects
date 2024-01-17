module AdderWrapper(
  input         clock,
  input         reset,
  input  [31:0] io_a,
  input  [31:0] io_b,
  output [31:0] io_sum
);
  wire [31:0] adder_a; // @[test.scala 34:21]
  wire [31:0] adder_b; // @[test.scala 34:21]
  wire [31:0] adder_sum; // @[test.scala 34:21]
  InlineBlackBoxAdder adder ( // @[test.scala 34:21]
    .a(adder_a),
    .b(adder_b),
    .sum(adder_sum)
  );
  assign io_sum = adder_sum; // @[test.scala 37:10]
  assign adder_a = io_a; // @[test.scala 35:14]
  assign adder_b = io_b; // @[test.scala 36:15]
endmodule
