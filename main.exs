Code.require_file("datos.exs")
Code.require_file("calculos.exs")
Code.require_file("validaciones.exs")
Code.require_file("reportes.exs")

defmodule Centro_acopio do

  def main do
    # ==========================================================
    # 1. CARGAR DATOS
    # ==========================================================

    tanques = Datos.tanques()
    entregas = Datos.entregas()
    productores = Datos.productores()


    # ==========================================================
    # 2. VALIDAR LAS ENTREGAS INICIALES
    # ==========================================================

    entregas_validas =
      validar_entregas(
        tanques,
        entregas,
        productores,
        :ok
      )

    IO.inspect(
      entregas_validas,
      label: "ENTREGAS VALIDAS"
    )

    entregas_error =
      validar_entregas(
        tanques,
        entregas,
        productores,
        :error
      )

    IO.inspect(
      entregas_error,
      label: "ENTREGAS ERRONEAS"
    )


    # ==========================================================
    # 3. REGISTRAR UNA NUEVA ENTREGA
    # ==========================================================

    nueva_entrega = registrar_nueva_entrega()

    entregas_actualizadas = entregas ++ [nueva_entrega]


    # ==========================================================
    # 4. VOLVER A VALIDAR TODAS LAS ENTREGAS
    # ==========================================================

    entregas_validas =
      validar_entregas(
        tanques,
        entregas_actualizadas,
        productores,
        :ok
      )

    IO.inspect(
      entregas_validas,
      label: "ENTREGAS VALIDAS DESPUES DE REGISTRAR"
    )

    entregas_error =
      validar_entregas(
        tanques,
        entregas_actualizadas,
        productores,
        :error
      )

    IO.inspect(
      entregas_error,
      label: "ENTREGAS ERRONEAS DESPUES DE REGISTRAR"
    )


    # ==========================================================
    # 5. LIQUIDAR A CADA PRODUCTOR
    # ==========================================================

    liquidaciones =
      productores
      |> Enum.map(fn productor ->
        Calculos.calcular(
          productor.codigo,
          productores,
          entregas_validas
        )
      end)

    IO.inspect(
      liquidaciones,
      label: "LIQUIDACIONES"
    )


    # ==========================================================
    # 6. GENERAR REPORTES
    # ==========================================================

    Reportes.generar(
      productores,
      tanques,
      entregas_validas,
      entregas_error,
      liquidaciones
    )

    litros_diarios = Reportes.litros_por_dia(entregas_validas)

centro_vecino = %{
  1 => 1850.5,
  2 => 2100,
  3 => 1640,
  5 => 2350,
  7 => 800
}

litros_combinados =
  Map.merge(
    litros_diarios,
    centro_vecino,
    fn _dia, litros_centro, litros_vecino ->
      litros_centro + litros_vecino
    end
  )

IO.inspect(
  litros_combinados,
  label: "LITROS COMBINADOS"
)
  end


  # ============================================================
  # FUNCIONES
  # ============================================================

  # ------------------------------------------------------------
  # Validar y obtener solamente las entregas correctas
  # ------------------------------------------------------------

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


  # ------------------------------------------------------------
  # Validar y obtener solamente las entregas incorrectas
  # ------------------------------------------------------------

  def validar_entregas(tanques, entregas, productores, :error) do
    entregas
    |> Enum.map(fn entrega ->
      resultado =
        Validaciones.validar_entrega(
          productores,
          tanques,
          entrega
        )

      {entrega, resultado}
    end)
    |> Enum.filter(fn {_entrega, resultado} ->
      match?({:error, _}, resultado)
    end)
    |> Enum.map(fn {entrega, {:error, motivo}} ->
      {entrega, motivo}
    end)
  end


  # ------------------------------------------------------------
  # Registrar una nueva entrega
  # ------------------------------------------------------------

  def registrar_nueva_entrega do
    with productor <- ingresar("Ingrese el codigo del productor"),
         tanque <- ingresar("Ingrese el id del tanque"),
         dia <- ingresar("Ingrese el dia de la entrega"),
         litros <- ingresar("Ingrese los litros que metio al tanque"),
         grasa <- ingresar("Ingrese el porcentaje de grasa (0 a 15)") do

      %{
        productor: productor,
        tanque: tanque,
        dia: dia,
        litros: litros,
        grasa: grasa
      }
    end
  end


  # ------------------------------------------------------------
  # Leer un dato por consola
  # ------------------------------------------------------------

  defp ingresar(mensaje) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end
end


Centro_acopio.main()
