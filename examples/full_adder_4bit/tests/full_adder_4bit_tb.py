import cocotb
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue, BinaryRepresentation

@cocotb.test()
async def en_binario_0000_mas_0000_es_0000(dut):
    dut.i_operando_a.value = 0
    dut.i_operando_b.value = 0
    dut.i_acarreo.value = 0

    await Timer(10, units='ns')
    assert dut.o_suma.value.binstr == "0000"
    assert dut.o_suma.value.integer == 0 # 0 (decimal) = 0000 (binario)

@cocotb.test()
async def en_binario_0001_mas_0001_es_0010(dut):
    dut.i_operando_a.value = BinaryValue(value="0001", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    dut.i_operando_b.value = BinaryValue(value="0001", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    dut.i_acarreo.value = 0

    await Timer(10, units='ns')
    assert dut.o_suma.value.binstr == "0010"
    assert dut.o_suma.value.integer == 2 # 10 (binario) = 2^1 Bytes = 2 (decimal)

@cocotb.test()
async def en_binario_0010_mas_0010_es_0100(dut):
    dut.i_operando_a.value = BinaryValue(value="0010", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    dut.i_operando_b.value = BinaryValue(value="0010", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    dut.i_acarreo.value = 0

    await Timer(10, units='ns')
    assert dut.o_suma.value.binstr == "0100"
    assert dut.o_suma.value.integer == 4 # 100 (binario) = 2^2 Bytes = 4 (decimal)

@cocotb.test()
async def en_binario_0100_mas_0100_es_1000(dut):
    dut.i_operando_a.value = BinaryValue(value="0100", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    dut.i_operando_b.value = BinaryValue(value="0100", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    dut.i_acarreo.value = 0

    await Timer(10, units='ns')
    assert dut.o_suma.value.binstr == "1000"
    assert dut.o_suma.value.integer == 8 # 1000 (binario) = 2^3 Bytes = 8 (decimal)
