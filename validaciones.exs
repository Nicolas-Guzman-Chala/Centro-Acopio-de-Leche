defmodule Validaciones do
  @moduledoc """
  Este modulo se encarga de validar las entregas de leche antes de
  procesarlas.

  Primero convierte los datos de dia, litros y grasa a numeros enteros.
  Despues verifica que el productor y el tanque existan y que los valores
  de la entrega esten dentro de los rangos permitidos.

  Si todas las validaciones son correctas, devuelve la entrega validada.
  Si alguna validacion falla, devuelve el error correspondiente.
  """

  @rango_dias 1..6
  @rango_litros 1..800

  # Valida una entrega completa.

  # Primero convierte los datos de la entrega y despues realiza las
  # validaciones del productor, tanque, dia, litros y porcentaje de grasa.

  # Si todas las validaciones son correctas devuelve `{:ok, entrega}`.
  # Si alguna validacion falla, devuelve el error correspondiente.

  def validar_entrega(productores, tanques, entrega) do
    resultado =
      if is_integer(entrega.dia) &&
         is_integer(entrega.litros) &&
         (is_float(entrega.grasa) || is_integer(entrega.grasa)) do
          {:ok, entrega}
      else
        parsear_entrega(entrega)
      end

    with {:ok, entrega} <- resultado,
         {:ok, entrega} <- validar_productor(entrega, productores),
         {:ok, entrega} <- validar_tanque(entrega, tanques),
         {:ok, entrega} <- validar_dia(entrega),
         {:ok, entrega} <- validar_litros(entrega),
         {:ok, entrega} <- validar_grasa(entrega) do
      {:ok, entrega}
    end
  end

  # Convierte los valores de dia, litros y grasa de una entrega a numeros
  # enteros.

  # Si los valores se pueden convertir correctamente, devuelve la entrega
  # con los datos convertidos.

  # Si alguno de los valores no se puede convertir, devuelve
  # `{:error, :parse_error}`.

  defp parsear_entrega(entrega) do
    with {entrega_dia, _} <- Integer.parse(entrega.dia),
         {entrega_litros, _} <- Integer.parse(entrega.litros),
         {entrega_grasa, _} <- Integer.parse(entrega.grasa) do
      {:ok,
       %{
         productor: entrega.productor,
         tanque: entrega.tanque,
         dia: entrega_dia,
         litros: entrega_litros,
         grasa: entrega_grasa
       }}
    else
      :error -> {:error, :parse_error}
    end
  end

  # Comprueba si el productor de la entrega existe en la lista de
  # productores.

  # Si el productor existe, devuelve `{:ok, entrega}`.
  # Si no existe, devuelve `{:error, :productor_desconocido}`.

  defp validar_productor(entrega, productores) do
    productor_codigo = entrega.productor

    encontro_productor? =
      Enum.any?(productores, fn productor ->
        productor_codigo === productor.codigo
      end)

    if encontro_productor? do
      {:ok, entrega}
    else
      {:error, :productor_desconocido}
    end
  end


  # Comprueba si el tanque de la entrega existe en la lista de tanques.

  # Si el tanque existe, devuelve `{:ok, entrega}`.
  # Si no existe, devuelve `{:error, :tanque_desconocido}`.

  defp validar_tanque(entrega, tanques) do
    tanque_id = entrega.tanque

    encontro_tanque? =
      Enum.any?(tanques, fn tanque ->
        tanque_id === tanque.id
      end)

    if encontro_tanque? do
      {:ok, entrega}
    else
      {:error, :tanque_desconocido}
    end
  end


  # Valida que el dia de la entrega este dentro del rango permitido.

  # El rango permitido es del dia 1 al dia 6.

  # Si el dia es valido, devuelve `{:ok, entrega}`.
  # Si esta fuera del rango, devuelve `{:error, :dia_invalido}`.

  defp validar_dia(entrega) do
    entrega_dia = entrega.dia

    if entrega_dia in @rango_dias do
      {:ok, entrega}
    else
      {:error, :dia_invalido}
    end
  end


  # Valida que la cantidad de litros de la entrega este dentro del rango
  # permitido.

  # El rango permitido es de 1 a 800 litros.

  # Si la cantidad es valida, devuelve `{:ok, entrega}`.
  # Si esta fuera del rango, devuelve `{:error, :litros_fuera_de_rango}`.

  defp validar_litros(entrega) do
    entrega_litros = entrega.litros

    if entrega_litros in @rango_litros do
      {:ok, entrega}
    else
      {:error, :litros_fuera_de_rango}
    end
  end


  # Valida que el porcentaje de grasa de la entrega este dentro del rango
  # permitido.

  # El porcentaje permitido es de 0 a 15.

  # Si el porcentaje es valido, devuelve `{:ok, entrega}`.
  # Si esta fuera del rango, devuelve `{:error, :porcentaje_invalido}`.

  defp validar_grasa(entrega) do
  entrega_grasa = entrega.grasa

  if entrega_grasa >= 0 and entrega_grasa <= 15 do
    {:ok, entrega}
  else
    {:error, :porcentaje_invalido}
  end
end
end
