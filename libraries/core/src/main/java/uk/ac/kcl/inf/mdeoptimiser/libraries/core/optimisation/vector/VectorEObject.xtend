package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector

import java.util.ArrayList
import java.util.Collections
import java.util.HashMap
import java.util.Iterator
import java.util.Map
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl

class VectorEObject extends DynamicEObjectImpl {
	
	DynamicEObjectImpl model
	// target is the containment reference that holds a list of the objects to be vectorised
	// (target can be an empty list and in this case we should initialise an empty vector)
	EReference target;
	EClass baseClass;
	// relation is the reference that represents the relationship being modelled by the vector
	EReference relation;
	ArrayList<Integer> gene;
	// vectorMap maps Objects to the indices of the gene vector
	Map<Integer, EObject> vectorMap = new HashMap<Integer, EObject>;
	// baseEObjectMap maps the target of the modelled relationship to an integer so it can be expressed numerically in the vector
	Map<EObject, Integer> baseEObjectMap = new HashMap<EObject, Integer>;
	EList<DynamicEObjectImpl> eObjectList;
	int keyCounter;
	String vectorNode;
	boolean dynamic = false
	
	new(DynamicEObjectImpl m, EReference target, EReference relation, String nodeClass, EClass baseClass) {
		this.model = m
		this.target = target
		this.relation = relation
		this.vectorNode = nodeClass
		this.baseClass = baseClass
		this.eObjectList = this.model.eGet(this.target) as EList<DynamicEObjectImpl>
		this.gene = newArrayList
		for (index:eObjectList) {
			gene.add(null)
		}
//		NOTE TO SELF - THE RELATION AT THE END OF THE 0..1 RELATIONSHIP MUST BE THE ONE BEING MUTATED OTHERWISE THE CHROMOSOME WILL NOT HAVE A FIXED LENGTH AND SO WE CANNOT PERFORM BREEDING ON THESE SOLUTIONS
//		THE DYNAMIC CASE DOES HOWEVER WORK FOR JUST MUTATION SO I WILL MAKE IT WORK FOR THAT, AND IF WE DO BREEDING THE SYSTEM SHOULD CHECK DYNAMIC AND RETURN THAT IT IS NOT POSSIBLE 		
//		println("Reference list: " + eObjectList)
//		println("Reference: " + this.relation)
//		println("Reference type: " + this.relation.getEReferenceType)
//		println("Reference container" + this.relation.eContainer)
		
		isDynamic
		mapEObjects
		getNodes
		fillVector
		constructModelFromVector
		if (!dynamic) {keyCounter = baseEObjectMap.size}
		
	}
	
	def mapEObjects() {
		println("INSIDE MAPEOBJECTS: ")
		for (var i = 0; i < eObjectList.size; i++) {
			vectorMap.put(i, eObjectList.get(i))
		}
		if (dynamic) {	
			for (var i = 0; i < eObjectList.size; i++) {
				vectorMap.put(i, eObjectList.get(i))
			}
		}
	}
	
	def isDynamic() {
//		println("INSIDE ISDYNAMIC: ")
//		println("Relation eClass name: " + relation.eContainer)
//		println("VectorNode name: " + vectorNode)
		val containerClass = relation.eContainer as EClass
		if (containerClass.getName.equals(vectorNode)) {
			println("This is dynamic!")
			this.dynamic = true
		}
	}
	
	def void getNodes() {
//		println("INSIDE GETNODES: ")
		var counter = 0
//		println("MODEL ECONTENTS: " + model.eContents)
		for (EObject obj : model.eContents) {
			println("Inside loop")
			if (dynamic) {
				println("DYNAMIC")
//				println("Obj eClass getName: " + obj.eClass.getName)
//				println("Relation ereftype getName: " + relation.getEReferenceType.getName)
				if (matchesEClassName(relation.getEReferenceType.getName, obj.eClass)) {
					baseEObjectMap.put(obj, counter)
					counter++
				}
			} else {
				println("NOT DYNAMIC")
//				println("Obj eClass getName: " + obj.eClass.getName)
//				println("Relation eContainer eClass getName: " + relation.eContainer.eClass.getName)
				if (matchesEClassName(relation.eContainer.eClass.getName, obj.eClass)) {
					baseEObjectMap.put(obj, counter)
					counter++
				}
			}
		}
	}
	
	def fillVector() {
		println("INSIDE FILLVECTOR: ")

		for (entry : vectorMap.entrySet) {
			if (entry.getValue.eGet(relation) === null) {
//				println("VectorMap: " + vectorMap)
//				println("Gene: " + gene)
				gene.set(entry.getKey, null)
			} else {
				// Lookup the relevant eObject in the baseEObjectMap and assign it's relevant integer to the gene
				val objFromVectorMap = entry.getValue.eGet(relation)
				val objFromBaseMap = baseEObjectMap.get(objFromVectorMap)
//				println("objFromVectorMap: " + objFromVectorMap)
//				println("objFromBaseMap: " + objFromBaseMap)
				gene.set(entry.getKey, objFromBaseMap)
			}
		}

//		println("BaseEObjectMap: " + baseEObjectMap)
//		println("vectorMap: " + vectorMap)
//		println("gene: " + gene)
	}
	
	def constructModelFromVector() {	
		val flippedEObjectMap = new HashMap<Integer, EObject>
		for (entry:baseEObjectMap.entrySet) {
			flippedEObjectMap.put(entry.getValue, entry.getKey)
		}
		
		for (entry:vectorMap.entrySet) {
			if (entry.getValue !== null) {
				val value = flippedEObjectMap.get(gene.get(entry.getKey))
				entry.getValue.eSet(relation, value)
			}
		}
		
	}
	
	def allClassNames(EClass ec) {
		var ArrayList<String> list
		if (ec.getEAllSuperTypes !== null) {
			list = new ArrayList<String>
			list.add(ec.getName)
			for (type: ec.getEAllSuperTypes) {
				list.add(type.getName)
			}
		}
//		println("LIST: " + list)
		return list
	}
	
	def boolean matchesEClassName(String name, EClass ec) {
//		println("NAME: " + name)
//		println("CLASS NAME: " + ec.getName)
		for (type : allClassNames(ec)) {
			if (name.equals(type)) {
				return true
			}
		}
		return false
	}
	
	def void addNewVectorObject(DynamicEObjectImpl n) {
		if (dynamic) {
			addToBaseClassContainmentReference(n)
			vectorMap.put(gene.size, n)
			gene.add(null)
		} else {
			if (!this.baseEObjectMap.isEmpty) {
				(model.eGet(target) as EList<DynamicEObjectImpl>).add(n)
				var boolean inserted = false
	
				var ArrayList<Integer> valueList = newArrayList
				for (entry : this.baseEObjectMap.entrySet) {
					valueList.add(entry.getValue)
				}
				val maxValue = Collections.max(valueList)
				println("ValueList: " + valueList)
				val allValues = newArrayList
				for (var i = 0; i <= maxValue;i++) {
					allValues.add(i)
				}
				val Iterator<Integer> itr = allValues.iterator
				while(itr.hasNext && inserted == false) {
					val value = itr.next
					if (!valueList.contains(value)) {
						println("Inserting value: " + value)
						this.baseEObjectMap.put(n, value)
						inserted = true
					}
				}
				
				if (!inserted) {
					println("Inserting value: " + maxValue + 1)
					this.baseEObjectMap.put(n, maxValue + 1)
				}
				
			} else {
				this.baseEObjectMap.put(n, 0)
			}
			

			addToBaseClassContainmentReference(n)
//			baseEObjectMap.put(n, keyCounter)
//			keyCounter++
		}
	}
	
	def void deleteVectorObject(DynamicEObjectImpl n) {
		if (dynamic) {
			for (entry : vectorMap.entrySet) {
				// FILL OUT THIS IMPLEMENTATION IF I HAVE TIME
				if (entry.value.equals(n)) {
					vectorMap.replace(entry.getKey, null)
					fillVector
				}
				
			}
		} else {
			baseEObjectMap.remove(n)
			deleteFromBaseClassContainmentReference(n)
			fillVector()
		}
	}
	
	def void addToBaseClassContainmentReference(DynamicEObjectImpl n) {
		for (eref:model.eClass.getEReferences) {
			if (eref.getEReferenceType.getName.equals(this.baseClass.getName)) {
				(model.eGet(eref) as EList<DynamicEObjectImpl>).add(n)
			}
		}
		for(obj : model.eContents) {
			for(eref : obj.eClass.getEReferences) {
				if (eref.getEReferenceType.getName.equals(this.baseClass.getName)) {
					(obj.eGet(eref) as EList<DynamicEObjectImpl>).add(n)
				}
			}
		}
	}
	
	def void deleteFromBaseClassContainmentReference(DynamicEObjectImpl n) {
		for (eref:model.eClass.getEReferences) {
			if (eref.getEReferenceType.getName.equals(this.baseClass.getName)) {
				(model.eGet(eref) as EList<DynamicEObjectImpl>).remove(n)
			}
		}
		for(obj : model.eContents) {
			for(eref : obj.eClass.getEReferences) {
				if (eref.getEReferenceType.getName.equals(this.baseClass.getName)) {
					(obj.eGet(eref) as EList<DynamicEObjectImpl>).remove(n)
				}
			}
		}
	}
	
	def baseEObjectMapToString() {
		var toReturn = "["
		for (entry : baseEObjectMap.entrySet) {
			
			toReturn += "(" + entry.getKey.eClass.getName + ", " + entry.getValue + "), "
		}
		toReturn += "]"
		return toReturn
	}
	
	def vectorMapToString() {
		var toReturn = "["
		for (entry : vectorMap.entrySet) {
			
			toReturn += "(" + entry.getKey + ", " + entry.getValue.eClass.getName + "), "
		}
		toReturn += "]"
		return toReturn
	}
	
	
	def DynamicEObjectImpl getModel() {
		return this.model
	}
	
	def ArrayList<Integer> getGene() {
		return this.gene
	}
	
	def getVectorMap() {
		return this.vectorMap
	}
	
	def getBaseEObjectMap() {
		return this.baseEObjectMap
	}
	
	def getBaseClass() {
		return this.baseClass
	}
	
	def getTarget() {
		return this.target
	}
	
	def getKeyCounter() {
		return this.keyCounter
	}
	
	def incrementKeyCounter() {
		keyCounter++
	}
	
	
	
}