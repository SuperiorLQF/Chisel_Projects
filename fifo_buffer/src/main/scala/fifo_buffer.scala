import chisel3._
import chisel3.util._
//在外部通过封装ready-valid保证不空读和满写
class WriterIO(size: Int) extends Bundle{
    val write   =   Input(Bool())
    val full    =   Output(Bool())
    val din     =   Input(UInt(size.W))    
}
class ReaderIO(size: Int) extends Bundle{
    val read    =   Input(Bool())
    val empty   =   Output(Bool())
    val dout    =   Output(UInt(size.W))
}
class FifoBuffer(size: Int) extends Module{
    val io = IO(new Bundle{
        val WriterInterface = new WriterIO(size)
        val ReaderInterface = new ReaderIO(size)
    })

    val empty::full::Nil = Enum(2)
    val stateReg = RegInit(empty)
    switch(stateReg){
        is(empty) {
            when((io.WriterInterface.write) && (!io.ReaderInterface.read)){
                stateReg:=full
            }
        }
        is(full)  {
            when((!io.WriterInterface.write) && (io.ReaderInterface.read)){
                stateReg:=empty
            }
        }
    }
    io.WriterInterface.full := stateReg === full
    io.ReaderInterface.empty:= stateReg === empty

    val fifoReg = RegInit(0.U(size.W))

    when(io.WriterInterface.write){
        fifoReg := io.WriterInterface.din
    }

    io.ReaderInterface.dout:= 0.U
    when(io.ReaderInterface.read){
        io.ReaderInterface.dout:=RegNext(fifoReg)
    }
}

class FifoBufferRdyVld(size: Int) extends Module{
    val io=IO(new Bundle{
        val WriterInterface= Flipped(DecoupledIO(UInt(size.W)))
        val ReaderInterface= DecoupledIO(UInt(size.W))
    })

    val fifoBuffer= Module(new FifoBuffer(size))
    fifoBuffer.io.WriterInterface.din := io.WriterInterface.bits
    io.ReaderInterface.bits := fifoBuffer.io.ReaderInterface.dout

    io.WriterInterface.ready := !fifoBuffer.io.WriterInterface.full
    io.ReaderInterface.valid := !fifoBuffer.io.ReaderInterface.empty

    fifoBuffer.io.WriterInterface.write :=  io.WriterInterface.valid & io.WriterInterface.ready
    fifoBuffer.io.ReaderInterface.read  :=  io.ReaderInterface.valid & io.ReaderInterface.ready
}
object FifoBufferRdyVld extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new FifoBufferRdyVld(16),
  Array("--target-dir","generated"))
}