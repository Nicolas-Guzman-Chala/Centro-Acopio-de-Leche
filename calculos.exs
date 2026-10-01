
defmodule Calculos do

  # Función pública que permite solicitar el cálculo de la liquidación
  # de un productor desde otro módulo, por ejemplo, desde el main.
  #
  # Recibe:
  # - productor: código del productor que se quiere liquidar.
  # - productores: lista con la información de todos los productores.
  # - entregas_validas: lista de entregas que pasaron las validaciones.
  #
  # Retorna un mapa con los valores de la liquidación.
  def calcular(productor, productores, entregas_validas) do
    liquidacion(productor, productores, entregas_validas)
  end


  # Calcula el valor económico de una entrega según los litros
  # entregados y el porcentaje de grasa de la leche.
  #
  # Primero se calcula la tarifa base:
  # litros * 1800
  #
  # Después se aplica el ajuste correspondiente según el porcentaje
  # de grasa:
  # - 3.5% o más: aumento del 6%.
  # - Entre 3.0% y menos de 3.5%: sin ajuste.
  # - Entre 2.5% y menos de 3.0%: descuento del 8%.
  # - Menos de 2.5%: descuento del 20%.
  #
  # Es privada porque solo se utiliza dentro del módulo de cálculos.
  defp valor_entrega(litros, grasa) do
    tarifa = litros * 1800

    cond do
      grasa >= 3.5 -> tarifa * 1.06
      grasa >= 3.0 -> tarifa
      grasa >= 2.5 -> tarifa - (tarifa * 0.08)
      grasa < 2.5 -> tarifa - (tarifa * 0.20)
    end
  end


  # Calcula la bonificación por volumen para un productor
  # en un día específico.
  #
  # Primero se filtran las entregas que pertenecen al productor
  # y al día indicado.
  #
  # Luego se extraen únicamente los litros de esas entregas y
  # se suman para obtener el total de litros del día.
  #
  # Si el productor entregó 450 litros o más en ese día,
  # recibe una bonificación de 25.000.
  defp bonificacion_volumen(productor, dia, entregas_validas) do

    litros_dia =
      entregas_validas
      |> Enum.filter(fn entrega ->
        entrega.productor == productor and entrega.dia == dia
      end)
      |> Enum.map(fn entrega -> entrega.litros end)
      |> Enum.sum()

    if litros_dia >= 450 do
      25000
    else
      0
    end
  end


  # Calcula el descuento por transporte del productor.
  #
  # Si el productor NO utiliza el transporte del centro,
  # no se aplica ningún descuento.
  #
  # Si utiliza transporte, se buscan sus entregas válidas,
  # se obtienen los días en los que realizó entregas,
  # se eliminan los días repetidos y finalmente se cuentan.
  #
  # De esta manera, aunque un productor tenga varias entregas
  # el mismo día, el descuento de transporte se cobra una sola vez.
  #
  # Cada día con al menos una entrega válida genera un descuento
  # de 18.000.
  defp descuento_transporte(productor, transporte, entregas_validas) do

    if transporte == false do
      0
    else
      dias_entrega =
        entregas_validas
        |> Enum.filter(fn entrega -> entrega.productor == productor end)
        |> Enum.map(fn entrega -> entrega.dia end)
        |> Enum.uniq()
        |> Enum.count()

      dias_entrega * 18000
    end
  end


  # Realiza la liquidación completa de un productor.
  #
  # Recibe el código del productor, la lista de productores
  # y todas las entregas válidas.
  #
  # Primero obtiene únicamente las entregas correspondientes
  # al productor que se está liquidando.
  defp liquidacion(productor, productores, entregas_validas) do

    entregas_productor =
      entregas_validas
      |> Enum.filter(fn entrega -> entrega.productor == productor end)


    # Calcula el valor total de todas las entregas del productor.
    #
    # Para cada entrega se llama a valor_entrega/2 para calcular
    # su valor según los litros y el porcentaje de grasa.
    # Finalmente se suman todos los valores.
    valor_total =
      entregas_productor
      |> Enum.map(fn entrega ->
        valor_entrega(entrega.litros, entrega.grasa)
      end)
      |> Enum.sum()


    # Busca en la lista de productores la información del productor
    # que se está liquidando.
    datos_productor =
      Enum.find(productores, fn p -> p.codigo == productor end)

    # Obtiene si el productor utiliza o no el transporte del centro.
    transporte = datos_productor.transporte


    # Calcula el descuento correspondiente al transporte.
    descuento =
      descuento_transporte(productor, transporte, entregas_validas)


    # Obtiene los días en los que el productor realizó entregas válidas.
    #
    # Enum.uniq() evita contar dos veces un mismo día si el productor
    # realizó varias entregas durante ese día.
    dias =
      entregas_productor
      |> Enum.map(fn entrega -> entrega.dia end)
      |> Enum.uniq()


    # Calcula la bonificación de cada día y luego suma todas
    # las bonificaciones obtenidas por el productor.
    bonos =
      dias
      |> Enum.map(fn dia ->
        bonificacion_volumen(productor, dia, entregas_validas)
      end)
      |> Enum.sum()


    # La liquidación final se obtiene sumando el valor de las entregas
    # y las bonificaciones, y restando el descuento de transporte.
    liquidacion = valor_total + bonos - descuento

    # Se devuelve un mapa con el resumen de la liquidación.
    %{
      productor: productor,
      valor_entregas: valor_total,
      bonificaciones: bonos,
      descuento: descuento,
      liquidacion: liquidacion
    }
  end

end
