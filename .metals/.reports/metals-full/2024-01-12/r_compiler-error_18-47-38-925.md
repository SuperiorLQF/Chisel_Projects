file://<WORKSPACE>/fifo/src/main/scala/fifo.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 2038
uri: file://<WORKSPACE>/fifo/src/main/scala/fifo.scala
text:
```scala
import chisel3._
import chisel3.util._
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
//抽象类Fifo，参数是位宽depth和数据类型gen
abstract class Fifo[T <: Data](gen: T, val depth: Int) extends Module {
    val io = IO(new FifoIO(gen,depth))
    assert(depth >0,"Number of buffer elements needs to be larger than 0.")
}
//*************************************************
class syncFifo[T <: Data](gen:T,depth: Int) extends Fifo(gen: T, depth:Int){
    val ptrWidth    =   log2Ceil(depth) + 1
    val depthMax    =   depth -1
    //循环指针计数器
    def PtrCounter(en: Bool):UInt={
        val cntReg = RegInit(0.U(ptrWidth.W))
        when(en){
            when(cntReg(ptrWidth-2,0) === depthMax.U){
                cntReg := Cat(cntReg(ptrWidth-1)+1.U,0.U((ptrWidth-1).W))
            }.otherwise{
                cntReg := cntReg +1.U
            }
        }

        cntReg
    }
    io.full     :=   io.cnt === depthMax.U
    io.empty    :=   io.cnt === 0.U
    val memReg  =   Reg(Vec(depth,gen))

    // io.cnt      :=   Mux((wrptr(ptrWidth-1) === rdptr(ptrWidth-1)),
    //                     wrptr(ptrWidth-2,0)-rdptr(ptrWidth-2,0),
    //                     wrptr(ptrWidth-2,0)-rdptr(ptrWidth-2,0)+depthMax.U)
    io.cnt      :=   Mux((wrptr(ptrWidth-1) === rdptr(ptrWidth-1)),
                        wrptr(ptrWidth-2,0)-rdptr(ptrWidth-2,0),
                        wrptr(ptrWidth-2,0)-rdptr(ptrWidth-2,0)+depthMax.U)
    // io.cnt := 2.U
    // val wrptr = PtrCounter(wen) 
    // val rdptr = PtrCounter(ren) 
    val wrptr = 5.U()@@ 
    val rdptr = 1.U 
    when(wrptr(ptrWidth-1) === rdptr(ptrWidth-1)){
        io.cnt :=0.U
    }.otherwise{
        io.cnt :=1.U
    }
    io.WriteInterface.ready := !io.full
    io.ReadInterface.valid  := !io.empty
    val wen     =   Wire(Bool())
    val ren     =   Wire(Bool())
    wen         :=  io.WriteInterface.valid && io.WriteInterface.ready
    ren         :=  io.ReadInterface.valid  && io.ReadInterface.ready  
    when(wen){
        memReg(wrptr) := io.WriteInterface.bits
    }
    io.ReadInterface.bits:=0.U
    when(ren){
        io.ReadInterface.bits := memReg(rdptr)
    }
    

}
object syncFifo extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new syncFifo(UInt(8.W),8),
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