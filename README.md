# Centro de Acopio de Leche

## Integrantes

* Nicolas Santiago Guzman Chala
* Juan Esteban Campos
* Santiago Gomez Rave

## Descripción del proyecto

Este proyecto fue realizado en Elixir como parte de la asignatura de Programación III. El objetivo es desarrollar un programa para manejar la información de un centro de acopio de leche, teniendo en cuenta los productores, los tanques y las entregas de leche que se realizan durante los diferentes días.

Durante el desarrollo del proyecto se trabajaron diferentes conceptos de Elixir, principalmente el manejo de mapas, listas, funciones, módulos, validaciones, estructuras de datos, pattern matching, `with`, funciones privadas y funciones de orden superior.

La idea principal es que el programa pueda recibir la información de las entregas y verificar que los datos sean correctos antes de utilizarlos en los diferentes cálculos del sistema.

## Objetivos

El objetivo principal es aplicar los conceptos vistos en clase mediante un problema relacionado con un centro de acopio de leche.

También se busca organizar el programa de manera modular, de forma que cada módulo tenga una responsabilidad específica y sea más fácil entender, modificar y mantener el código.

Otro objetivo es aprender a trabajar con las estructuras de datos propias de Elixir y utilizar las funciones que proporciona el lenguaje para procesar la información.

## Organización del proyecto

El proyecto se encuentra dividido en diferentes módulos y archivos. Cada uno tiene una función específica dentro del programa.

Una posible organización utilizada durante el desarrollo es la siguiente:

```text
CentroAcopio/
│
├── main.exs
├── validaciones.exs
├── reportes.exs
├── datos.exs
├── calculos.exs
├── README.md
```

El archivo principal se encarga de ejecutar el programa y utilizar las funciones de los diferentes módulos.

El módulo de validaciones se encarga de comprobar que los datos ingresados sean correctos antes de continuar con el procesamiento.

Los demás módulos contienen las funciones relacionadas con los cálculos y el procesamiento de la información del centro de acopio.

Esta separación permite que el código no quede concentrado en un solo archivo y que cada parte del programa tenga una responsabilidad definida.

## Validaciones

Una de las partes importantes del proyecto es la validación de las entregas de leche.

Antes de procesar una entrega, se deben comprobar diferentes datos. Entre ellos se encuentra el productor, el tanque, el día, la cantidad de litros y el porcentaje de grasa.

El proceso de validación se realiza de forma ordenada. Primero se revisa que los datos puedan ser interpretados correctamente y después se realizan las diferentes validaciones.

El flujo utilizado es:

```text
Entrega
   |
   v
Parsear datos
   |
   v
Validar productor
   |
   v
Validar tanque
   |
   v
Validar día
   |
   v
Validar litros
   |
   v
Validar porcentaje de grasa
   |
   v
Entrega válida
```

Para algunas validaciones se utilizan rangos definidos mediante atributos del módulo.

Por ejemplo:

```elixir
@rango_dias 1..6
@rango_litros 1..800
@porcentaje_grasa 0..15
```

Estos rangos permiten establecer los valores que son aceptados por el programa.

También se utiliza `Enum.any?/2` para comprobar si un productor o un tanque existe dentro de la información registrada.

Por ejemplo, para buscar un productor se recorre la lista y se compara el código de la entrega con el código de cada productor.

## Manejo de errores

Cuando alguno de los datos no cumple con las condiciones establecidas, el programa devuelve un error.

Se utilizan tuplas para representar estos resultados. Por ejemplo:

```elixir
{:ok, entrega}
```

cuando la información es válida, o:

```elixir
{:error, :productor_desconocido}
```

cuando el productor no existe.

Algunos de los errores utilizados en el proyecto son:

```text
:parse_error
:productor_desconocido
:tanque_desconocido
:dia_invalido
:litros_fuera_de_rango
:porcentaje_invalido
```

De esta manera, el programa puede identificar qué parte de la información presentó el problema.

## Uso de with

En el proceso de validación se utiliza `with` para organizar las diferentes comprobaciones.

La ventaja de utilizarlo es que cada función puede devolver un resultado y el siguiente paso solamente se ejecuta si el resultado anterior fue correcto.

La estructura general es:

```elixir
with {:ok, entrega} <- primera_validacion(entrega),
     {:ok, entrega} <- segunda_validacion(entrega),
     {:ok, entrega} <- tercera_validacion(entrega) do
  {:ok, entrega}
end
```

Si alguna de las funciones devuelve un error, el proceso se detiene y se devuelve ese error.

Esto permite evitar muchos `if` anidados y hace que el flujo de validación sea más fácil de seguir.

## Mapas de litros diarios

Otra parte del proyecto consiste en obtener la cantidad de litros recibidos durante cada día.

Para representar esta información se utilizan mapas de Elixir, donde la clave representa el día y el valor representa la cantidad de litros.

Un ejemplo sería:

```elixir
%{
  1 => 1200,
  2 => 1500,
  3 => 1800,
  4 => 1000,
  5 => 2000,
  6 => 1300
}
```

En este caso, la clave `1` representa el día 1 y el valor `1200` representa la cantidad de litros recibidos ese día.

Los mapas permiten acceder fácilmente a la información utilizando la clave correspondiente.

## Combinación de información con Map.merge/3

Para la investigación del proyecto se trabaja con la información de otro centro de acopio.

El mapa entregado es:

```elixir
centro_vecino = %{
  1 => 1850.5,
  2 => 2100,
  3 => 1640,
  5 => 2350,
  7 => 800
}
```

La idea es combinar este mapa con el mapa de litros diarios obtenido anteriormente.

Cuando un mismo día aparece en los dos mapas, los valores se deben sumar.

Para esto se utiliza `Map.merge/3`:

```elixir
Map.merge(litros_diarios, centro_vecino, fn _dia, litros1, litros2 ->
  litros1 + litros2
end)
```

El tercer argumento es una función que indica qué se debe hacer cuando los dos mapas tienen la misma clave.

En este caso se suman los litros de los dos centros.

Por ejemplo, si el día 1 tenía:

```text
Centro principal: 1200
Centro vecino:    1850.5
```

el resultado para ese día sería:

```text
3050.5 litros
```

## Qué sucede con Map.merge/2

Si se utilizara `Map.merge/2`, no se podrían sumar los valores de las claves repetidas.

Por ejemplo:

```elixir
Map.merge(%{1 => 1200}, %{1 => 1850.5})
```

daría como resultado:

```elixir
%{1 => 1850.5}
```

El valor que estaba anteriormente para el día 1 sería reemplazado por el valor del segundo mapa.

Esto no sería adecuado para este ejercicio porque necesitamos conservar la información de los dos centros y obtener el total de litros recibidos.

Por esta razón se utiliza `Map.merge/3`, ya que permite definir qué hacer cuando una clave aparece en ambos mapas.

## Qué sucede con el día 7

El día 7 solamente aparece en el mapa del centro vecino.

Cuando una clave aparece solamente en uno de los mapas, `Map.merge/3` la conserva.

Por lo tanto, el día 7 permanece en el resultado con sus 800 litros:

```elixir
7 => 800
```

No se realiza ninguna suma porque no existe información del día 7 en el otro mapa.

## Ranking

Otra parte del proyecto consiste en organizar información relacionada con los resultados obtenidos.

Para esta parte se trabajan las listas y las Keyword Lists de Elixir.

Una Keyword List permite almacenar elementos utilizando una estructura basada en claves y valores.

Un ejemplo es:

```elixir
[
  productor: "P001",
  litros: 500
]
```

Este tipo de estructura permite trabajar con información relacionada y acceder a sus valores mediante las claves correspondientes.

El ranking se realiza utilizando la información obtenida durante el procesamiento de las entregas.

## Pruebas realizadas

Durante el desarrollo del proyecto se realizaron diferentes pruebas ejecutando el programa varias veces y utilizando diferentes datos de entrada.

Estas pruebas permitieron comprobar que las validaciones funcionaran correctamente y que el programa respondiera de manera adecuada cuando los datos eran válidos o cuando se presentaban errores.

También se probaron diferentes casos para comprobar las validaciones de productores, tanques, días, litros y porcentaje de grasa.

Por ejemplo, se realizaron pruebas con productores existentes y productores que no estaban registrados, días dentro y fuera del rango permitido y diferentes cantidades de litros.

También se comprobó el funcionamiento de la combinación de los mapas para verificar que los días repetidos fueran sumados y que los días que solamente aparecían en uno de los mapas fueran conservados.

Las pruebas se realizaron directamente ejecutando el programa y observando los resultados obtenidos en cada caso.

## Conceptos de Elixir utilizados

Durante el desarrollo del proyecto se aplicaron diferentes conceptos vistos en clase.

### Módulos

Los módulos permiten organizar las funciones del programa y separar las responsabilidades.

```elixir
defmodule Validaciones do
```

### Funciones públicas y privadas

Las funciones públicas se pueden utilizar desde otros módulos, mientras que las funciones privadas solamente se utilizan dentro del módulo donde fueron definidas.

Para las funciones privadas se utiliza:

```elixir
defp
```

Esto permite mantener algunas funciones internas y evitar que sean utilizadas directamente desde otras partes del programa.

### Pattern matching

El pattern matching es uno de los conceptos principales de Elixir. Se utiliza para comparar y extraer información de diferentes estructuras.

También se utiliza en el manejo de resultados:

```elixir
{:ok, entrega}
```

y:

```elixir
{:error, motivo}
```

### Enum

El módulo `Enum` permite trabajar con colecciones como listas.

En el proyecto se utiliza, entre otras funciones, `Enum.any?/2` para comprobar si existe un elemento que cumpla una condición.

### Mapas

Los mapas se utilizan para representar información mediante pares de clave y valor.

En este
