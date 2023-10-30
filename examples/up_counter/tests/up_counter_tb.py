import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def contar_hasta_5_con_reset_habilitado(dut):
    # generar l clock
    task = cocotb.start_soon(Clock(dut.i_clk,1,units="ns").start())
    task.log.info("Iniciando Clock!")

    # - habilitamos la señal de reset (con un "uno lógico" ó "pulso alto" HIGH)
    # - modificamos el valor de una señal/entrada de la sig. forma "dut.nombre_señal.value = valor"
    dut.i_reset._log.info("Modificando señal reset a 1")
    dut.i_reset.value = 1

    # el contador (r_counter) de 4 bits tiene asignado su valor máximo 1111 (en binario) ó 16 (en decimal)
    #  -> 16 (en decimal) porque 1111 (en binario) = 2^4= 2^2 * 2^2 = 4*4 = 16 (en decimal)
    # luego de un "flanco de subida" de reloj, el contador tendrá su valor inicial osea 0000 (en binario) ó 0 (en decimal)
    await RisingEdge(dut.i_clk)

    # iteración de 2 ciclos
    # 1) esperamos 2 "flancos de subida" (RisingEdge en cocotb, posedge en verilog, transición de 0 a 1) de la señal reloj
    # 2) deshabilitamos la "señal de reset" (con un "cero lógico" ó "pulso bajo" LOW)
    print("########################")
    for _ in range(5):
        await RisingEdge(dut.i_clk)
        print(dut.o_count.value.integer, "==", 0)
        assert dut.o_count.value.integer == 0
    print("########################")


@cocotb.test()
async def contador_hasta_5_con_reset_deshabilitado(dut):
    # generar el clock
    task = cocotb.start_soon(Clock(dut.i_clk,1,units="ns").start())
    task.log.info("Iniciando Clock!")

    # el contador (r_counter) de 4 bits tiene asignado su valor máximo 1111 (en binario) ó 16 (en decimal)
    #  -> 16 (en decimal) porque 1111 (en binario) = 2^4= 2^2 * 2^2 = 4*4 = 16 (en decimal)
    # luego de un "flanco de subida" de reloj, el contador tendrá su valor inicial osea 0000 (en binario) ó 0 (en decimal)
    await RisingEdge(dut.i_clk)

    # deshabilitamos la "señal de reset" (con un "cero lógico" ó "pulso bajo" LOW)
    dut.i_reset._log.info("Modificando señal reset a 0")
    dut.i_reset.value = 0

    print("########################")
    # iteración de 5 ciclos, por tanto durará 5ns (porque definimos al principio que será 1ns)
    for i in range(5):
        # esperamos hasta que haya un "flanco de subida" (RisingEdge en cocotb, posedge en verilog, transición de 0 a 1) de reloj
        await RisingEdge(dut.i_clk)

        print(dut.o_count.value.integer, "==", i)

        # verificamos si le coincidimos/acertamos con el valor del contador
        assert dut.o_count.value.integer == i
        # assert dut.o_count.value.integer == i, \
        #      "no coinciden los valores %s (o_count) != %s (i)" % (dut.o_count.value, i)

    print("########################")
