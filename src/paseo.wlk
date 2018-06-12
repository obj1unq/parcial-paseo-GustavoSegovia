

//Esta clase no debe existir, 
//está para que el test compile al inicio del examen
//al finalizar el examen hay que borrar esta clase.



class Prenda{
	var property talle
	var property desgaste
	
	var property abrigo
	method talleComodo(ninios){
		return if(talle==ninios.talle()){8}
		else 0
	}
	method desgaste(cantidad){
		desgaste=+cantidad
	}
	method desgaste(){
		return if(desgaste<=3){desgaste}
		else 3
	}
	method calcularComodidad(ninios){
		return  self.talleComodo(ninios)-self.desgaste()
	}
	method talle(_talle){
		talle=_talle
	}
	method nivelDeAbrigo(){
		return abrigo
	}
	method nivelDeCalidad(ninios){
		return self.calcularComodidad(ninios)+self.nivelDeAbrigo()
	}
	method usar(){}
}

class PrendaPar inherits Prenda{
	var property elementoIzquierdo
	var property elementoDerecho
	
	override method desgaste(){
		return (elementoIzquierdo.desgaste()+elementoDerecho.desgaste())/2
	}
	override method calcularComodidad(ninios){
		return super(ninios)+self.niniosPequeno(ninios)
	}	
	method elementoDerecho(elemento){
		elementoDerecho=elemento
	}
	method elementoIZquierdo(elemento){
		elementoIzquierdo=elemento
	}
	method niniosPequeno(ninios){
		return if(ninios.edad()<4){-1}else 0
	}
	method intercambiar(prendaPar){
		if(self.talle()==prendaPar.talle()){
			self.elementoDerecho(prendaPar.elementoDerecho()) 
			prendaPar.elementoDerecho(self.elementoDerecho())
		}
	}
	override method nivelDeAbrigo(){
		return (elementoDerecho.abrigo()+elementoIzquierdo.abrigo())
	}
	override method usar(){
		elementoDerecho.desgaste(1.20)
		elementoIzquierdo.desgaste(0.8)
	}
}

class Ropa inherits Prenda{
	
	override method usar(){
		self.desgaste(1)
	}
}

class RopaLiviana inherits Ropa{
	override method calcularComodidad(ninios){
		return super(ninios)+2
	}
	method nivelDeAbrigo(cantidad){
		abrigo=cantidad
	}
}

class RopaPesada inherits Ropa{
	
}


class Familia {
	var ninios=#{}
	method listosParaPasear(){
		return ninios.all({ninio=>ninio.listoParaPasear()})
	}
	method prendasInfaltables(){
		return ninios.filter({ninio=>ninio.prendaDeMaximaCalidad()}).asSet()	
	}
	method losPequenos(){
		return ninios.filter({ninio=>ninio.edad()<4}).asSet()
	}
	method salirAPasear(){
		if(self.listosParaPasear()){
			ninios.foreach({ninio=>ninio.usarPrendas()})
		}
	}
}

class Ninio{
	var property talle
	var property edad
	var property prendas=[]
	method listoParaPasear(){
		return self.bienVestido() and self.abrigado() and self.promedioDeCalidad()
	}
	method bienVestido(){
		return prendas.size()>=5
	}
	method abrigado(){
		return prendas.any({prenda=>prenda.nivelDeAbrigo()>=3})
	}
	method promedioDeCalidad(){
		return (prendas.sum({prenda=>prenda.nivelDeCalidad(self)})/prendas.size()) > 8
	}
	method prendaDeMaximaCalidad(){
		return prendas.max({prenda=>prenda.nivelDeCalidad()})
	}
	method usarPrendas(){
		prendas.foreach({prenda=>prenda.usar()})
	}
}

class NinioProblematico inherits Ninio{
	var juguete
	override method bienVestido(){
		return prendas.size()>=4
	}
	method jugueteAcorde(){
		return self.edad().between(juguete.min(),juguete.mas())
	}
	override method listoParaPasear(){
		return super() and self.jugueteAcorde()
	}
}

class Juguete{
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
object l{
	
}
object xl{
	
}