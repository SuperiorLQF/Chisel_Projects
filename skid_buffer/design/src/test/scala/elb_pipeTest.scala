import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random
import scala.collection.mutable.ListBuffer
class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    "DUT" should "pass" in {
        test(new ElbPipe(8,10)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.setTimeout(0)
            dut.io.m_side.bits.poke(10)
            dut.io.m_side.valid.poke(true.B)
            dut.io.s_side.ready.poke(false.B)
            for(i<-1 until 30){
                    
                dut.clock.step() 
            }
        }
    }
}