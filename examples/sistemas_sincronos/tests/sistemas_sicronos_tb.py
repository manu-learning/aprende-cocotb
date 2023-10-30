import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.binary import BinaryValue, BinaryRepresentation

# tests
# TODO: la salida o_q tienen valor z
@cocotb.test()
async def salida_con_bits_menos_significativos(dut):
    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())

    await Timer(10, units='ns')
    # 1001 (binario) = 1*2^3 + 0*2^2 0*2^1 + 1*2^0 = 8+1 = 9 (decimal)
    dut.i_data.value = BinaryValue(value="1001", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)

    # - 00 (binario) = 0*2^1 + 0*2^0 = 0+0 = 0 (decimal) -> i_data[0] -> (selecciona el 1º bit)
    dut.i_selector.value = BinaryValue(value="00", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    await RisingEdge(dut.i_clk)
    print(" ---------->", dut.i_data.value, dut.i_selector.value, dut.i_clk.value, dut.o_q.value)
    assert dut.o_q.value.integer == 1

    # - 01 (binario) = 0*2^1 + 1*2^0 = 0+1 = 1 (decimal) -> i_data[1] -> (selecciona el 2º bit)
    dut.i_selector.value = BinaryValue(value="01", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    await RisingEdge(dut.i_clk)
    print(" ---------->", dut.i_data.value, dut.i_selector.value, dut.i_clk.value, dut.o_q.value)
    assert dut.o_q.value.integer == 0

# TODO: la salida o_q tienen valor z
@cocotb.test()
async def salida_con_bits_mas_significativos(dut):
    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())

    await Timer(10, units='ns')
    dut.i_data.value = BinaryValue(value="1001", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)

    # - 10 (binario) = 1*2^1 + 0*2^0 = 2+0 = 2 (decimal) -> i_data[2] -> (selecciona el 3º bit)
    dut.i_selector.value = BinaryValue(value="10", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    await RisingEdge(dut.i_clk)
    print(" ---------->", dut.i_data.value, dut.i_selector.value, dut.i_clk.value, dut.o_q.value)
    assert dut.o_q.value.integer == 0

    # - 11 (binario) = 1*2^1 + 1*2^0 = 2+0 = 3 (decimal) -> i_data[3] -> (selecciona el 4º bit)
    dut.i_selector.value = BinaryValue(value="11", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)
    await RisingEdge(dut.i_clk)
    print(" ---------->", dut.i_data.value, dut.i_selector.value, dut.i_clk.value, dut.o_q.value)
    assert dut.o_q.value.integer == 1
