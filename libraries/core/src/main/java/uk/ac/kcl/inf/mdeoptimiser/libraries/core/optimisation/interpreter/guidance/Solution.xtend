package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.guidance

import java.util.LinkedList
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
import org.eclipse.emf.ecore.util.EcoreUtil
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorConverter
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

class Solution {
	
	EObject model;
	LinkedList<Map<Integer, String>> transformationsChain;
	
	new(EObject model) {
		this(model, new LinkedList<String>)
	}
	
	new(EObject model, List<String> transformations){
		this.model = model;
		this.transformationsChain = new LinkedList<Map<Integer, String>>()
	}
	
	new(Solution solution) {
		this.model = EcoreUtil.copy(solution.getModel)
		this.transformationsChain = new LinkedList<Map<Integer, String>>(solution.getTransformationsChain);
	}
	
	new (Solution solution, VectorConverter vc) {
		val model = EcoreUtil.copy(solution.getVectorModel.getModel)
		this.model = vc.convert(model)
		this.transformationsChain = new LinkedList<Map<Integer, String>>(solution.getTransformationsChain);
	}
	
	def getModel() {
		if (model instanceof VectorEObject) {
			return model.getModel
		}
		return model;
	}
	
	def VectorEObject getVectorModel() {
		if (this.model instanceof VectorEObject) {
			return model
		}
		return null
	}
	
	def setModel(EObject model, List<String> transformations){
		this.model = model;
	}
	
	def updateModel(EObject model, Map<Integer, String> transformation){
		
		if(this.model === null){
			throw new Exception("Trying to update the model on a solution with a null model.")
		}
		
		this.model = model;
		this.transformationsChain.add(transformation)
	}
	
	def getTransformationsChain(){
		return this.transformationsChain;
	}
}







