object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
}
object mision{
  const property habilidadesNec = []
  var property peligrosidad = 1


  method cumplirMision(asignado){ 
    self.validarHabilidades(asignado)
    asignado.recibirDanio(self.peligrosidad())
    asignado.completarMision(self)
    }

  method validarHabilidades(asignado) = if(not(self.reuneHabilidadesReq(asignado))){
    self.error("No se puede cumplir mision")
  }

  method reuneHabilidadesReq(asignado) = habilidadesNec.all({hab=>asignado.puedeUsarHabilidad(hab)})

  method enseniarHabilidades(empleado){self.habilidadesQueNoPosee(empleado).forEach({hab=>empleado.aprenderHabilidad(hab)})}

  method habilidadesQueNoPosee(empleado) = habilidadesNec.filter({hab=>not (empleado.poseeHabilidad(hab))})
}

object equipo{
  const property integrantes = []

  method puedeUsarHabilidad(hab) =  integrantes.any({integrante=>integrante.puedeUsarHabilidad(hab)})

  method recibirDanio(peligrosidad){
    integrantes.forEach({integrante=>integrante.salud -= 0.3 * mision.peligrosidad})
  }

  method completarMision(mision){}

  method perderVida(){

  }
}

class Empleado{
  const habilidad = []
  var property salud = 100
  var property puesto

  method saludCritica() = puesto.saludCritica()
  
  method estaIncapacitado() = salud < self.saludCritica()
  method poseeHabilidad(cual) = habilidad.contains(cual)

  method puedeUsarHabilidad(cual) = not(self.estaIncapacitado()) && self.poseeHabilidad(cual)

  method recibirDanio(peligrosidad){
    salud -= peligrosidad
  }

 method completarMision(mision){
    if(salud>0){puesto.premio(mision)}
  }

  method aprenderHabilidad(){

  }

  
}

object puestoEspia{
//son capaces de aprender nuevas habilidades al completar misiones.
  method saludCritica() = 15

  method premio(mision, empleado){
    mision.enseniarHabilidades(empleado)
    
  } 

}

class PuestoOficinista{
//si un oficinista sobrevive a una misión gana una estrella.

var property cantEstrellas = 0

method saludCritica() = 40 - 5 * cantEstrellas

method premio(mision){cantEstrellas += 1}

//method cambioPuesto(empleado) {if(self.cantEstrellas()==3){empleado.puesto = puestoEspia}}
}

class Jefe inherits Empleado{
  const subordinados = []

  override method poseeHabilidad(cual) = super(cual) or self.algunSubordinadoPoseeHabilidad(cual)

  method algunSubordinadoPoseeHabilidad(cual) = subordinados.any{subordinado=>subordinado.puedeUsarHabilidad(cual)}
}
