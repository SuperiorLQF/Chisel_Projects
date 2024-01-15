import chisel3._
import chisel3.util._
import scala.collection.mutable.ListBuffer
class ElbPipe(Width:Int,GroupNum : Int) extends VldRdy(Width:Int){
    val DecoupledIO_mid = Wire(Vec(GroupNum+1,DecoupledIO(UInt(Width.W))))
    for(i<-0 until GroupNum){
        var SkidBufferTempt=Module(new SkidBuffer(Width))
        SkidBufferTempt.io.m_side <> DecoupledIO_mid(i)
        SkidBufferTempt.io.s_side <> DecoupledIO_mid(i+1)
    }
    DecoupledIO_mid(0) <> io.m_side
    DecoupledIO_mid(GroupNum) <> io.s_side
}
object ElbPipe extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new ElbPipe(8,4),
  Array("--target-dir","generated"))
}