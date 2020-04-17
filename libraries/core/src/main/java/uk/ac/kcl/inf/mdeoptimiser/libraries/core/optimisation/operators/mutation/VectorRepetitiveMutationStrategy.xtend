package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.mutation

import java.util.ArrayList
import java.util.Random
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.guidance.Solution
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.adaptation.MutationStepSizeStrategy
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorCreateNode
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorFlip
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorMutationOperator
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorRemoveNode
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.RandomSelector
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorConverter
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

class VectorRepetitiveMutationStrategy implements MutationStrategy {
	
	MutationStepSizeStrategy mutationStepSizeStrategy;
	ArrayList<VectorMutationOperator> operators;
	RulegenSpec rgs;
	RandomSelector randomSelector;
	EClass nodeClass;
	EPackage metamodel;	
	String deleteCondition
	
	new (MutationStepSizeStrategy mutationStepSizeStrategy, RulegenSpec rgs, EClass node, EPackage metamodel) {
		this.mutationStepSizeStrategy = mutationStepSizeStrategy;
		this.rgs = rgs
		this.metamodel = metamodel
		this.nodeClass = node
		this.operators = newArrayList		
		this.randomSelector = new RandomSelector(this.operators)
		
		operators.add(new VectorFlip(1))
		if (rgs.getNodeSpec !== null) {
			this.operators.add(new VectorCreateNode(this.nodeClass))
			this.operators.add(new VectorRemoveNode(this.metamodel, this.nodeClass, this.deleteCondition))
			
		}
	
	}
	
	new (MutationStepSizeStrategy mutationStepSizeStrategy, RulegenSpec rgs, EClass node, EPackage metamodel, String deleteCondition) {
		this(mutationStepSizeStrategy, rgs, node, metamodel)
		this.deleteCondition = deleteCondition
	}
	
	override mutate(Solution model) {
		
		val candidateSolution = new Solution(model, new VectorConverter(this.metamodel, this.rgs))
		this.applyOperators(candidateSolution)
		
		return candidateSolution
	}
	
	
	
	
	
	
	
	def applyOperators(Solution solution) {
		val stepSize = this.mutationStepSizeStrategy.nextStepSize
		val model = solution.getVectorModel
		
		for (var step = 1; step <= stepSize; step++) {
			var VectorMutationOperator operator = null
			
			do {
				if (operator === null) {
					operator = randomSelector.getNextOperator
				}
				
				if (operator.mutate(model)) {
					println("Operator applied: " + operator.getName)
				} else {
					operator = null
				}

			} while (operator === null && randomSelector.hasUntriedOperators)
		}
	}
	
	
	
	
	
	
	
	
	def void createNode(VectorEObject model) {
		val newObject = new DynamicEObjectImpl(nodeClass)
		model.addNewVectorObject(newObject)
	}
	
	def void deleteNode(VectorEObject model) {
		val EList<EObject> nodeList = getNodeList(model.getModel)
		if (!nodeList.isEmpty) {
			val toRemove = nodeList.get(new Random().nextInt(nodeList.size))
			nodeList.remove(toRemove)
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
	
	
}