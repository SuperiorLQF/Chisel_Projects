import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random
import scala.collection.mutable.ListBuffer
class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    var dataS = 0
    val checklist = new ListBuffer[Int]()//获得空列表
    def SendaByte(dut:syncFifo[UInt],data:UInt) ={
        if(dut.io.WriteInterface.ready.peek().toString()==true.B.toString()){
            dut.io.WriteInterface.bits.poke(data)
            dut.io.WriteInterface.valid.poke(true.B)
            dataS+=:checklist//写入一个数，就向待检查列表中添加一个数，也是fifo
            if(dataS==255){
                dataS =0
            }else{
                dataS = dataS+1
            }
        }else{

            println("fifo is full now")
        }
    }
    def DontSend(dut:syncFifo[UInt])   ={
        dut.io.WriteInterface.valid.poke(false.B)
    }
    def RecvaByte(dut:syncFifo[UInt]) ={
        if(dut.io.ReadInterface.valid.peek().toString()==true.B.toString()){
            dut.io.ReadInterface.ready.poke(true.B)
        val dataR = checklist(checklist.length - 1)//获取最后一个值
            dut.io.ReadInterface.bits.expect(dataR)//检查
            checklist.remove(checklist.length - 1)  
        }else{
            println("fifo is empty now")
        }
    }
    def DontRecv(dut:syncFifo[UInt])  ={
        dut.io.ReadInterface.ready.poke(false.B)
    } 
    def SendIf(dut:syncFifo[UInt]) ={
        var randomNum =Random.nextInt(10)
        if(randomNum >5){
            SendaByte(dut,dataS.U)
        }else{
            DontSend(dut)
        }
    }
    def RecvIf(dut:syncFifo[UInt]) ={
        var randomNum  = Random.nextInt(10)
        if(randomNum >5){
            RecvaByte(dut)
        }else{
            DontRecv(dut)
        }
    }
    "DUT" should "pass" in {
        test(new syncFifo(UInt(8.W),10)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.setTimeout(0)
            
            for (i<- 0 until 10000){
                SendIf(dut)
                RecvIf(dut)
                dut.clock.step()                            
            }
            println(checklist)            
        }
    }
}