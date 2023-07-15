/** completar las clases y objetos */

object pandemia {
	var property fase =0	
}

class Persona {
	var property edad =0
	var property enfermedadePreexistentes=false
	var property trabajos=[]
	var property salidas=[]

	method salario()= trabajos.sum({trabajo=>trabajo.salario()})
	
	method esDeRiesgo()=self.personaMayor() or self.tieneEnfermedad()
	
	method personaMayor()= self.edad()>=65
	
	method tieneEnfermedad()=self.enfermedadePreexistentes()
	
	method trabajoPrincipal()=trabajos.max({trabajo=>trabajo.salario()})
	
	method estaInactivo()=trabajos.all({trabajo=>trabajo.noPresencial()})
	
	method puedeSalirAtrabajar()= not(self.esDeRiesgo() and not self.estaInactivo())
	
	method puedeSalirAcomprar()= not(self.esDeRiesgo())
	
	method puedeSalirArealizarEjercicio()= not(self.esDeRiesgo()) and self.faseCondicion(3)
	
	method faseCondicion(numero)= numero<pandemia.fase()
	
	method puedeSalirAcaminar()= self.puedeSalirArealizarEjercicio() or self.faseCondicion(5)
	
	method salirAtrabajar()=if(self.puedeSalirAtrabajar()){self.agregarAhistorial("salirAtrabajar")}else{return false}
	
	method salirAcomprar()=if(self.puedeSalirAcomprar()){self.agregarAhistorial("salirAcomprar")}else{return false}
	
	method salirArealizarEjercicio()=if(self.puedeSalirArealizarEjercicio()){self.agregarAhistorial("salirArealizarEjercicio")}else{return false}
	
	method agregarAhistorial(salida)= salidas.add(salida)
	
}
class Familia {
	var property integrantes=[]
	
	method salario()=integrantes.sum({integrante=>integrante.salario()})
	
	method ailar()= integrantes.all({integrante=>integrante.esDeRiesgo()})
	
	method trabajosPrincipales()=integrantes.map({integrante=>integrante.trabajoPrincipal()})
	
	method trabajadoresInactivos()=integrantes.filter({integrante=>integrante.estaInactivo()})
	
	method todosAcomprar()=integrantes.forEach({integrante=>integrante.salirAcomprar()})
	
	
}

class Trabajo {
	var property numeroBase=0
	var property bono=0
	var property fasePresencial=0
	
	method noPresencial ()= self.fasePresencial()>pandemia.fase()
	
	method salario(){
		if (self.fasePresencial() <= pandemia.fase()){
			return self.bono()+self.numeroBase()
		}else return self.numeroBase()
		
	}
	
}

class  TrabajoEsencial inherits Trabajo{
	
	override method salario()= self.numeroBase()+self.formulaBono()
	
	method formulaBono()=	self.bono()*((5 - pandemia.fase()) / 4)//bono * ((5 - __fase actual de la pandemia__) / 4 )
}


class TrabajoSanitario inherits TrabajoEsencial {
	override method salario()= super() + 5000
}