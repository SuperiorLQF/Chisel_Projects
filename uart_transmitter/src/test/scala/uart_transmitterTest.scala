import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    def SendaByte(dut:Tx,data:UInt) ={
        if(dut.io.channel.ready.peek().toString()==true.B.toString()){
            dut.io.channel.data.poke(data)
            dut.io.channel.valid.poke(true.B)
            dut.clock.step()
            dut.io.channel.valid.poke(false.B)
        }else{
            dut.clock.step()
            println(dut.io.channel.ready.toString())
            println(true.B.toString())
            println("busy now")
        }
    }
    "DUT" should "pass" in {
        test(new Tx(1000000,9600)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.setTimeout(0)
            SendaByte(dut,"b1010_1010".U)
            for (i<- 0 until 10000){
                dut.clock.step()                            
            }            
        }
    }
}