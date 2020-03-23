package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.executor

import java.util.Collections
import java.util.LinkedList
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.henshin.model.resource.HenshinResourceSet
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.IModelInitialiser
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.IModelProvider
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.guidance.Solution
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorConverter

class VectorModelProvider implements IModelProvider {
	String modelPath
	HenshinResourceSet resourceSet;
	EObject model;
	IModelInitialiser modelInitialiser;
	VectorConverter vectorConverter;
	
	new (HenshinResourceSet resourceSet, String userModelPath, VectorConverter vc){
		this.modelPath = userModelPath;
		this.resourceSet = resourceSet;
		this.model = resourceSet.createResource(this.modelPath).allContents.head
		vectorConverter = vc
		
	}


	def Solution loadModel(String path) {
//		val resource = resourceSet.createResource(path)
//		
//		resource.load(Collections.EMPTY_MAP)
//		resource.allContents.head
//		
//		if(this.modelInitialiser !== null){
//			return modelInitialiser.initialise(resource.allContents.head)
//		}
		
		return new Solution(vectorConverter.convert(this.model))
	}

	override initialModels(EPackage metamodel) {
		resourceSet.packageRegistry.put(metamodel.nsURI, metamodel)
		
		if(this.modelInitialiser !== null){
			
			return #[loadModel(modelPath)].iterator;
		}

		#[loadModel(modelPath)].iterator
	}
}