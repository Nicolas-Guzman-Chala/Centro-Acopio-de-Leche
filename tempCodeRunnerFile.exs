
Code.require_file("datos.exs")
Code.require_file("calculos.exs")
Code.require_file("validaciones.exs")

defmodule Centro_acopio do

  def main do
    tanques = Datos.tanques()
    entregas = Datos.entregas()
    productores = Datos.productores()

    entregas_validas =
      validar_entregas(tanques, entregas, productores, :ok)


      IO.inspect(entregas_validas, label: "ENTREGAS VALIDAS")


      liquidaciones =
      productores
      |> Enum.map(fn productor ->
        Calculos.calcular(
          productor.codigo,
          productores,
          entregas_validas
        )
      end)

    IO.inspect(liquidaciones)
  end

 def validar_entregas(tanques, entregas, productores, :error) do
  entregas
  |> Enum.map(fn entrega ->
    Validaciones.validar_entrega(
      productores,
      tanques,
      entrega
    )
  end)
  |> Enum.filter(fn resultado ->
    match?({:error, _}, resultado)
  end)
  |> Enum.map(fn {:error, motivo} ->
    motivo
  end)
end

  def validar_entregas(tanques, entregas, productores, :ok) do
    entregas
    |> Enum.map(fn entrega ->
      Validaciones.validar_entrega(
        productores,
        tanques,
        entrega
      )
    end)
    |> Enum.filter(fn resultado ->
      match?({:ok, _}, resultado)
    end)
    |> Enum.map(fn {:ok, entrega} ->
      entrega
    end)
  end

end
Centro_acopio.main()
