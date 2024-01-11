import chisel3._
import chisel3.util._
class Channel extends Bundle{
    val data  = Input(Bits(8.W))
    val ready = Output(Bool())
    val valid = Input(Bool())
}
class TxRx(frequency: Int, baudRate: Int) extends Module{
    val io = IO(new Bundle{
        val txchannel = new Channel()
        val rxchannel = Flipped(new Channel())
    })

    val txPart = Module(new Tx(frequency,baudRate))
    val rxPart = Module(new Rx(frequency,baudRate))
    rxPart.io.rxd := txPart.io.txd
    txPart.io.channel <> io.txchannel
    io.rxchannel <> rxPart.io.channel
}
object TxRx extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new TxRx(1000000,9600),
  Array("--target-dir","generated"))
}