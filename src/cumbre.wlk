import paises.*
import participantes.*

object cumbre {
	const paisesAuspiciantes = #{}
	const participantes = []
	var property commitsDeIngreso = 300
	
	method registrarPaisAuspiciante(unPais) = paisesAuspiciantes.add(unPais)
	
	method esConflictivo(unPais) = !paisesAuspiciantes.intersection(unPais.paisesConConflicto()).isEmpty()
	// paisesAuspiciantes.any{pais => unPais.paisesConConflicto().contains{pais} } // podria hacerse con conjuntos 
	
	method registrarIngreso(unaPersona) = participantes.add(unaPersona)
	
	method nacionalidadesDeParticipantes() = participantes.map{persona => persona.paisOrigen()}
	
	method paisesParticipantes() = self.nacionalidadesDeParticipantes().asSet()
	
	method cantidadDeParticipantesDe(unPais) = self.nacionalidadesDeParticipantes().occurrencesOf(unPais)
	
    method paisConMasParticipantes() = self.paisesParticipantes().max{pais => self.cantidadDeParticipantesDe(pais)}

    method paisesExtranjeros() = self.paisesParticipantes().filter{pais => !paisesAuspiciantes.contains(pais)}

    method esRelevante() = participantes.all{persona => persona.esCape()}
    
    method tieneAccesoRestringido(unaPersona) {
    	return self.esConflictivo(unaPersona.paisOrigen()) || ( self.paisesExtranjeros().contains(unaPersona.paisOrigen()) && self.cantidadDeParticipantesDe(unaPersona.paisOrigen()) >= 2 )
    }
    
    method puedeIngresar(unaPersona) {
    	return unaPersona.cumpleRequisitos() && !self.tieneAccesoRestringido(unaPersona)
    }
    
    method darIngreso(unaPersona){
    	if ( not self.puedeIngresar(unaPersona)){
    		self.error("No cumple con el requisito")
    	}
    	return self.registrarIngreso(unaPersona)
    	}
    	
    method esSegura() = participantes.all{persona => self.puedeIngresar(persona)}
}
