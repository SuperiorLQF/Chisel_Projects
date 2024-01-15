file://<WORKSPACE>/fifo/src/main/scala/fifo.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 1995
uri: file://<WORKSPACE>/fifo/src/main/scala/fifo.scala
text:
```scala
import chisel3._
import chisel3.util._
//抽象类Fifo，参数是位宽depth和数据类型gen
abstract class Fifo[T <: Data](gen: T, val depth: Int) extends Module {
    val io = IO(new FifoIO(gen,depth))
    assert(depth >0,"Number of buffer elements needs to be larger than 0.")
}
//抽象类Fifo的接口：FifoIO
class FifoIO[T <: Data](private val gen:T,val depth:Int) extends Bundle{
    val WriteInterface = Flipped(new DecoupledIO(gen))
    val ReadInterface  = new DecoupledIO(gen)
    val full           = Output(Bool())
    val empty          = Output(Bool())
    val cnt            = Output(UInt(log2Ceil(depth).W))
}
//DecoupledIO参考如下
//*************************************************
// class DecoupledIO[T <: Data](gen: T) extends Bundle {
//     val ready = Input(Bool())
//     val valid = Output(Bool())
//     val bits = Output(gen)
// }
//*************************************************
class syncFifo[T <: Data](gen:T,depth: Int) extends Fifo(gen: T, depth:Int){
    val ptrWidth    =   log2Ceil(depth) + 1
    val depthMax    =   depth -1
    //循环指针计数器
    def PtrCounter:UInt={
        val cntReg = RegInit(0.U(ptrWidth.W))
        when(cntReg(ptrWidth-2:0) === depthMax){
            cntReg := Cat(cntReg(ptrWidth-1)+1.U,0.U((ptrWidth-1).W))
        }
        cntReg
    }

    val memReg  =   Reg(Vec(depth,gen))
    val wrptr   =   Wire(0.U(ptrWidth.W))
    val rdptr   =   Wire(0.U(ptrWidth.W))
    io.full     =   io.cnt === depthMax.U
    io.empty    =   io.cnt === 0.U
    io.cnt      =   Mux((wrptr(ptrWidth-1) === rdptr(ptrWidth-1)),
                        wrptr(ptrWidth-2:0)-rdptr(ptrWidth-2:0),
                        wrptr(ptrWidth-2:0)-rdptr(ptrWidth-2:0)+depthMax.U)
    io.WriteInterface.ready := !io.full
    io.ReadInterface.valid  := !io.empty
    val wen     =   Wrie(Bool())
    val ren     =   Wrie(Bool())
    wen         :=  io.WriteInterface.valid && io.WriteInterface.ready
    ren         :=  io.ReadInterface.valid  && io.ReadInterface.ready
    
    when(wen){
        memReg()@@
        wrptr := PtrCounter()

    }
    when(ren){
        rdptr := PtrCounter()

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