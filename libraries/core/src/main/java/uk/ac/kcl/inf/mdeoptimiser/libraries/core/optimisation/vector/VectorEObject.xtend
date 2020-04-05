package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector

import java.util.ArrayList
import java.util.HashMap
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
	// relation is the reference that represents the relationship being modelled by the vector
	EReference relation
	ArrayList<Integer> gene;
	// vectorMap maps Objects to the indices of the gene vector
	Map<Integer, EObject> vectorMap = new HashMap<Integer, EObject>;
	// baseEObjectMap maps the target of the modelled relationship to an integer so it can be expressed numerically in the vector
	Map<EObject, Integer> baseEObjectMap = new HashMap<EObject, Integer>;
	EList<DynamicEObjectImpl> eObjectList;
	String vectorNode;
	boolean dynamic = false
	
	new(DynamicEObjectImpl m, EReference target, EReference relation, String nodeClass) {
		this.model = m
		this.target = target
		this.relation = relation
		this.vectorNode = nodeClass
		this.eObjectList = this.model.eGet(this.target) as EList<DynamicEObjectImpl>
		this.gene = newArrayList
		for (index:eObjectList) {
			gene.add(null)
		}
		
		println("Reference list: " + eObjectList)
		println("Reference: " + this.relation)
		println("Reference type: " + this.relation.getEReferenceType)
		println("Reference container" + this.relation.eContainer)
		
		isDynamic
		mapEObjects
		getNodes
		fillVector
		constructModelFromVector
		
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
		println("INSIDE ISDYNAMIC: ")
		println("Relation eClass name: " + relation.eContainer)
		println("VectorNode name: " + vectorNode)
		val containerClass = relation.eContainer as EClass
		if (containerClass.getName.equals(vectorNode)) {
			println("This is dynamic!")
			this.dynamic = true
		}
	}
	
	def void getNodes() {
		println("INSIDE GETNODES: ")
		var counter = 0
		println("MODEL ECONTENTS: " + model.eContents)
		for (EObject obj : model.eContents) {
			println("Inside loop")
			if (dynamic) {
				println("DYNAMIC")
				println("Obj eClass getName: " + obj.eClass.getName)
				println("Relation ereftype getName: " + relation.getEReferenceType.getName)
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

		for (entry: vectorMap.entrySet) {
			if (entry.getValue.eGet(relation) === null) {
				println("VectorMap: " + vectorMap)
				println("Gene: " + gene)
				gene.set(entry.getKey, null)
			} else {
				// Lookup the relevant eObject in the baseEObjectMap and assign it's relevant integer to the gene
				val objFromVectorMap = entry.getValue.eGet(relation)
				val objFromBaseMap = baseEObjectMap.get(objFromVectorMap)
				println("objFromVectorMap: " + objFromVectorMap)
				println("objFromBaseMap: " + objFromBaseMap)
				gene.set(entry.getKey, objFromBaseMap)
			}
		}

		println("BaseEObjectMap: " + baseEObjectMap)
		println("vectorMap: " + vectorMap)
		println("gene: " + gene)
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
		println("LIST: " + list)
		return list
	}
	
	def boolean matchesEClassName(String name, EClass ec) {
		println("NAME: " + name)
		println("CLASS NAME: " + ec.getName)
		for (type:allClassNames(ec)) {
			if (name.equals(type)) {
				return true
			}
		}
		return false
	}
	
	def DynamicEObjectImpl getModel() {
		return this.model
	}
	
	def ArrayList<Integer> getVector() {
		return this.vector
	}
	
	def getVectorMap() {
		return this.vectorMap
	}
	
	def getBaseEObjectMap() {
		return this.baseEObjectMap
	}
}