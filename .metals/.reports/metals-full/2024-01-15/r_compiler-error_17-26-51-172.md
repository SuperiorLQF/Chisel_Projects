file://<WORKSPACE>/skid_buffer/design/src/main/scala/elb_pipe.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 631
uri: file://<WORKSPACE>/skid_buffer/design/src/main/scala/elb_pipe.scala
text:
```scala
import chisel3._
import chisel3.util._
import scala.collection.mutable.ListBuffer
class ElbPipe(Width:Int,GroupNum : Int) extends VldRdy(Width:Int){
    //方式1：借助可变列表获得索引
    // val SkidBufferlist = new ListBuffer[SkidBuffer]()//获得空列表
    // for(i<-0 until GroupNum){
    //     SkidBufferlist+=Module(new SkidBuffer(Width))
    // }
    // println(SkidBufferlist.length)
    // for(i<-0 until (GroupNum-1)){
    //     SkidBufferlist(i).io.s_side <> SkidBufferlist(i+1).io.m_side
    // }
    // SkidBufferlist(0).io.m_side <> io.m_side
    // SkidBufferlist(GroupNum-1).io.s_side <> io.s_side
    //另一种方式就是不用到引用名，直接级联，如下
    for (@@)
    for(i<-0 until GroupNum){
        Module(new SkidBuffer(Width)).io.m_side <> DecoupledIO_mid(i)
        Module(new SkidBuffer(Width)).io.s_side <> DecoupledIO_mid(i+1)
    }
    DecoupledIO_mid(0) <> io.m_side
    DecoupledIO_mid(GroupNum) <> io.s_side
}
object ElbPipe extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new ElbPipe(8,4),
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