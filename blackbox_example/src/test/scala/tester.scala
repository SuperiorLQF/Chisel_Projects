import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random
import scala.collection.mutable.ListBuffer
// Test class for the Adder
class BlackBoxAdderTester extends AnyFlatSpec with ChiselScalatestTester {
   "DUT" should "pass" in  {
    test(new AdderWrapper).withAnnotations(Seq(VerilatorBackendAnnotation)) { c =>
      c.io.a.poke(15.U)
      c.io.b.poke(10.U)
      c.clock.step(1)
      c.io.sum.expect(25.U)
    }
  }

}
