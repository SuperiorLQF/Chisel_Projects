file://<WORKSPACE>/fifo/src/main/scala/fifo.scala
### java.lang.AssertionError: assertion failed: NoType

occurred in the presentation compiler.

action parameters:
offset: 627
uri: file://<WORKSPACE>/fifo/src/main/scala/fifo.scala
text:
```scala
abstract class Fifo[T <: Data](gen: T, val depth: Int) extends Module {
    val io = IO(new FIfoIO(gen))
    assert(depth >0,"Number of buffer elements needs to be larger than 0.")
}
class FIfoIO[T <: Data](private val gen:T) extends Bundle{
    val WriteInterface = Flipped(new DecoupledIO(gen))
    val ReadInterface  = new DecoupledIO(gen)
}

class syncFifo[T <: Data](gen:T,depth: Int) extends Fifo(gen: T, depth:Int){
    def counter(depth: Int, incr :Bool):(UInt,UInt)={
        val cntReg = RegInit(0.U(log2Ceil(depth).W))
        val nextVal= Mux(cntReg === (depth-1).U,0.U,cntReg+1.U)
        when(incr){
            c@@
        }
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