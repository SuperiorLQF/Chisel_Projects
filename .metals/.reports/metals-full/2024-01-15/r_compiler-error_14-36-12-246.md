file://<WORKSPACE>/skid_buffer/design/src/main/skid_buffer.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 1167
uri: file://<WORKSPACE>/skid_buffer/design/src/main/skid_buffer.scala
text:
```scala
import chisel3._
import chisel3.util._
//DecoupledIO参考如下
//*************************************************
// class DecoupledIO[T <: Data](gen: T) extends Bundle {
//     val ready = Input(Bool())
//     val valid = Output(Bool())
//     val bits = Output(gen)
// }
abstract class VldRdy(Width : Int) extends Module{
    io  =   IO(new Bundle{
        val m_side  =   Flipped(DecoupledIO(UInt(Width.W)))
        val s_side  =   DecoupledIO(UInt(Width.W))
    })
}
class SkidBuffer(Width : Int) extends VldRdy{
    val insert = io.m_side.valid && io.m_side.ready
    val remove = io.s_side.valid && io.s_side.ready
    val empty::busy::full::Nil = Enum(3)
    val state  = RegInit(empty)
    switch(state){
        is(empty){
            state := Mux(insert,busy,empty)
        }
        is(busy){
            state := Mux(insert,Mux(remove,busy,full),Mux(remove,empty,busy))
        }
        is(full){
            state := Mux(remove,busy,full)
            assert(insert ===1 ,"insert happend with full state!")
        }

    }
    val Reg1 = RegInit(0.U(Width.W))
    val Reg2 = RegInit(0.U(Width.W))
    switch(state){
        is(empty){

        }
        is()@@
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