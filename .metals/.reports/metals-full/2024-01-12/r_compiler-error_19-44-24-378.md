file://<WORKSPACE>/fifo/src/test/scala/fifoTest.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 1165
uri: file://<WORKSPACE>/fifo/src/test/scala/fifoTest.scala
text:
```scala
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random
class SimpleTestExpect extends AnyFlatSpec with ChiselScalatestTester {
    def SendaByte(dut:syncFifo[UInt],data:UInt) ={
        if(dut.io.WriteInterface.ready.peek().toString()==true.B.toString()){
            dut.io.WriteInterface.bits.poke(data)
            dut.io.WriteInterface.valid.poke(true.B)
            // dut.clock.step()
            // dut.io.txchannel.valid.poke(false.B)
        }else{
            // dut.clock.step()
            println("fifo is full now")
        }
    }
    def DontSend(dut:syncFifo[UInt])   ={
        dut.io.WriteInterface.valid.poke(false.B)
    }
    def RecvaByte(dut:syncFifo[UInt]) ={
        if(dut.io.ReadInterface.valid.peek().toString()==true.B.toString()){
            dut.io.ReadInterface.ready.poke(true.B)
            // dut.clock.step()
            // dut.io.txchannel.valid.poke(false.B)
        }else{
            // dut.clock.step()
            println("fifo is empty now")
        }
    }
    def DontRecv(dut:syncFifo[UInt])  ={
        dut.io.ReadInterface.ready.poke(false.B)
    } 
    var data=0.U(@@)
    def SendIf(dut:syncFifo[UInt]) ={
        var randomNum =Random.nextInt(10)
        if(randomNum >5){
            SendaByte(dut,data.U(8.W))
            data = data+1
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
        }
    }
}
```



#### Error stacktrace:

```
scala.collection.LinearSeqOps.apply(LinearSeq.scala:131)
	scala.collection.LinearSeqOps.apply$(LinearSeq.scala:128)
	scala.collection.immutable.List.apply(List.scala:79)
	dotty.tools.dotc.util.Signatures$.countParams(Signatures.scala:501)
	dotty.tools.dotc.util.Signatures$.applyCallInfo(Signatures.scala:186)
	dotty.tools.dotc.util.Signatures$.computeSignatureHelp(Signatures.scala:94)
	dotty.tools.dotc.util.Signatures$.signatureHelp(Signatures.scala:63)
	scala.meta.internal.pc.MetalsSignatures$.signatures(MetalsSignatures.scala:17)
	scala.meta.internal.pc.SignatureHelpProvider$.signatureHelp(SignatureHelpProvider.scala:51)
	scala.meta.internal.pc.ScalaPresentationCompiler.signatureHelp$$anonfun$1(ScalaPresentationCompiler.scala:388)
```
#### Short summary: 

java.lang.IndexOutOfBoundsException: 0