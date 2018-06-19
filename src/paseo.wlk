// Nota 8 (ocho).  
// 1) MB.
// 2) B-. Falta manejo de excepciones. 
// 3) B. 
// 4) MB>  
// 5) MB. 
// 6) MB.
// 7) B. Falta abstarcción.
// 8) B. Problemas al modificar el desgaste. No maneja excepciones.
// Tests no andan!
class Prenda {

	var property talle
	var property desgaste
	var property abrigo // ¿Por qué es una property?

	// Nombres confusos, ¿por qué ninios?
	method talleComodo(ninios) {
		return if (talle == ninios.talle()) {
			8
		} else 0
	}

	method desgaste(cantidad) {
		// Sintaxis incorrecta
		desgaste = +cantidad
	}

	method desgaste() {
		// Más fácil con min
		return if (desgaste <= 3) {
			desgaste
		} else 3
	}

	method calcularComodidad(ninios) {
		return self.talleComodo(ninios) - self.desgaste()
	}

	method talle(_talle) {
		talle = _talle
	}

	method nivelDeAbrigo() {
		return abrigo
	}

	method nivelDeCalidad(ninios) {
		return self.calcularComodidad(ninios) + self.nivelDeAbrigo()
	}

	// Debería ser abstracto
	method usar() {
	}

}

class PrendaPar inherits Prenda {

	var property elementoIzquierdo
	var property elementoDerecho

	override method desgaste() {
		return (elementoIzquierdo.desgaste() + elementoDerecho.desgaste()) / 2
	}

	override method calcularComodidad(ninios) {
		return super(ninios) + self.niniosPequeno(ninios)
	}

	method elementoDerecho(elemento) {
		elementoDerecho = elemento
	}

	method elementoIZquierdo(elemento) {
		elementoIzquierdo = elemento
	}

	method niniosPequeno(ninios) {
		return if (ninios.edad() < 4) {
			-1
		} else 0
	}

	method intercambiar(prendaPar) {
		if (self.talle() == prendaPar.talle()) {
			var prenda = elementoDerecho
			self.elementoDerecho(prendaPar.elementoDerecho())
			prendaPar.elementoDerecho(prenda)
		}
		// Falta manejo de excepciones.
	}

	override method nivelDeAbrigo() {
		return (elementoDerecho.abrigo() + elementoIzquierdo.abrigo())
	}

	override method usar() {
		elementoDerecho.desgaste(1.20)
		elementoIzquierdo.desgaste(0.8)
	}

}

class Ropa inherits Prenda {

	override method usar() {
		self.desgaste(1)
	}

}

class RopaLiviana inherits Ropa {

	override method calcularComodidad(ninios) {
		return super(ninios) + 2
	}

	method nivelDeAbrigo(cantidad) {
		abrigo = cantidad
	}

}

class RopaPesada inherits Ropa {
	// Falta abrigo default.
}

class Familia {

	var ninios = #{}

	method listosParaPasear() {
		return ninios.all({ ninio => ninio.listoParaPasear() })
	}

	method prendasInfaltables() {
		return ninios.filter({ ninio => ninio.prendaDeMaximaCalidad() }).asSet()
	}

	method losPequenos() {
		return ninios.filter({ ninio => ninio.edad() < 4 }).asSet() // Falta abstracción esPequenio en ninio.
	}

	method salirAPasear() {
		if (self.listosParaPasear()) {
			ninios.forEach({ ninio => ninio.usarPrendas()})
		}
		// Falta manejo de excepciones
	}

}

class Ninio {

	var property talle
	var property edad
	var property prendas = []

	method listoParaPasear() {
		return self.bienVestido() and self.abrigado() and self.promedioDeCalidad()
	}

	method bienVestido() {
		return prendas.size() >= 5
	}

	method abrigado() {
		return prendas.any({ prenda => prenda.nivelDeAbrigo() >= 3 })
	}

	// Nombre confuso.
	method promedioDeCalidad() {
		return (prendas.sum({ prenda => prenda.nivelDeCalidad(self) }) / prendas.size()) > 8
	}

	method prendaDeMaximaCalidad() {
		return prendas.max({ prenda => prenda.nivelDeCalidad(self) })
	}

	method usarPrendas() {
		prendas.forEach({ prenda => prenda.usar()})
	}

}

class NinioProblematico inherits Ninio {

	var juguete

	override method bienVestido() {
		return prendas.size() >= 4
	}

	method jugueteAcorde() {
		// Podría delegar en juguete
		return self.edad().between(juguete.min(), juguete.mas())
	}

	override method listoParaPasear() {
		return super() and self.jugueteAcorde()
	}

}

class Juguete {

	var property min
	var property max

}

//Objetos usados para los talles.
object xs {

}

object s {

}

object m {

}

object l {

}

object xl {

}

