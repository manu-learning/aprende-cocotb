import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def en_binario_0_mas_0_es_0(dut):
    dut.i_operando_a.value = 0
    dut.i_operando_b.value = 0

    await Timer(10, units='ns')

    assert dut.o_suma.value.integer == 0
    assert dut.o_suma.value.binstr == "0"

    assert dut.o_acarreo.value.integer == 0
    assert dut.o_acarreo.value.binstr == "0"

@cocotb.test()
async def en_binario_0_mas_1_es_1(dut):
    dut.i_operando_a.value = 0
    dut.i_operando_b.value = 1

    await Timer(10, units='ns')

    assert dut.o_suma.value.integer == 1
    assert dut.o_suma.value.binstr == "1"

    assert dut.o_acarreo.value.integer == 0
    assert dut.o_acarreo.value.binstr == "0"

@cocotb.test()
async def en_binario_1_mas_0_es_1(dut):
    dut.i_operando_a.value = 1
    dut.i_operando_b.value = 0

    await Timer(10, units='ns')

    assert dut.o_suma.value.integer == 1
    assert dut.o_suma.value.binstr == "1"

    assert dut.o_acarreo.value.integer == 0
    assert dut.o_acarreo.value.binstr == "0"

@cocotb.test()
async def en_binario_1_mas_1_es_10(dut):
    dut.i_operando_a.value = 0
    dut.i_operando_b.value = 1

    await Timer(10, units='ns')

    assert dut.o_suma.value.integer == 1
    assert dut.o_suma.value.binstr == "1"

    assert dut.o_acarreo.value.integer == 0
    assert dut.o_acarreo.value.binstr == "0"
