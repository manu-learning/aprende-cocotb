import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge

# tests
@cocotb.test()
async def tres_flancos_de_subida_reloj_cuenta_3(dut):
    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())

    # esperamos cinco flancos de subida ó transiciones de pulsos de reloj 0 --> 1
    for i in range(3):
        #await RisingEdge(dut.i_clk)
        dut.i_clk.value = 0
        print("---> ", i, dut.i_clk.value, dut.o_cuenta.value)
        dut.i_clk.value = 1

    # TODO: observamos valores tipo Z
    # dut.i_clk.value = 0
    # print("---> ", dut.i_clk.value, dut.o_cuenta.value)
    # dut.i_clk.value = 1
    # print("---> ", dut.i_clk.value, dut.o_cuenta.value)

    v_count = dut.o_cuenta.value

    # TODO: debería decir 3, pero guardó 0
    print(v_count)
    assert v_count.integer == 3

