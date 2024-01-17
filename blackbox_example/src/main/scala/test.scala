import chisel3._
import chisel3.util._

// BlackBox wrapper for the Verilog Adder module
class BlackBoxAdder extends  HasBlackBoxInline {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val sum = Output(UInt(32.W))
  })

  setInline("BlackBoxAdder.v",
    s"""
    |module BlackBoxAdder(
    |    input [31:0] a,
    |    input [31:0] b,
    |    output [31:0] sum
    |);
    |
    |assign sum = a + b;
    |
    |endmodule
    """.stripMargin)
}

// Chisel Module that instantiates the BlackBox
class AdderWrapper extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val sum = Output(UInt(32.W))
  })

  val adder = Module(new BlackBoxAdder)
  adder.io.a := io.a
   adder.io.b :=io.b
  io.sum := adder.io.sum
}
object AdderWrapper extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new AdderWrapper,
  Array("--target-dir","generated"))
}