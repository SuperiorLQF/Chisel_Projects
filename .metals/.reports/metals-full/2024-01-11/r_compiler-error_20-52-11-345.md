file://<WORKSPACE>/uart_receiver/src/main/scala/uart_receiver.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 1050
uri: file://<WORKSPACE>/uart_receiver/src/main/scala/uart_receiver.scala
text:
```scala
import chisel3._
import chisel3.util._
class Channel extends Bundle{
    val data  = Input(Bits(8.W))
    val ready = Output(Bool())
    val valid = Input(Bool())
}
class Tx(frequency: Int, baudRate: Int) extends Module{
    val io=IO(new Bundle {
        val rxd = Input(Bits(1.W))
        val channel = Flipped(new Channel())
    })

    val CLK_CNT = ((frequency + baudRate/2) / baudRate -1).asUInt //四舍五入,一个bit分配多少clk
    val START_CLK_CNT = ((3*frequency + baudRate/2) / 2*baudRate -1).asUInt
    val BIT_CNT = (11-1).U
    
    val clkCntReg = RegInit(0.U(20.W))//计数一个bit的clk数量
    val bitCntReg = RegInit(10.U(4.W))//计数到第几个bit
    val shiftReg  = RegInit("b11_1111_1111_1".U(11.W))
    val rxdReg  =   RegNext(RegNext(io.rxd))//同步器
    //FSM
    val idle::start::busy::Nil = Enum(3)
    val stateReg =RegInit(idle)
    switch(stateReg){
        is(idle){
            when( rxdReg === 0.U){
                stateReg := start
            }.otherwise{
                stateReg := idle
            }
        }
        is(start){
            when()@@
        }
        is(busy){
            when((clkCntReg === CLK_CNT)&&(bitCntReg === BIT_CNT)){
                stateReg := idle
            }.otherwise{
                stateReg := busy
            }
            
        }
    }
    //cnt logic
    clkCntReg := Mux((stateReg === busy),Mux((clkCntReg === CLK_CNT),0.U,clkCntReg + 1.U),0.U)
    when(stateReg === busy){
        when(clkCntReg === CLK_CNT){
            bitCntReg := bitCntReg +1.U
        }.otherwise{
            bitCntReg := bitCntReg
        }
    }.otherwise{
        bitCntReg := 0.U
    }
    //shift logic
    when(insert){
        shiftReg := Cat("b11".U(2.W),io.channel.data.asUInt(),0.U(1.W))        
    }.elsewhen((stateReg === busy)&&(clkCntReg === CLK_CNT)){
        shiftReg := Cat(1.U(1.W),shiftReg(10,1))
    }.otherwise{
        shiftReg := shiftReg
    }

    io.txd := shiftReg(0)
}
object Tx extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Tx(1000000,9600),
  Array("--target-dir","generated"))
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