import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge

# tests
@cocotb.test()
async def salida_mantiene_su_estado_con_pulso_bajo_de_reloj(dut):
    dut.i_clk.value=0
    dut.i_j.value=0
    dut.i_k.value=0

    print("########################")
    await Timer(10, units='ns')
    print("o_q = ", dut.o_q.value.integer)
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

    await Timer(10, units='ns')
    dut.i_j.value=1
    dut.i_k.value=0
    print("o_q = ", dut.o_q.value.integer)
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

    await Timer(10, units='ns')
    dut.i_j.value=0
    dut.i_k.value=1
    print("o_q = ", dut.o_q.value.integer)
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1

    await Timer(10, units='ns')
    dut.i_j.value=1
    dut.i_k.value=1
    print("o_q = ", dut.o_q.value.integer)
    assert dut.o_q.value.integer == 0
    assert dut.o_qn.value.integer == 1
    print("########################")

# TODO: no está modificando la salida
@cocotb.test()
async def salida_modificada_con_flancos_de_subida_de_reloj(dut):
    task = cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())
    task.log.info("Iniciando Clock!")

    dut.i_j.value=1
    dut.i_k.value=0

    print("########################")
    print("o_q = ", dut.o_q.value.integer)

    await RisingEdge(dut.i_clk)
    # await FallingEdge(dut.i_clk)

    print("o_q = ", dut.o_q.value.integer)
    print("########################")

    assert dut.o_q.value.integer == 1
    assert dut.o_qn.value.integer == 0



