file://<WORKSPACE>/uart_transmitter/src/main/scala/uart_transmitter.scala
### java.lang.AssertionError: assertion failed: NoType

occurred in the presentation compiler.

action parameters:
offset: 628
uri: file://<WORKSPACE>/uart_transmitter/src/main/scala/uart_transmitter.scala
text:
```scala
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

    val BIT_CNT = ((frequency + baudRate/2) / baudRate -1).asUInt //四舍五入,一个bit分配多少clk
    val shiftReg = RegInit(0x7ff.U(11.W))//1+8+2bit
    val cntReg  =   RegInit(0.U(20.W))
    val bitsReg =   RegInit(0.U(4.W))

    io.channel.ready :=(cntReg === 0.U) && (bitsReg === 0.U)
    io.txd := shiftReg(0)

    When(cntReg === 0.U){
        c@@
    }
    




}

```



#### Error stacktrace:

```
scala.runtime.Scala3RunTime$.assertFailed(Scala3RunTime.scala:8)
	dotty.tools.dotc.core.Types$TypeBounds.<init>(Types.scala:5141)
	dotty.tools.dotc.core.Types$AliasingBounds.<init>(Types.scala:5220)
	dotty.tools.dotc.core.Types$TypeAlias.<init>(Types.scala:5242)
	dotty.tools.dotc.core.Types$TypeAlias$.apply(Types.scala:5279)
	dotty.tools.dotc.core.Types$Type.bounds(Types.scala:1732)
	scala.meta.internal.pc.completions.CaseKeywordCompletion$.contribute(MatchCaseCompletions.scala:156)
	scala.meta.internal.pc.completions.Completions.advancedCompletions(Completions.scala:442)
	scala.meta.internal.pc.completions.Completions.completions(Completions.scala:183)
	scala.meta.internal.pc.completions.CompletionProvider.completions(CompletionProvider.scala:86)
	scala.meta.internal.pc.ScalaPresentationCompiler.complete$$anonfun$1(ScalaPresentationCompiler.scala:136)
```
#### Short summary: 

java.lang.AssertionError: assertion failed: NoType