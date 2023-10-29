import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

# tests
@cocotb.test()
async def dos_es_mayor_que_uno(dut):
    dut.i_a.value = 2
    dut.i_b.value = 1

    await Timer(10, units='ns')
    assert dut.o_f.value.binstr == "100"
    assert dut.o_f.value.integer == 4 # 100 (binario) = 1*2^2 * 0*2^1 * 0*2^0 = 2^2 = 4 (decimal)

@cocotb.test()
async def dos_es_igual_que_dos(dut):
    dut.i_a.value = 2
    dut.i_b.value = 2

    await Timer(10, units='ns')
    assert dut.o_f.value.binstr == "010"
    assert dut.o_f.value.integer == 2 # 10 (binario) =  1*2^1 * 0*2^0 = 2^1 = 2 (decimal)

@cocotb.test()
async def uno_es_menor_que_dos(dut):
    dut.i_a.value = 1
    dut.i_b.value = 2

    await Timer(10, units='ns')
    assert dut.o_f.value.binstr == "001"
    assert dut.o_f.value.integer == 1 # 1 (binario) =  1*2^0 = 2^0 = 1 (decimal)
