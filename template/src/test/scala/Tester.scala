import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random
import scala.collection.mutable.ListBuffer
// Test class for the Adder
class XXXX extends AnyFlatSpec with ChiselScalatestTester {
   "DUT" should "pass" in  {
    test(new YYYY).withAnnotations(Seq(VerilatorBackendAnnotation)) { dut =>
      dut.io.a.poke(15.U)
      dut.io.b.poke(10.U)
      dut.clock.step(1)
      dut.io.sum.expect(25.U)
    }
  }

}
