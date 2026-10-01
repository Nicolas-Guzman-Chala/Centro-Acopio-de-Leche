
defmodule Reportes do
  @moduledoc "Genera e imprime los reportes R1 a R8"

  @meta_diaria 2000
  @dias 1..6
  @motivos [:productor_desconocido, :tanque_desconocido, :dia_invalido, :litros_fuera_de_rango, :porcentaje_invalido]

  @doc "Imprime R1 a R8 en orden con los parámetros correctos para cada función."
  def generar(productores, tanques, entregas_validas, entregas_rechazadas, liquidaciones) do
    reporte_1(entregas_rechazadas)
    reporte_2(tanques, entregas_validas)
    reporte_3(entregas_validas)
    reporte_4(liquidaciones)
    reporte_5(entregas_validas, productores)
    reporte_6(productores, entregas_validas)
    reporte_7(liquidaciones, entregas_validas)
    reporte_8(tanques, productores, entregas_validas)
  end

  @doc "R1. Entregas rechazadas con su motivo y cantidad de rechazos por cada motivo."
  def reporte_1(entregas_rechazadas) do
    IO.puts(" R1 Entregas rechazadas ")
    for {entrega, motivo} <- entregas_rechazadas do
      IO.puts("Productor: #{entrega.productor}, Tanque: #{entrega.tanque}, Día: #{entrega.dia}, Litros: #{entrega.litros}, Grasa: #{entrega.grasa} -> #{motivo}")
    end

    IO.puts("Cantidad de rechazos por cada motivo")
    for motivo <- @motivos do
      cantidad = Enum.count(entregas_rechazadas, fn { m} -> m == motivo end)
      IO.puts("#{motivo}: #{cantidad}")
    end
  end

  @doc "R2. Litros almacenados por tanque y porcentaje de ocupación, ordenados de mayor a menor."
  def reporte_2(tanques, entregas_validas) do
    IO.puts(" R2. Ocupación de tanques")
    resultados = for tanque <- tanques do
      litros = Enum.sum(for e <- entregas_validas, e.tanque == tanque.id, do: e.litros)
      porcentaje = if tanque.capacidad > 0, do: litros / tanque.capacidad * 100, else: 0.0
      {tanque.nombre, litros, porcentaje}
    end

    for {nombre, litros, porcentaje} <- Enum.sort_by(resultados, fn { p} -> p end, :desc) do
      IO.puts("#{nombre}: #{litros} litros (#{decimal(porcentaje)} % de ocupación)")
    end
  end

  @doc "R3. Litros recibidos por día, meta diaria, cumplimiento total y parcial."
  def reporte_3(entregas_validas) do
    IO.puts("R3. Litros por día (meta: #{@meta_diaria} litros) ")
    dias_resumen = for dia <- @dias do
      litros = Enum.sum(for e <- entregas_validas, e.dia == dia, do: e.litros)
      {dia, litros, litros >= @meta_diaria}
    end

    for {dia, litros, cumple} <- dias_resumen do
      IO.puts("Día #{dia}: #{litros} litros - Meta alcanzada: #{si_o_no(cumple)}")
    end

    IO.puts("Meta cumplida todos los días: #{si_o_no(Enum.all?(dias_resumen, fn { c} -> c end))}")
    IO.puts("Meta cumplida al menos un día: #{si_o_no(Enum.any?(dias_resumen, fn { c} -> c end))}")
  end

  @doc "R4. Liquidación de todos los productores ordenada por pago neto de mayor a menor."
  def reporte_4(liquidaciones) do
    IO.puts(" R4. Liquidación de productores")
    for {liq, index} <- Enum.with_index(Enum.sort_by(liquidaciones, &(&1.neto), :desc), 1) do
      IO.puts("#{index}. #{liq.nombre} (Código: #{liq.codigo}) | Litros: #{liq.litros} | Valor: $#{decimal(liq.valor_entregas)} | Bonos: $#{decimal(liq.bonificaciones)} | Transporte: $#{decimal(liq.transporte)} | Neto: $#{decimal(liq.neto)}")
    end
  end

  @doc "R5. Productor con mayor cantidad de litros entregados cada día."
def reporte_5(entregas_validas, productores) do
  IO.puts("R5. Mayor productor por día")

  ganadores = for dia <- @dias do
    totales = for prod <- productores do
      litros =
        entregas_validas
        |> Enum.filter(fn e -> e.productor == prod.codigo and e.dia == dia end)
        |> Enum.map(fn e -> e.litros end)
        |> Enum.sum()

      {prod.nombre, litros}
    end

    max = Enum.max_by(totales, fn {litros} -> litros end)
    {nombre, litros} = max

    IO.puts("Día #{dia} - Mayor entrega: #{nombre} (#{litros} litros)")
    nombre
  end

  conteo = Enum.frequencies(ganadores)
  {nombre, veces} = Enum.max_by(conteo, fn {_nombre, veces} -> veces end)

  IO.puts("Productor con más primeros puestos: #{nombre} (#{veces} veces)")
end


  defp si_o_no(true), do: "Sí"
  defp si_o_no(false), do: "No"

  defp decimal(valor) when is_float(valor) do
    :erlang.float_to_binary(valor, [:compact, {:decimals, 2}])
  end
  defp decimal(valor), do: valor
end
