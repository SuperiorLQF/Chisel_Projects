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
    val io  =   IO(new Bundle{
        val m_side  =   Flipped(DecoupledIO(UInt(Width.W)))
        val s_side  =   DecoupledIO(UInt(Width.W))
    })
}
class SkidBuffer(Width : Int) extends VldRdy(Width : Int){
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
            //assert(insert === true.B ,"insert happend with full state!")
        }

    }
    val En0     =   Wire(Bool())
    val sel     =   Wire(Bool())
    val En1     =   Wire(Bool())
    val Reg0    =   RegEnable(io.m_side.bits,En0)
    val sel_o   =   Mux(sel,Reg0,io.m_side.bits)
    val Reg1    =   RegEnable(sel_o,         En1)
    io.s_side.bits := Reg1

    En0 := Mux(((state === busy)&&(insert)&&(!remove)),true.B,false.B)
    sel := Mux((state === full),true.B,false.B)
    En1 := Mux( (state === empty) || 
                ((state === busy) && (!remove)) ||
                ((state === full) && (!remove)),true.B,false.B)

    io.s_side.valid := (state =/= empty)
    io.m_side.ready := (state =/= full )

}
// object SkidBuffer extends App {
//   (new chisel3.stage.ChiselStage).emitVerilog(new SkidBuffer(8),
//   Array("--target-dir","generated"))
// }
