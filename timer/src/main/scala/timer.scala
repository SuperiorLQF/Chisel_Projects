import chisel3._
class timer extends Module {
    val io = IO(new Bundle {
        val din     =   Input(UInt(8.W))
        val load    =   Input(UInt(1.W))
        val done    =   Output(UInt(1.W))
    })

    val cntReg  =   RegInit(0.U(8.W))
    io.done    :=   cntReg === 0.U
    when(io.load===1.U){
        cntReg  :=  io.din
    }.elsewhen(io.done===0.U){
        cntReg  :=  cntReg - 1.U
    }.otherwise{
        cntReg  :=  0.U
    }


}
object timer extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new timer(),
  Array("--target-dir","generated"))
}