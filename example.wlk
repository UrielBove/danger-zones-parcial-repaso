object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
}

class Empleado{
  const habilidad = []
  var property salud = 100
  var property saludCritica = 1

  method estaIncapacitado() = salud < saludCritica
  method habilidades(cual) = habilidad.contains(cual)


  method puedeUsarHabilidad(cual) = not(self.estaIncapacitado()) && self.habilidades(cual)
}

class Espia inherits Empleado{
//son capaces de aprender nuevas habilidades al completar misiones.
override method saludCritica() = 15

}

class Oficinista inherits Empleado{
//si un oficinista sobrevive a una misión gana una estrella.

var property cantEstrellas = 0

override method saludCritica() = 40 - 5 * cantEstrellas
}

class Jefe inherits Empleado{

  const subordinados = [Subordinado]

  override method habilidades(cual) = super(cual) || subordinados.any{s=>s.puedeUsarHabilidad(cual)}
}

class Subordinado inherits Empleado{

}