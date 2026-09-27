def productores do
  [
    %{codigo: "P01", nombre: "Marta Gómez", transporte: true},
    %{codigo: "P02", nombre: "Luis Cardona", transporte: false},
    %{codigo: "P03", nombre: "Carlos Ramírez", transporte: true},
    %{codigo: "P04", nombre: "Ana María López", transporte: false},
    %{codigo: "P05", nombre: "Jorge Valencia", transporte: true},
    %{codigo: "P06", nombre: "Diana Castaño", transporte: false},
    %{codigo: "P07", nombre: "Andrés Quintero", transporte: true},
    %{codigo: "P08", nombre: "Laura Restrepo", transporte: false},
    %{codigo: "P09", nombre: "Felipe Arias", transporte: true},
    %{codigo: "P10", nombre: "Camila Jaramillo", transporte: false}
  ]
end

def tanques do
  [
    %{id: "T1", nombre: "Tanque Norte", capacidad: 5000},
    %{id: "T2", nombre: "Tanque Central", capacidad: 4000},
    %{id: "T3", nombre: "Tanque Sur", capacidad: 6000},
    %{id: "T4", nombre: "Tanque Occidente", capacidad: 4500}
  ]
end

def entregas do
  [
    # DÍA 1

    %{productor: "P01", tanque: "T1", dia: 1, litros: 240, grasa: 3.8},
    %{productor: "P01", tanque: "T2", dia: 1, litros: 230, grasa: 2.9},
    %{productor: "P02", tanque: "T3", dia: 1, litros: 380, grasa: 3.4},
    %{productor: "P02", tanque: "T4", dia: 1, litros: 160, grasa: 2.7},
    %{productor: "P03", tanque: "T1", dia: 1, litros: 520, grasa: 3.9},
    %{productor: "P03", tanque: "T3", dia: 1, litros: 180, grasa: 3.2},
    %{productor: "P04", tanque: "T2", dia: 1, litros: 300, grasa: 2.6},
    %{productor: "P04", tanque: "T4", dia: 1, litros: 250, grasa: 3.1},
    %{productor: "P05", tanque: "T3", dia: 1, litros: 410, grasa: 3.7},
    %{productor: "P05", tanque: "T1", dia: 1, litros: 120, grasa: 2.4},
    %{productor: "P06", tanque: "T4", dia: 1, litros: 350, grasa: 3.3},
    %{productor: "P06", tanque: "T2", dia: 1, litros: 100, grasa: 2.8},
    %{productor: "P07", tanque: "T1", dia: 1, litros: 450, grasa: 4.1},
    %{productor: "P07", tanque: "T3", dia: 1, litros: 200, grasa: 3.6},

    # DÍA 2

    %{productor: "P08", tanque: "T2", dia: 2, litros: 320, grasa: 3.5},
    %{productor: "P08", tanque: "T4", dia: 2, litros: 210, grasa: 2.9},
    %{productor: "P09", tanque: "T1", dia: 2, litros: 500, grasa: 3.8},
    %{productor: "P09", tanque: "T3", dia: 2, litros: 170, grasa: 3.0},
    %{productor: "P10", tanque: "T4", dia: 2, litros: 280, grasa: 2.7},
    %{productor: "P10", tanque: "T2", dia: 2, litros: 240, grasa: 3.4},
    %{productor: "P01", tanque: "T3", dia: 2, litros: 390, grasa: 3.6},
    %{productor: "P01", tanque: "T4", dia: 2, litros: 140, grasa: 2.8},
    %{productor: "P02", tanque: "T1", dia: 2, litros: 360, grasa: 3.2},
    %{productor: "P02", tanque: "T2", dia: 2, litros: 180, grasa: 2.4},
    %{productor: "P03", tanque: "T3", dia: 2, litros: 470, grasa: 4.0},
    %{productor: "P03", tanque: "T1", dia: 2, litros: 190, grasa: 3.5},
    %{productor: "P04", tanque: "T4", dia: 2, litros: 330, grasa: 3.1},
    %{productor: "P04", tanque: "T2", dia: 2, litros: 190, grasa: 2.6},

    # DÍA 3

    %{productor: "P05", tanque: "T1", dia: 3, litros: 420, grasa: 3.9},
    %{productor: "P05", tanque: "T4", dia: 3, litros: 160, grasa: 3.0},
    %{productor: "P06", tanque: "T2", dia: 3, litros: 300, grasa: 2.8},
    %{productor: "P06", tanque: "T3", dia: 3, litros: 250, grasa: 3.4},
    %{productor: "P07", tanque: "T4", dia: 3, litros: 500, grasa: 4.2},
    %{productor: "P07", tanque: "T2", dia: 3, litros: 180, grasa: 3.7},
    %{productor: "P08", tanque: "T1", dia: 3, litros: 340, grasa: 3.3},
    %{productor: "P08", tanque: "T3", dia: 3, litros: 180, grasa: 2.5},
    %{productor: "P09", tanque: "T2", dia: 3, litros: 460, grasa: 3.8},
    %{productor: "P09", tanque: "T4", dia: 3, litros: 210, grasa: 3.1},
    %{productor: "P10", tanque: "T3", dia: 3, litros: 380, grasa: 2.9},
    %{productor: "P10", tanque: "T1", dia: 3, litros: 220, grasa: 3.6},
    %{productor: "P01", tanque: "T4", dia: 3, litros: 410, grasa: 4.0},
    %{productor: "P01", tanque: "T2", dia: 3, litros: 130, grasa: 2.7},

    # =========================
    # DÍA 4
    # =========================

    %{productor: "P02", tanque: "T3", dia: 4, litros: 400, grasa: 3.5},
    %{productor: "P02", tanque: "T1", dia: 4, litros: 170, grasa: 2.9},
    %{productor: "P03", tanque: "T2", dia: 4, litros: 520, grasa: 4.1},
    %{productor: "P03", tanque: "T4", dia: 4, litros: 190, grasa: 3.6},
    %{productor: "P04", tanque: "T1", dia: 4, litros: 310, grasa: 3.0},
    %{productor: "P04", tanque: "T3", dia: 4, litros: 230, grasa: 2.5},
    %{productor: "P05", tanque: "T4", dia: 4, litros: 440, grasa: 3.8},
    %{productor: "P05", tanque: "T2", dia: 4, litros: 160, grasa: 2.7},
    %{productor: "P06", tanque: "T3", dia: 4, litros: 360, grasa: 3.4},
    %{productor: "P06", tanque: "T1", dia: 4, litros: 210, grasa: 2.6},
    %{productor: "P07", tanque: "T2", dia: 4, litros: 480, grasa: 4.0},
    %{productor: "P07", tanque: "T4", dia: 4, litros: 180, grasa: 3.2},
    %{productor: "P08", tanque: "T1", dia: 4, litros: 350, grasa: 3.7},
    %{productor: "P08", tanque: "T3", dia: 4, litros: 200, grasa: 2.8},

    # DÍA 5

    %{productor: "P09", tanque: "T4", dia: 5, litros: 430, grasa: 3.9},
    %{productor: "P09", tanque: "T2", dia: 5, litros: 190, grasa: 3.3},
    %{productor: "P10", tanque: "T1", dia: 5, litros: 370, grasa: 2.7},
    %{productor: "P10", tanque: "T3", dia: 5, litros: 240, grasa: 3.5},
    %{productor: "P01", tanque: "T2", dia: 5, litros: 450, grasa: 4.1},
    %{productor: "P01", tanque: "T4", dia: 5, litros: 170, grasa: 3.6},
    %{productor: "P02", tanque: "T3", dia: 5, litros: 340, grasa: 3.0},
    %{productor: "P02", tanque: "T1", dia: 5, litros: 220, grasa: 2.4},
    %{productor: "P03", tanque: "T4", dia: 5, litros: 500, grasa: 4.2},
    %{productor: "P03", tanque: "T2", dia: 5, litros: 150, grasa: 3.4},
    %{productor: "P04", tanque: "T3", dia: 5, litros: 380, grasa: 3.2},
    %{productor: "P04", tanque: "T1", dia: 5, litros: 190, grasa: 2.6},
    %{productor: "P05", tanque: "T2", dia: 5, litros: 410, grasa: 3.8},
    %{productor: "P05", tanque: "T4", dia: 5, litros: 220, grasa: 3.1},

    # DÍA 6

    %{productor: "P06", tanque: "T1", dia: 6, litros: 390, grasa: 3.5},
    %{productor: "P06", tanque: "T3", dia: 6, litros: 210, grasa: 2.9},
    %{productor: "P07", tanque: "T4", dia: 6, litros: 530, grasa: 4.3},
    %{productor: "P07", tanque: "T2", dia: 6, litros: 170, grasa: 3.7},
    %{productor: "P08", tanque: "T3", dia: 6, litros: 360, grasa: 3.4},
    %{productor: "P08", tanque: "T1", dia: 6, litros: 230, grasa: 2.5},
    %{productor: "P09", tanque: "T2", dia: 6, litros: 490, grasa: 3.9},
    %{productor: "P09", tanque: "T4", dia: 6, litros: 180, grasa: 3.2},
    %{productor: "P10", tanque: "T1", dia: 6, litros: 400, grasa: 2.8},
    %{productor: "P10", tanque: "T3", dia: 6, litros: 220, grasa: 3.6},
    %{productor: "P01", tanque: "T4", dia: 6, litros: 460, grasa: 4.0},
    %{productor: "P01", tanque: "T2", dia: 6, litros: 190, grasa: 3.3},
    %{productor: "P02", tanque: "T3", dia: 6, litros: 350, grasa: 3.1},
    %{productor: "P02", tanque: "T1", dia: 6, litros: 230, grasa: 2.7}
  ]
end
