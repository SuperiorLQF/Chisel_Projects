import chisel3._
import chisel3.util._
// class Channel extends Bundle{
//     val data  = Input(Bits(8.W))
//     val ready = Output(Bool())
//     val valid = Input(Bool())
// }
class Rx(frequency: Int, baudRate: Int) extends Module{
    val io=IO(new Bundle {
        val rxd = Input(Bits(1.W))
        val channel = Flipped(new Channel())
    })

    val CLK_CNT = ((frequency + baudRate/2) / baudRate -1).asUInt //四舍五入,一个bit分配多少clk
    val START_CLK_CNT = ((frequency + baudRate/2) / 2 / baudRate -1).asUInt
    // printf("%d-%d\n",START_CLK_CNT,CLK_CNT)
    val BIT_CNT = (11-1).U
    
    val clkCntReg = RegInit(0.U(20.W))//计数一个bit的clk数量
    val bitCntReg = RegInit(0.U(4.W))//计数到第几个bit
    val shiftReg  = RegInit("b11_1111_1111".U(10.W))
    val rxdReg  =   RegNext(RegNext(io.rxd))//同步器
    //FSM
    val idle::start::busy::Nil = Enum(3)
    val stateReg =RegInit(idle)
    switch(stateReg){
        is(idle){
            when( rxdReg === 0.U){
                stateReg := start
            }.otherwise{
                stateReg := idle
            }
        }
        is(start){
            when(clkCntReg === START_CLK_CNT){
                stateReg := busy
            }.otherwise{
                stateReg := start
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
    when(stateReg === start){
        when(clkCntReg === START_CLK_CNT){
            clkCntReg := 0.U
        }.otherwise{
            clkCntReg := clkCntReg + 1.U
        }
    }.elsewhen(stateReg === busy){
        when(clkCntReg === CLK_CNT){
            clkCntReg := 0.U
        }.otherwise{
            clkCntReg := clkCntReg + 1.U
        }        
    }.otherwise{
        clkCntReg := 0.U
    }

    when(stateReg === start){
        when(clkCntReg === START_CLK_CNT){
            bitCntReg := bitCntReg +1.U
        }.otherwise{
            bitCntReg := bitCntReg
        }
    }.elsewhen(stateReg === busy){
        when(clkCntReg === CLK_CNT){
            bitCntReg := bitCntReg +1.U
        }.otherwise{
            bitCntReg := bitCntReg
        }
    }.otherwise{
        bitCntReg := 0.U
    }
    //shift logic
    when((stateReg === busy)&&(clkCntReg === CLK_CNT)){
        shiftReg := Cat(shiftReg(8,0),rxdReg)
    }.otherwise{
        shiftReg := shiftReg
    }

    
    when((clkCntReg === CLK_CNT)&&(bitCntReg === BIT_CNT)){
        io.channel.valid := true.B
        io.channel.data  := shiftReg(9,2)
    }.otherwise{
        io.channel.valid := false.B
        io.channel.data  := 0.U
    }
}
// object Rx extends App {
//   (new chisel3.stage.ChiselStage).emitVerilog(new Rx(1000000,9600),
//   Array("--target-dir","generated"))
// }