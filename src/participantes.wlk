import paises.*
import conocimientos.*
import cumbre.*
import actividades.*
import empresas.*

class Participante {
	const property paisOrigen
	const conocimientos = #{} 
	const commits
	const actividadesRealizadas = []
	
	method esCape()
	
	method cumpleRequisitos() {
		return conocimientos.contains(programacionBasica)
	}
	
	method registrarActividad(unaActividad) = actividadesRealizadas.add(unaActividad)
	
	method registrarConocimiento(unaActividad) = conocimientos.add(unaActividad)
	
	method hacerUnaActividad(unaActividad){
		self.registrarActividad(unaActividad)
		self.registrarConocimiento(unaActividad)
		return commits + unaActividad.commits()
	}
	
	method horasDeActividadesRealizadas() = actividadesRealizadas.sum{actividades => actividades.horas()}
}

class Programador inherits Participante{
	var horasDeCapacitacion
	
	override method esCape() {
		return commits > 500
	}
	
	override method cumpleRequisitos(){
		return super() && commits >= cumbre.commitsDeIngreso()
	}
	
	override method hacerUnaActividad(unaActividad){
		horasDeCapacitacion =+ unaActividad.horas()
		return super(unaActividad)
	}
	
}

class Especialista inherits Participante{
	
	override method esCape() {
		return conocimientos.size() > 2
	}
	
		override method cumpleRequisitos(){
		return super() && commits >= (cumbre.commitsDeIngreso()-100) && conocimientos.contains(objetos)
	}
}

class Gerente inherits Participante{
	const empresa
	var property manejoDeGrupos
	
	override method esCape(){
		return empresa.paisesDondeEsta().size() >= 3
	}
	
	override method cumpleRequisitos(){
		return super() && manejoDeGrupos
	}
}