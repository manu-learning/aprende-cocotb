## defaults
import os
import random
import sys
from pathlib import Path

## defaults
import cocotb
from cocotb.triggers import Timer

## requeridos para éste test
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def basic_count(dut):
    # generar el clock
    cocotb.start_soon(Clock(dut.i_clk,1,units="ns").start())

    # - habilitamos la señal de reset (con un "uno lógico" ó "pulso alto" HIGH)
    # - modificamos el valor de una señal/entrada de la sig. forma "dut.nombre_señal.value = valor"
    dut.i_reset.value = 1

    # iteración de 2 ciclos
    # 1) esperamos 2 "flancos de subida" (RisingEdge en cocotb, posedge en verilog, transición de 0 a 1) de la señal reloj
    # 2) deshabilitamos la "señal de reset" (con un "cero lógico" ó "pulso bajo" LOW)
    for _ in range(2):
        await RisingEdge(dut.i_clk)
    dut.i_reset.value = 0

    # iteración de 50 ciclos, por tanto durará 50ns (porque definimos al principio que será 1ns)
    for cnt in range(50):
        # esperamos hasta que haya un "flanco de subida" (RisingEdge en cocotb, posedge en verilog, transición de 0 a 1) de reloj
        await RisingEdge(dut.i_clk)

        # asignamos el valor del estado actual del contador
        dut_count = dut.o_count.value

        # - como definimos en el counter.v un contador de 4 bits (en el input y ouput)
        # entonces tiene 2^4 Bytes = 2^2 * 2^2 = 16 => hay 16 posibles únicas combinaciones => rango de valores entre 0 a 15 (el cero incluído)
        # - elegimos un valor al azar entre 0 a 15, usando el operador de módulo
        random_value = cnt % 16

        print("########################")
        print("%s (o_count) != %s (random_value)", dut_count.integer, random_value)
        print("########################")

        # verificamos si le coincidimos/acertamos con el valor del contador
        assert dut_count.integer == random_value, \
            "no coinciden los valores %s (o_count) != %s (random_value)" % (str(dut.o_count.value), random_value)
