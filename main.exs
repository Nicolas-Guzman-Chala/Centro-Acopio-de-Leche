
Code.require_file("datos.exs")
Code.require_file("calculos.exs")
Code.require_file("validaciones.exs")

defmodule Centro_acopio do

  def main do
   #cargar datos
    tanques = Datos.tanques()
    entregas = Datos.entregas()
    productores = Datos.productores()

    #verificar las entregas validas

    entregas_validas =
      validar_entregas(tanques, entregas, productores, :ok)

      #mostrar las entregas validas
      IO.inspect(entregas_validas, label: "ENTREGAS VALIDAS")
    #separar las entregas en error
    entregas_error =
      validar_entregas(tanques, entregas, productores, :error)
    #mostrar las entregas en error
      IO.inspect(entregas_error, label: "ENTREGAS erroneas")

     #liquidar a cada productor
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

  #Registrar nueva entrega

  nueva_entrega = registrar_nueva_entrega()

  entregas = entregas ++ [nueva_entrega]

  entregas_validas =
      validar_entregas(tanques, entregas, productores, :ok)

      #mostrar las entregas validas
      IO.inspect(entregas_validas, label: "ENTREGAS VALIDAS")
    #separar las entregas en error
    entregas_error =
      validar_entregas(tanques, entregas, productores, :error)
    #mostrar las entregas en error
      IO.inspect(entregas_error, label: "ENTREGAS erroneas")

     #liquidar a cada productor
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


#////////////////funciones////////////////////////////////////////////////////////////////////////

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

def registrar_nueva_entrega() do
  with productor <- ingresar("ingrese el codigo del productor"),
       tanque <- ingresar("ingrese el id del tanque"),
       dia <- ingresar("ingrese el día de la entrega"),
       litros <- ingresar("ingresar los litros que metio al tanque"),
       grasa <- ingresar("ingrese el porcentaje de grasa, ejm(0 a 15)") do
          %{
            productor: productor,
            tanque: tanque,
            dia: dia,
            litros: litros,
            grasa: grasa
          }
       end
end

defp ingresar(mensaje) do
  mensaje
    |> IO.gets()
    |> String.trim
end

end
Centro_acopio.main()
