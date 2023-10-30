import cocotb

from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.binary import BinaryValue, BinaryRepresentation

# tests
@cocotb.test()
async def si_selector_00_salida_sera_1er_bit(dut):
    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())

    await Timer(10, units='ns')
    # 101 (binario) = 1*2^2 + 0*2^1 + 1*2^0 = 5 (decimal)
    dut.i_data.value = BinaryValue(value="1001", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)

    # - 01 (binario) = 0*2^1 1*2^0 = 1 (decimal)
    # - debería devolver i_data[0]
    dut.i_selector.value = BinaryValue(value="00", bigEndian=False, binaryRepresentation=BinaryRepresentation.SIGNED_MAGNITUDE)

    # await Timer(10, units='ns')
    await RisingEdge(dut.i_clk)

    # TODO: la salida o_q tiene valor z
    print(" ---------->", dut.i_data.value, dut.i_selector.value, dut.i_clk.value, dut.o_q.value)

    assert dut.o_q.value.integer == 1
