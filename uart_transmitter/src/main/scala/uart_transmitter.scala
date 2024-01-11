import chisel3._
import chisel3.util._
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

    val CLK_CNT = ((frequency + baudRate/2) / baudRate -1).asUInt //四舍五入,一个bit分配多少clk
    val BIT_CNT = (11-1).U
    val clkCntReg = RegInit(0.U(20.W))//计数一个bit的clk数量
    val bitCntReg = RegInit(0.U(4.W))//计数到第几个bit
    val shiftReg  = RegInit("b11_1111_1111_1".U(11.W))

    io.channel.ready :=(clkCntReg === 0.U) && (bitCntReg === 0.U)
    val insert = Wire(Bool())
    insert := io.channel.ready && io.channel.valid

    //FSM
    val idle::busy::Nil = Enum(2)
    val stateReg =RegInit(idle)
    switch(stateReg){
        is(idle){
            when(insert){
                stateReg := busy
            }.otherwise{
                stateReg := idle
            }
        }
        is(busy){
            when((clkCntReg === CLK_CNT)&&(bitCntReg === BIT_CNT)){
                stateReg := idle
            }.otherwise{
                stateReg := busy
            }
            
        }
    }
    //cnt logic
    clkCntReg := Mux((stateReg === busy),Mux((clkCntReg === CLK_CNT),0.U,clkCntReg + 1.U),0.U)
    when(stateReg === busy){
        when(clkCntReg === CLK_CNT){
            bitCntReg := bitCntReg +1.U
        }.otherwise{
            bitCntReg := bitCntReg
        }
    }.otherwise{
        bitCntReg := 0.U
    }
    //shift logic
    when(insert){
        shiftReg := Cat("b11".U(2.W),io.channel.data.asUInt(),0.U(1.W))        
    }.elsewhen((stateReg === busy)&&(clkCntReg === CLK_CNT)){
        shiftReg := Cat(1.U(1.W),shiftReg(10,1))
    }.otherwise{
        shiftReg := shiftReg
    }

    io.txd := shiftReg(0)
}
object Tx extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Tx(1000000,9600),
  Array("--target-dir","generated"))
}