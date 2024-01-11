import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    def SendaByte(dut:TxRx,data:UInt) ={
        if(dut.io.txchannel.ready.peek().toString()==true.B.toString()){
            dut.io.txchannel.data.poke(data)
            dut.io.txchannel.valid.poke(true.B)
            dut.clock.step()
            dut.io.txchannel.valid.poke(false.B)
        }else{
            dut.clock.step()
            println("busy now")
        }
    }  
    "DUT" should "pass" in {
        test(new TxRx(1000000,9600)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.setTimeout(0)
            dut.io.rxchannel.ready.poke(true.B)
            SendaByte(dut,"b1010_1010".U)
            for (i<- 0 until 10000){
                dut.clock.step()                            
            }            
        }
    }
}