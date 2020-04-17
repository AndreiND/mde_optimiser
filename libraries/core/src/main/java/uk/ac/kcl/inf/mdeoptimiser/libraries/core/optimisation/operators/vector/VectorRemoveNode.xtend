package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import java.util.Iterator
import java.util.Map
import java.util.Random
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
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
				deleteRandomEmpty(veo)
				
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
	
	def deleteRandomEmpty(VectorEObject veo) {
		
		val baseMap = veo.getBaseEObjectMap
		val gene = veo.getGene
		val Iterator<Map.Entry<EObject, Integer>> itr = baseMap.entrySet.iterator
		
		while(itr.hasNext) {
			val entry = itr.next
			if (!gene.contains(entry.value)) {
				val toRemove = entry.getKey as DynamicEObjectImpl
				veo.deleteVectorObject(toRemove)
				return true
			}
			
		}
		println("Remove operator returning false")
		return false
		
		
	}
	
	def randomDelete(VectorEObject veo) {
		val EList<EObject> nodeList = getNodeList(veo.getModel)
		
		if (!nodeList.isEmpty) {
			val DynamicEObjectImpl toRemove = nodeList.get(new Random().nextInt(nodeList.size)) as DynamicEObjectImpl
			
			veo.deleteVectorObject(toRemove)
			return true
			
		}
		println("Remove operator returning false")
		return false
	}
	
	
	override getName() {
		return name
	}
}