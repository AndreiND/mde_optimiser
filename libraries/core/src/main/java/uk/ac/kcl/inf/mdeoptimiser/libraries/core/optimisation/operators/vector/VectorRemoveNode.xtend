package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import java.util.Iterator
import java.util.Map
import java.util.Random
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

class VectorRemoveNode implements VectorMutationOperator {
	
	String name = "remove"
	EPackage metamodel
	EClass nodeClass
	String condition
	
	new (EPackage metamodel, EClass nodeClass, String condition) {
		this.metamodel = metamodel
		this.nodeClass = nodeClass
		this.condition = condition
	}
	
	override mutate(VectorEObject veo) {
		switch this.condition {
			case "empty": {
				deleteEmpty(veo)
			} 
			default :{
				randomDelete(veo)
			}
		}
	}
	
	def EList<EObject> getNodeList (EObject model) {
		for (ec:metamodel.getEClassifiers) {
			if (ec instanceof EClass) {
				val eClass = ec as EClass
				for (EReference eref : eClass.getEReferences) {
					if (eref.getEReferenceType.getName.equals(nodeClass.getName) && eref.isContainment) {
						if (model.eGet(eref) !== null) {
							return model.eGet(eref) as EList<EObject>
						} else {
							for (obj:model.eContents) {
								if (obj.eClass.getName.equals(ec.getName)) {
									return obj.eGet(eref) as EList<EObject>
								}
							}
						}
					}
				}
			}
		}
	}
	
	def deleteEmpty(VectorEObject veo) {
		
		var boolean deleted = false
		if (veo.isDynamic) {
			
		} else {
			val Iterator<Map.Entry<EObject, Integer>> itr = veo.getBaseEObjectMap.entrySet.iterator
			var EObject toRemove = null;
			var removedValue = 0
			while(itr.hasNext && deleted == false) {
				println("looper")
				val entry = itr.next
				if (!veo.getGene.contains(entry.getValue)) {
//					println("Value: " + entry.getValue + " is not found inside the gene: ")
//					println(veo.getGene + "\n\n")
					toRemove = entry.getKey
					removedValue = entry.getValue
					veo.getBaseEObjectMap.remove(entry.key)
					deleted = true
				}
			}
			
			val EList<EObject> nodeList = getNodeList(veo.getModel)
			if (!nodeList.isEmpty) {
				// val toRemove = nodeList.get(new Random().nextInt(nodeList.size))
//				println("toRemove:" + toRemove)
//				println("Removed value number: " + removedValue)
				getNodeList(veo.getModel).remove(toRemove)
			}
		}
		veo.fillVector
		return deleted
	}
	
	def randomDelete(VectorEObject veo) {
		val EList<EObject> nodeList = getNodeList(veo.getModel)
		if (!nodeList.isEmpty) {
			val toRemove = nodeList.get(new Random().nextInt(nodeList.size))
			getNodeList(veo.getModel).remove(toRemove)
			return true
		}
		println("Remove operator returning false")
		return false
	}
	
	
	override getName() {
		return name
	}
}