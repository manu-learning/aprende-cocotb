import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge

# tests
@cocotb.test()
async def tres_flancos_de_subida_reloj_cuenta_3(dut):
    task = cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())
    task.log.info("Iniciando Clock!")

    # esperamos cinco flancos de subida ó transiciones de pulsos de reloj 0 --> 1
    print("########################")
    for i in range(5):
        await RisingEdge(dut.i_clk)
        print("  ", i, dut.i_clk.value.integer, dut.o_cuenta.value.integer)
    print("########################")

