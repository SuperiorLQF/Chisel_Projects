import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    def masterSend(dut:FifoBufferRdyVld,data:Int) ={
        var data_o=0
        if(dut.io.WriterInterface.ready.peek().toString() == true.B.toString()){//only send data when fifo is ready
            dut.io.WriterInterface.valid.poke(true.B)
            dut.io.WriterInterface.bits.poke(data.U)
            dut.clock.step()
            dut.io.WriterInterface.valid.poke(false.B)
            data_o=data+1
        }else{
            dut.clock.step()
            data_o=data
        }
        data_o
    }
    def slaveReceive(dut:FifoBufferRdyVld) ={
        if(dut.io.ReaderInterface.valid.peek().toString() == true.B.toString()){//only send data when fifo is ready
            dut.io.ReaderInterface.ready.poke(true.B)
            dut.clock.step()
            dut.io.ReaderInterface.ready.poke(false.B)
        }else{
            dut.clock.step()
        }                    
    }
    "DUT" should "pass" in {
        test(new FifoBufferRdyVld(16)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            var a=0
            for (i<- 0 until 200){
                if(i % 3 ==0){
                    println(a)
                    a=masterSend(dut,a) 
                    println(a)
                }
                             
                if(i % 7 ==0){
                    slaveReceive(dut)
                }
            }            
        }
    }
}