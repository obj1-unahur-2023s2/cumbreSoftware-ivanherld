import conocimientos.*

class Actividad {
	const property tema
	const property horas
	
	method commits() = horas * tema.commitsPorHora()  
}
