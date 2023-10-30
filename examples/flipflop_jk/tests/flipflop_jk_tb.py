import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge

# tests
@cocotb.test()
async def salida_mantiene_su_estado_con_pulso_bajo_de_reloj(dut):
    i_clk=0
    i_j=0
    i_k=0

    await Timer(10, units='ns')
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

    await Timer(10, units='ns')
    i_j=1
    i_k=0
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

    await Timer(10, units='ns')
    i_j=0
    i_k=1
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

    await Timer(10, units='ns')
    i_j=1
    i_k=1
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

@cocotb.test()
async def salida_modifica_su_estado_con_pulso_alto_de_reloj(dut):
    i_clk=0
    i_j=1
    i_k=0

    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())
    #await Timer(10, units='ns')
    await FallingEdge(dut.i_clk)
    #await RisingEdge(dut.i_clk)

    assert dut.o_q.value.integer == 1
    assert dut.o_qn.value.integer == 0



