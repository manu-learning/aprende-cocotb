import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge

# tests
@cocotb.test()
async def cero_AND_cero_es_cero(dut):
    # o_q=((i_a=0 OR i_b=0) AND i_b=0)=0
    dut.i_a.value = 0
    dut.i_b.value = 0

    await Timer(10, units='ns')
    assert dut.o_q.value.integer == 0

@cocotb.test()
async def uno_AND_cero_es_cero(dut):
    # o_q=((i_a=1 OR i_b=0) AND i_b=0)=0
    dut.i_a.value = 1
    dut.i_b.value = 0

    await Timer(10, units='ns')
    assert dut.o_q.value.integer == 0

    # o_q=((i_a=0 OR i_b=1) AND i_b=1)=1
    dut.i_a.value = 0
    dut.i_b.value = 1

    await Timer(10, units='ns')
    assert dut.o_q.value.integer == 1

    # o_q=((i_a=1 OR i_b=1) AND i_b=1)=1
    dut.i_a.value = 1
    dut.i_b.value = 1

    await Timer(10, units='ns')
    assert dut.o_q.value.integer == 1
