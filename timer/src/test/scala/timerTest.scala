import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    "DUT" should "pass" in {
        test(new timer).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.io.din.poke(20.U)
            dut.io.load.poke(1.U)
            dut.clock.step()
            dut.io.load.poke(0.U)
            for (i<- 0 until 200){
                dut.clock.step()
            }
        //   var ref=1
        //   for(i<- 0 until 16){
        //     dut.io.in.poke(ref.U)
        //     dut.clock.step()
        //     println("Result is: " + dut.io.out.peek().toString)
        //     dut.io.out.expect(i.U)
        //     ref=ref<<1
        //   }
        }
    }
}