file://<WORKSPACE>/uart_transmitter/src/main/scala/uart_transmitter.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 1423
uri: file://<WORKSPACE>/uart_transmitter/src/main/scala/uart_transmitter.scala
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
        val txd = Output(Bits(1.W))
        val channel = new Channel()
    })

    val CLK_CNT = ((frequency + baudRate/2) / baudRate -1).asUInt //四舍五入,一个bit分配多少clk
    val BIT_CNT = (11-1).U
    val clkCntReg = RegInit(0.U(20.W))//计数一个bit的clk数量
    val bitCntReg = RegInit(0.U(4.W))//计数到第几个bit
    val shiftReg  = RegInit("b11_1111_1111_1".U(11.W))
    val dataReg   = RegInit(0.U(8.W))
    txd := shiftReg(0)

    io.channel.ready :=(clkCntReg === 0.U) && (bitCntReg === 0.U)
    val insert = Wire(Bool())
    insert := io.channel.ready && io.channel.valid
    //FSM
    val IDLE::BUSY::Nil = Enum(2)
    val stateReg =RegInit(IDLE)
    switch(stateReg){
        is(IDLE){
            when(insert){
                stateReg := BUSY
            }.otherwise{
                stateReg := IDLE
            }
        }
        is(BUSY){
            when((clkCntReg === CLK_CNT)&&(bitCntReg === BIT_CNT)){
                stateReg := IDLE
            }.otherwise{
                stateReg := BUSY
            }
            
        }
    }
    clkCntReg := Mux((stateReg === BUSY),Mux((clkCntReg === CLK_CNT),0.U,clkCntReg + 1.U),0.U)
    when(stateReg === BUSY){
        when()@@
    }.otherwise{
        bitCntReg := 0.U
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