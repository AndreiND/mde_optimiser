package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

class VectorCreateNode implements VectorMutationOperator {
	
	String name = "create"
	EClass nodeClass
	
	new (EClass nodeClass) {
		this.nodeClass = nodeClass
	}
	
	override boolean mutate(VectorEObject veo) {
		val newObject = new DynamicEObjectImpl(nodeClass)
		veo.addNewVectorObject(newObject)
		return true
	}
	
	override getName() {
		return name
	}

}