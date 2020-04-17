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
import org.eclipse.emf.ecore.util.EcoreUtil

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
	String vectorNode;
	boolean dynamic = false
	
	new (DynamicEObjectImpl m, EReference target, EReference relation, String nodeClass, EClass baseClass) {
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
		
		isDynamic
		mapEObjects
		getNodes
		fillVector
		constructModelFromVector
		println("건설로봇 준비 완료!")	
	}
	
	def mapEObjects() {
		
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
		val containerClass = relation.eContainer as EClass
		if (containerClass.getName.equals(vectorNode)) {
			println("This is dynamic!")
			this.dynamic = true
		}
	}
	
	def void getNodes() {
		var counter = 0
		for (EObject obj : model.eContents) {
			if (dynamic) {
				if (matchesEClassName(relation.getEReferenceType.getName, obj.eClass)) {
					baseEObjectMap.put(obj, counter)
					counter++
				}

			} else {
				if (matchesEClassName(relation.getEReferenceType.getName, obj.eClass)) {
					baseEObjectMap.put(obj, counter)
					counter++
				}
			}
		}
	}
	
	def fillVector() {

		for (entry : vectorMap.entrySet) {
			if (entry.getValue.eGet(relation) === null) {
				gene.set(entry.getKey, null)
			} else {
				val objFromVectorMap = entry.getValue.eGet(relation)
				val objFromBaseMap = baseEObjectMap.get(objFromVectorMap)
				gene.set(entry.getKey, objFromBaseMap)
			}
		}
	}
	
	def constructModelFromVector() {	
		val flippedBaseEObjectMap = new HashMap<Integer, EObject>
		for (entry:baseEObjectMap.entrySet) {
			flippedBaseEObjectMap.put(entry.getValue, entry.getKey)
		}
		
		for (entry:vectorMap.entrySet) {
			if (entry.getValue !== null) {
				val value = flippedBaseEObjectMap.get(gene.get(entry.getKey))
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
		return list
	}
	
	def boolean matchesEClassName(String name, EClass ec) {
		for (type : allClassNames(ec)) {
			if (name.equals(type)) {
				return true
			}
		}
		return false
	}
	
	def void addNewVectorObject(DynamicEObjectImpl n) {
		if (dynamic) {
			addToContainmentReference(n)
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
				val allValues = newArrayList
				for (var i = 0; i <= maxValue;i++) {
					allValues.add(i)
				}
				val Iterator<Integer> itr = allValues.iterator
				while(itr.hasNext && inserted == false) {
					val value = itr.next
					if (!valueList.contains(value)) {
						this.baseEObjectMap.put(n, value)
						inserted = true
					}
				}
				
				if (!inserted) {
					this.baseEObjectMap.put(n, maxValue + 1)
				}
				
			} else {
				this.baseEObjectMap.put(n, 0)
			}
			

			addToContainmentReference(n)
		}
	}
	
	def void deleteVectorObject(DynamicEObjectImpl n) {
		if (dynamic) {		
			var index = 0;
			for (entry : vectorMap.entrySet) {
				if (entry.value.equals(n)) {
					index = entry.getKey
				}
			}
			gene.remove(index)
			for (var i = index; i <= vectorMap.size - 1; i++) {
				vectorMap.replace(i, vectorMap.get(i + 1))
			}
			vectorMap.remove(vectorMap.size - 1)
			deleteFromContainmentReference(n)
		} else {
			baseEObjectMap.remove(n)
			EcoreUtil.delete(n)
			fillVector()
		}
	}
	
	def void addToContainmentReference(DynamicEObjectImpl n) {
		for (eref:model.eClass.getEReferences) {
			if (eref.getEReferenceType.getName.equals(this.baseClass.getName) && eref.isContainment) {
				(model.eGet(eref) as EList<DynamicEObjectImpl>).add(n)
			}
		}
		for(obj : model.eContents) {
			for(eref : obj.eClass.getEReferences) {
				if (eref.getEReferenceType.getName.equals(this.baseClass.getName) && eref.isContainment) {
					(obj.eGet(eref) as EList<DynamicEObjectImpl>).add(n)
				}
			}
		}
	}
	
	def void deleteFromContainmentReference(DynamicEObjectImpl n) {
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
	
	def getRelation() {
		return this.relation
	}
	
	def getVectorNode() {
		return this.vectorNode
	}
	
	def getEObjectList() {
		return this.eObjectList
	}
	
	def setBaseModel(DynamicEObjectImpl model) {
		this.model = model
	}
	
}